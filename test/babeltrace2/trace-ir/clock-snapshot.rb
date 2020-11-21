class BTClockSnapshotTest < Minitest::Test
  def test_clock_snapshot
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
    clock_class = nil
    trace = nil
    stream = nil

    next_method = lambda { |it, capacity|
      return [] if capacity == 0
      m = case states[index]
        when :BT_MESSAGE_TYPE_STREAM_BEGINNING
          mess = BT2::BTMessage::StreamBeginning.new(self_message_iterator: it, stream: stream)
          mess.set_default_clock_snapshot(1000)
          cs = mess.get_default_clock_snapshot
          assert_instance_of(BT2::BTClockSnapshot, cs)
          assert_equal(clock_class, cs.clock_class)
          assert_equal(1000, cs.value)
          assert_equal(1000, cs.ns_from_origin)
          mess
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
      clock_class = BT2::BTClockClass.new(self_component: self_component)
      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      stream_class.default_clock_class = clock_class
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
  end
end
