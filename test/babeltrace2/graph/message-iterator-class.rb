class BTMessageIteratorClassTest < Minitest::Test
  def test_create_source
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
          iterator.seek_beginning if stream_end_count == 1
          begin
            iterator.seek_ns_from_origin(0) if stream_end_count == 2
          rescue => e
            puts e
            puts e.backtrace
          end
        end
      }
    }

    fini_done = false
    fini = lambda { |self_message_iterator|
      refute(self_message_iterator.handle.null?)
      fini_done = true
    }

    ini_done = false
    ini = lambda { |self_message_iterator, configuration, port|
      refute(self_message_iterator.handle.null?)
      assert_instance_of(BT2::BTSelfMessageIterator, self_message_iterator)
      refute(configuration.handle.null?)
      assert_instance_of(BT2::BTSelfMessageIteratorConfiguration, configuration)
      refute(port.handle.null?)
      assert_instance_of(BT2::BTSelfComponentPortOutput, port)
      ini_done = true
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

    seek_beg = lambda { |it|
      index = 0
    }

    can_seek_beg = lambda { |it|
      true
    }
 
    seek_ns = lambda { |it, ns|
      index = ns
    }

    can_seek_ns = lambda { |it, ns|
      true
    }

    comp_initialize_method = lambda { |self_component, configuration, params, data|
      self_component.add_output_port("p0")
      trace_class = BT2::BTTraceClass.new(self_component: self_component)
      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      trace = BT2::BTTrace.new(trace_class: trace_class)
      stream = BT2::BTStream.new(stream_class: stream_class, trace: trace)
    }

    iter_class = BT2::BTMessageIteratorClass.new(next_method: next_method)
    assert_instance_of(BT2::BTMessageIteratorClass, iter_class)
    refute(iter_class.handle.null?)
    iter_class.initialize_method = ini
    iter_class.finalize_method = fini
    iter_class.set_seek_beginning_methods(seek_beg, can_seek_method: can_seek_beg)
    iter_class.set_seek_ns_from_origin_methods(seek_ns, can_seek_method: can_seek_ns)

    source_class = BT2::BTComponentClass::Source.new(name: "empty_stream", message_iterator_class: iter_class)
    assert_instance_of(BT2::BTComponentClass::Source, source_class)
    refute(source_class.handle.null?)
    source_class.initialize_method = comp_initialize_method

    graph = BT2::BTGraph.new
    comp1 = graph.add(source_class, "source")
    comp2 = graph.add_simple_sink("count", consume)
    op = comp1.output_port(0)
    ip = comp2.input_port(0)
    refute_nil(op)
    refute_nil(ip)
    graph.connect_ports(op, ip)
    graph.run
    assert(ini_done)
    assert_equal(3, stream_beginning_count)
    assert_equal(3, stream_end_count)
    graph = nil
    comp1 = nil
    comp2 = nil
    op = ip = nil
    GC.start
    assert(fini_done)
  end
end

