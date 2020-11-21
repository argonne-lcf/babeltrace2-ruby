class BTStreamClassTest < Minitest::Test
  def test_stream_class
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
        end
      }
    }

    states = [
      :BT_MESSAGE_TYPE_STREAM_BEGINNING,
      :BT_MESSAGE_TYPE_STREAM_END ]
    index = 0
    trace_class = nil
    stream_class = nil
    trace = nil
    stream = nil

    next_method = lambda { |it, capacity|
      return [] if capacity == 0
      m = case states[index]
        when :BT_MESSAGE_TYPE_STREAM_BEGINNING
          BT2::BTMessage::StreamBeginning.new(self_message_iterator: it, stream: stream)
        when :BT_MESSAGE_TYPE_STREAM_END
          BT2::BTMessage::StreamEnd.new(self_message_iterator: it, stream: stream)
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
      trace_class = BT2::BTTraceClass.new(self_component: self_component)
      trace_class.assigns_automatic_stream_class_id = false
      clock_class = BT2::BTClockClass.new(self_component: self_component)
      stream_class = BT2::BTStreamClass.new(trace_class: trace_class, id: 15)
      assert_equal(trace_class, stream_class.trace_class)
      assert_equal(0, stream_class.event_class_count)
      assert_nil(stream_class.get_event_class_by_index(0))
      assert_nil(stream_class.get_event_class_by_id(0))
      assert_equal(15, stream_class.id)
      assert_nil(stream_class.name)
      stream_class.name = "str_cls"
      assert_equal("str_cls", stream_class.name)
      assert_nil(stream_class.default_clock_class)
      stream_class.default_clock_class = clock_class
      assert_nil(stream_class.packet_context_field_class)
      assert(stream_class.assigns_automatic_event_class_id?)
      stream_class.assigns_automatic_event_class_id = false
      refute(stream_class.assigns_automatic_event_class_id?)
      assert(stream_class.assigns_automatic_stream_id?)
      stream_class.assigns_automatic_stream_id = false
      refute(stream_class.assigns_automatic_stream_id?)
      refute(stream_class.supports_packets?)
      refute(stream_class.packets_have_beginning_default_clock_snapshot?)
      refute(stream_class.packets_have_end_default_clock_snapshot?)
      stream_class.set_supports_packets(true, with_beginning_default_clock_snapshot: true,
                                              with_end_default_clock_snapshot: true)
      assert(stream_class.supports_packets?)
      assert(stream_class.packets_have_beginning_default_clock_snapshot?)
      assert(stream_class.packets_have_end_default_clock_snapshot?)
      refute(stream_class.supports_discarded_events?)
      refute(stream_class.discarded_events_have_default_clock_snapshots?)
      stream_class.set_supports_discarded_events(true, with_default_clock_snapshots: true)
      assert(stream_class.supports_discarded_events?)
      assert(stream_class.discarded_events_have_default_clock_snapshots?)
      refute(stream_class.supports_discarded_packets?)
      refute(stream_class.discarded_packets_have_default_clock_snapshots?)
      stream_class.set_supports_discarded_packets(true, with_default_clock_snapshots: true)
      assert(stream_class.supports_discarded_packets?)
      assert(stream_class.discarded_packets_have_default_clock_snapshots?)
      assert_equal({}, stream_class.user_attributes.value)
      stream_class.user_attributes = { "foo" => 15 }
      assert_equal({ "foo" => 15 }, stream_class.user_attributes.value)
      trace = BT2::BTTrace.new(trace_class: trace_class)
      stream = BT2::BTStream.new(stream_class: stream_class, trace: trace, id: 24)
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
    source_class = nil
    iter_class = nil
    graph = nil
    comp1 = nil
    comp2 = nil
    op = ip = nil
    trace_class = nil
    stream_class = nil
    trace = nil
    stream = nil
    GC.start
    assert(fini_done)
  end
end
