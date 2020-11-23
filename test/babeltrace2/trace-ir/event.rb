class BTEventTest < Minitest::Test
  def test_class
    stream_beginning_count = 0
    stream_end_count = 0
    event_count = 0
    consume = lambda { |iterator, _|
      mess = iterator.next_messages
      mess.each { |m|
        case m.type
        when :BT_MESSAGE_TYPE_STREAM_BEGINNING
          stream_beginning_count += 1
        when :BT_MESSAGE_TYPE_EVENT
          event_count += 1
        when :BT_MESSAGE_TYPE_STREAM_END
          stream_end_count += 1
        end
      }
    }

    states = [
      :BT_MESSAGE_TYPE_STREAM_BEGINNING,
      :BT_MESSAGE_TYPE_EVENT,
      :BT_MESSAGE_TYPE_STREAM_END ]
    index = 0
    trace_class = nil
    stream_class = nil
    event_class = nil
    trace = nil
    stream = nil

    next_method = lambda { |it, capacity|
      return [] if capacity == 0
      m = case states[index]
        when :BT_MESSAGE_TYPE_STREAM_BEGINNING
          BT2::BTMessageStreamBeginning.new(self_message_iterator: it, stream: stream)
        when :BT_MESSAGE_TYPE_EVENT
          mess = BT2::BTMessageEvent.new(self_message_iterator: it,
                                         event_class: event_class, stream: stream)
          evt = mess.get_event
          assert_instance_of(BT2::BTEvent, evt)
          assert_equal(event_class, evt.get_class)
          assert_equal(stream, evt.stream)
          assert_nil(evt.packet)
          assert_nil(evt.common_context_field)
          assert_instance_of(BT2::BTFieldStructure, evt.payload_field)
          assert_instance_of(BT2::BTFieldStructure, evt.specific_context_field)
          mess
        when :BT_MESSAGE_TYPE_STREAM_END
          BT2::BTMessageStreamEnd.new(self_message_iterator: it, stream: stream)
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
      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      ecls = stream_class.create_event_class
      ecls.name = "eclass"
      ecls.log_level = :BT_EVENT_CLASS_LOG_LEVEL_ERROR
      ecls.emf_uri = "/top/nop/yop"
      s = trace_class.create_structure
      s.append("foo", trace_class.create_bool)
      ecls.payload_field_class = s
      s = trace_class.create_structure
      s.append("bar", trace_class.create_bool)
      ecls.specific_context_field_class = s
      ecls.user_attributes = { "foo" => 15 }
      event_class = ecls
      trace = BT2::BTTrace.new(trace_class: trace_class)
      stream = BT2::BTStream.new(stream_class: stream_class, trace: trace)
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
    assert_equal(1, event_count)
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
    event_class = nil
    GC.start
    assert(fini_done)
  end
end
