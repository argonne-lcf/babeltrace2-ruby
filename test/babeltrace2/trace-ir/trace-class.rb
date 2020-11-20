class BTTraceClassTest < Minitest::Test

  def test_trace_class
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

    destroyed = 0

    dest_listen = lambda { |trace_class, user_data|
      destroyed += 1
      assert_instance_of(BT2::BTTraceClass, trace_class)
      assert_equal(0xdeadbeef, user_data.to_i)
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
      assert(trace_class.assigns_automatic_stream_class_id?)
      trace_class.assigns_automatic_stream_class_id = false
      refute(trace_class.assigns_automatic_stream_class_id?)
      trace_class.assigns_automatic_stream_class_id = true
      assert(trace_class.assigns_automatic_stream_class_id?)
      assert_equal({}, trace_class.user_attributes.value)
      trace_class.user_attributes = { "foo" => 15 }
      assert_equal({ "foo" => 15 }, trace_class.user_attributes.value)
      trace_class.add_destruction_listener(dest_listen, user_data: FFI::Pointer.new(0xdeadbeef))
      id = trace_class.add_destruction_listener(dest_listen, user_data: FFI::Pointer.new(0xbeef))
      trace_class.remove_destruction_listener(id)
      assert_equal(0, trace_class.stream_class_count)
      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      assert_equal(stream_class, trace_class.get_stream_class_by_index(0))
      assert_equal(stream_class, trace_class.get_stream_class_by_id(stream_class.id))
      assert_equal(1, trace_class.stream_class_count)
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
    assert_equal(1, destroyed)
  end
end
