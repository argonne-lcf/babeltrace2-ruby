class BTFieldBlobTest < Minitest::Test
  MEDIA_TYPE = "application/octet-stream"
  STATIC_BLOB_ID = "static blob"
  DYNAMIC_BLOB_WO_LENGTH_ID = "dynamic blob wo length"
  DYNAMIC_BLOB_W_LENGTH_ID = "dynamic blob w length"
  LENGTH_FIELD_ID = "_dynamic blob_length"

  def test_blob
    pattern = "\xde\xad\xbe\xef".b
    static_bytes = pattern * 1
    dynamic_wo_bytes = pattern * 2
    dynamic_w_bytes = pattern * 3

    read_back = nil
    states = [
      :BT_MESSAGE_TYPE_STREAM_BEGINNING,
      :BT_MESSAGE_TYPE_PACKET_BEGINNING,
      :BT_MESSAGE_TYPE_PACKET_END,
      :BT_MESSAGE_TYPE_STREAM_END ]
    index = 0
    trace_class = nil
    stream_class = nil
    trace = nil
    stream = nil
    field_class = nil
    packet = nil

    comp_initialize_method = lambda { |self_component, _configuration, _params, _data|
      self_component.add_output_port("p0")
      trace_class = self_component.create_trace_class
      stream_class = trace_class.create_stream_class
      stream_class.set_supports_packets(true)

      field_class = trace_class.create_structure

      # Static blob field class.
      static_blob = trace_class.create_blob(length: static_bytes.bytesize, media_type: MEDIA_TYPE)
      assert_equal(static_bytes.bytesize, static_blob.length)
      assert_equal(MEDIA_TYPE, static_blob.media_type)
      field_class.append(STATIC_BLOB_ID, static_blob)

      # Dynamic blob field class without a length field-location.
      dynamic_blob_wo_length = trace_class.create_blob(media_type: MEDIA_TYPE)
      assert_equal(MEDIA_TYPE, dynamic_blob_wo_length.media_type)
      field_class.append(DYNAMIC_BLOB_WO_LENGTH_ID, dynamic_blob_wo_length)

      # Length field for the with-length dynamic blob (must precede it).
      length = trace_class.create_unsigned
      field_class.append(LENGTH_FIELD_ID, length)

      # Dynamic blob field class with a linked length field-location.
      loc = trace_class.create_field_location(
        :BT_FIELD_LOCATION_SCOPE_PACKET_CONTEXT, LENGTH_FIELD_ID)
      dynamic_blob_w_length = trace_class.create_blob(length: loc, media_type: MEDIA_TYPE)
      assert_equal(MEDIA_TYPE, dynamic_blob_w_length.media_type)
      field_class.append(DYNAMIC_BLOB_W_LENGTH_ID, dynamic_blob_w_length)

      stream_class.packet_context_field_class = field_class

      # Whole-trace-class to_h/from_h round-trip.
      href = trace_class.to_h
      h = Marshal.load(Marshal.dump(href))
      assert_equal(href, BT2::BTTraceClass.from_h(self_component, h).to_h)

      trace = trace_class.create_trace
      stream = stream_class.create_stream(trace)
    }

    next_method = lambda { |it, capacity|
      return [] if capacity == 0
      m = case states[index]
          when :BT_MESSAGE_TYPE_STREAM_BEGINNING
            BT2::BTMessage::StreamBeginning.new(self_message_iterator: it, stream: stream)
          when :BT_MESSAGE_TYPE_STREAM_END
            BT2::BTMessage::StreamEnd.new(self_message_iterator: it, stream: stream)
          when :BT_MESSAGE_TYPE_PACKET_BEGINNING
            packet = BT2::BTPacket.new(stream: stream)
            f = packet.context_field

            # Static blob: fixed length, set at field-class creation.
            static_blob = f[STATIC_BLOB_ID]
            assert_equal(:BT_FIELD_CLASS_TYPE_STATIC_BLOB, static_blob.class_type)
            assert_instance_of(BT2::BTFieldBlobStatic, static_blob)
            assert_equal(static_bytes.bytesize, static_blob.length)
            static_blob.value = static_bytes

            # Dynamic blob without a length field: length set explicitly.
            dynamic_blob_wo_length = f[DYNAMIC_BLOB_WO_LENGTH_ID]
            assert_equal(:BT_FIELD_CLASS_TYPE_DYNAMIC_BLOB_WITHOUT_LENGTH_FIELD, dynamic_blob_wo_length.class_type)
            assert_instance_of(BT2::BTFieldBlobDynamic, dynamic_blob_wo_length)
            refute_kind_of(BT2::BTFieldBlobDynamicWithLengthField, dynamic_blob_wo_length)
            dynamic_blob_wo_length.length = dynamic_wo_bytes.bytesize
            assert_equal(dynamic_wo_bytes.bytesize, dynamic_blob_wo_length.length)
            dynamic_blob_wo_length.value = dynamic_wo_bytes

            # Dynamic blob with a length field: derive the blob length from it.
            length_field = f[LENGTH_FIELD_ID]
            length_field.value = dynamic_w_bytes.bytesize
            dynamic_blob_w_length = f[DYNAMIC_BLOB_W_LENGTH_ID]
            assert_equal(:BT_FIELD_CLASS_TYPE_DYNAMIC_BLOB_WITH_LENGTH_FIELD, dynamic_blob_w_length.class_type)
            assert_instance_of(BT2::BTFieldBlobDynamic, dynamic_blob_w_length)
            assert_kind_of(BT2::BTFieldBlobDynamicWithLengthField, dynamic_blob_w_length)
            dynamic_blob_w_length.length = length_field.value
            assert_equal(length_field.value, dynamic_blob_w_length.length)
            dynamic_blob_w_length.value = dynamic_w_bytes

            # The linked length field-location.
            loc = dynamic_blob_w_length.get_class.length_field_location
            assert_equal(:BT_FIELD_LOCATION_SCOPE_PACKET_CONTEXT, loc.root_scope)
            assert_equal([ LENGTH_FIELD_ID ], loc.items)

            BT2::BTMessage::PacketBeginning.new(self_message_iterator: it, packet: packet)
          when :BT_MESSAGE_TYPE_PACKET_END
            p = packet
            packet = nil
            BT2::BTMessage::PacketEnd.new(self_message_iterator: it, packet: p)
          when nil
            raise StopIteration
          else
            raise "invalid state"
          end
      index += 1
      [m]
    }

    consume = lambda { |iterator, _|
      iterator.next_messages.each do |m|
        next unless m.type == :BT_MESSAGE_TYPE_PACKET_BEGINNING

        f = m.packet.context_field
        read_back = {
          static: f[STATIC_BLOB_ID].value,
          dynamic_wo: f[DYNAMIC_BLOB_WO_LENGTH_ID].value,
          dynamic_w: f[DYNAMIC_BLOB_W_LENGTH_ID].value }
      end
    }

    iter_class = BT2::BTMessageIteratorClass.new(next_method: next_method)
    source_class = BT2::BTComponentClass::Source.new(name: "blob_source", message_iterator_class: iter_class)
    source_class.initialize_method = comp_initialize_method

    # BLOB field classes require MIP >= 1.
    graph = BT2::BTGraph.new(mip_version: 1)
    comp1 = graph.add(source_class, "source")
    comp2 = graph.add_simple_sink("count", consume)
    graph.connect_ports(comp1.output_port(0), comp2.input_port(0))
    graph.run

    assert_equal(static_bytes, read_back[:static])
    assert_equal(dynamic_wo_bytes, read_back[:dynamic_wo])
    assert_equal(dynamic_w_bytes, read_back[:dynamic_w])
  end
end
