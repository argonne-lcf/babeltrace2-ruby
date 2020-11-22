class BTFieldTest < Minitest::Test
  def test_field
    packet_beginning_count = 0
    packet_end_count = 0
    stream_beginning_count = 0
    stream_end_count = 0
    consume = lambda { |iterator, _|
      mess = iterator.next_messages
      mess.each { |m|
        case m.type
        when :BT_MESSAGE_TYPE_STREAM_BEGINNING
          stream_beginning_count += 1
        when :BT_MESSAGE_TYPE_STREAM_END
          stream_end_count += 1
        when :BT_MESSAGE_TYPE_PACKET_BEGINNING
          packet_beginning_count += 1
        when :BT_MESSAGE_TYPE_PACKET_END
          packet_end_count += 1
        end
      }
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
          assert_equal(stream, packet.stream)
          f = packet.context_field
          assert_equal(:BT_FIELD_CLASS_TYPE_STRUCTURE, f.class_type)
          assert_equal(field_class, f.get_class)
          assert_equal(18, f.member_count)
          BT2::BTMessage::PacketBeginning.new(self_message_iterator: it, packet: packet, clock_snapshot_value: 100)
        when :BT_MESSAGE_TYPE_PACKET_END
          p = packet
          packet = nil
          BT2::BTMessage::PacketEnd.new(self_message_iterator: it, packet: p, clock_snapshot_value: 200)
        when nil
          raise StopIteration
        else
          raise "invalid state"
        end
      index += 1
      [m]
    }

    comp_initialize_method = lambda { |self_component, configuration, params, data|
      self_component.add_output_port("p0")
      trace_class = self_component.create_trace_class
      clock_class = self_component.create_clock_class
      stream_class = trace_class.create_stream_class
      stream_class.default_clock_class = clock_class
      stream_class.set_supports_packets(true, with_beginning_default_clock_snapshot: true,
                                              with_end_default_clock_snapshot: true)
      field_class = trace_class.create_structure
      field_class.append("bool", b = trace_class.create_bool)
      field_class.append("bit array", trace_class.create_bit_array(16))
      field_class.append("unsigned", u = trace_class.create_unsigned)
      field_class.append("signed", s = trace_class.create_signed)
      field_class.append("single", trace_class.create_single)
      field_class.append("double", trace_class.create_double)
      field_class.append("unsigned enum", trace_class.create_unsigned_enum)
      field_class.append("signed enum", trace_class.create_unsigned_enum)
      field_class.append("string", trace_class.create_string)
      field_class.append("static array", trace_class.create_array(trace_class.create_bool, length: 15))
      field_class.append("dynamic array", trace_class.create_array(trace_class.create_bool))
      field_class.append("option wo select", trace_class.create_option(
        trace_class.create_bool))
      field_class.append("option w select bool", trace_class.create_option(
        trace_class.create_bool, selector_field_class: b))
      field_class.append("option w select unsigned", trace_class.create_option(
        trace_class.create_bool, selector_field_class: u, ranges: [1..15]))
      field_class.append("option w select signed", trace_class.create_option(
        trace_class.create_bool, selector_field_class: s, ranges: [-15..15]))
      field_class.append("variant wo select", trace_class.create_variant)
      field_class.append("variant w select unsigned", trace_class.create_variant(
        selector_field_class: u))
      field_class.append("variant w select signed", trace_class.create_variant(
        selector_field_class: s))
      stream_class.packet_context_field_class = field_class
      trace = trace_class.create_trace
      stream = stream_class.create_stream(trace)
    }

    fini_done = false
    comp_finalize_method = lambda { |self_component|
      fini_done = true
    }

    iter_class = BT2::BTMessageIteratorClass.new(next_method: next_method)
    source_class = BT2::BTComponentClass::Source.new(name: "empty_stream", message_iterator_class: iter_class)
    source_class.initialize_method = comp_initialize_method
    source_class.finalize_method = comp_finalize_method

    graph = BT2::BTGraph.new
    comp1 = graph.add(source_class, "source")
    comp2 = graph.add_simple_sink("count", consume)
    op = comp1.output_port(0)
    ip = comp2.input_port(0)
    graph.connect_ports(op, ip)
    graph.run
    assert_equal(1, stream_beginning_count)
    assert_equal(1, stream_end_count)
    assert_equal(1, packet_beginning_count)
    assert_equal(1, packet_end_count)
    source_class = nil
    iter_class = nil
    graph = nil
    comp1 = nil
    comp2 = nil
    op = ip = nil
    trace_class = nil
    stream_class = nil
    field_class = nil
    trace = nil
    stream = nil
    GC.start
    assert(fini_done)
  end
end
