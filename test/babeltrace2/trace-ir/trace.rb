class BTTraceTest < Minitest::Test
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

    dest_listen = lambda { |trace, user_data|
      assert_instance_of(BT2::BTTrace, trace)
      assert_equal(0xdeadbeef, user_data.to_i)
      destroyed += 1
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
      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      trace = BT2::BTTrace.new(trace_class: trace_class)
      assert_equal(0, trace.stream_count)
      assert_nil(trace.get_stream_by_index(0))
      assert_nil(trace.get_stream_by_id(0))
      assert_equal(trace_class, trace.get_class)
      assert_nil(trace.name)
      trace.name = "trace"
      assert_equal("trace", trace.name)
      assert_nil(trace.uuid)
      trace.uuid = BT2::BTUUID.from_string(TRACE_UUID)
      assert_equal(TRACE_UUID, trace.uuid.to_s)
      assert_equal({}, trace.environment)
      trace.environment = { "foo" => 1, "bar" => "baz" }
      assert_equal({}, trace.user_attributes.value)
      assert_equal({ "foo" => 1, "bar" => "baz" }, trace.environment)
      assert_nil(trace.get_environement_entry_by_index(2))
      entry = trace.get_environement_entry_by_index(1)
      assert_equal(["bar", "baz"], [entry[0], entry[1].value])
      assert_equal(1, trace.get_environment_entry_value_by_name("foo").value)
      assert_nil(trace.get_environment_entry_value_by_name("baz"))
      trace.user_attributes = { "foo" => 15 }
      assert_equal({ "foo" => 15 }, trace.user_attributes.value)
      trace.add_destruction_listener(dest_listen, user_data: FFI::Pointer.new(0xdeadbeef))
      id = trace.add_destruction_listener(dest_listen, user_data: FFI::Pointer.new(0xbeef))
      trace.remove_destruction_listener(id)
      stream = BT2::BTStream.new(stream_class: stream_class, trace: trace)
      assert_equal(1, trace.stream_count)
      assert_equal(stream, trace.get_stream_by_index(0))
      assert_equal(stream, trace.get_stream_by_id(stream.id))
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
