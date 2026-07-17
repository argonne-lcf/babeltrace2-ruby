class BTFieldBlobTest < Minitest::Test
  # Round-trip BLOB fields (CTF2 / babeltrace >= 2.1): build a packet context
  # with a static and a dynamic blob, write raw bytes, and read them back.
  def test_blob
    static_bytes = "\xde\xad\xbe\xef".b
    dynamic_bytes = "\x01\x02\x03\x04\x05".b

    read_back = nil
    consume = lambda { |iterator, _|
      iterator.next_messages.each do |m|
        next unless m.type == :BT_MESSAGE_TYPE_PACKET_BEGINNING

        f = m.packet.context_field
        read_back = { static: f["static blob"].value, dynamic: f["dynamic blob"].value }
      end
    }

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

            sf = f["static blob"]
            assert_equal(:BT_FIELD_CLASS_TYPE_STATIC_BLOB, sf.class_type)
            assert_instance_of(BT2::BTFieldBlob, sf)
            assert_equal(static_bytes.bytesize, sf.length)
            sf.value = static_bytes

            sf = f["dynamic blob"]
            assert_equal(:BT_FIELD_CLASS_TYPE_DYNAMIC_BLOB_WITHOUT_LENGTH_FIELD, sf.class_type)
            assert_instance_of(BT2::BTFieldBlobDynamic, sf)
            sf.length = dynamic_bytes.bytesize
            assert_equal(dynamic_bytes.bytesize, sf.length)
            sf.value = dynamic_bytes

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

    comp_initialize_method = lambda { |self_component, _configuration, _params, _data|
      self_component.add_output_port("p0")
      trace_class = self_component.create_trace_class
      stream_class = trace_class.create_stream_class
      stream_class.set_supports_packets(true)

      field_class = trace_class.create_structure
      sb = trace_class.create_static_blob(static_bytes.bytesize, media_type: "application/octet-stream")
      assert_equal(static_bytes.bytesize, sb.length)
      assert_equal("application/octet-stream", sb.media_type)
      field_class.append("static blob", sb)
      db = trace_class.create_dynamic_blob(media_type: "application/octet-stream")
      assert_equal("application/octet-stream", db.media_type)
      field_class.append("dynamic blob", db)
      stream_class.packet_context_field_class = field_class

      trace = trace_class.create_trace
      stream = stream_class.create_stream(trace)
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
    assert_equal(dynamic_bytes, read_back[:dynamic])
  end
end
