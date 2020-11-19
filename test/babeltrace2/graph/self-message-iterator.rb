class BTSelfMessageIteratorTest < Minitest::Test

  def test_self_message_iterator
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

    ini_done = false
    ini = lambda { |self_message_iterator, configuration, port|
      p = self_message_iterator.port
      assert_equal(p.handle, port.handle)
      configuration.can_seek_forward = true
      assert(self_message_iterator.can_seek_forward?)
      configuration.can_seek_forward = false
      refute(self_message_iterator.can_seek_forward?)
      assert(self_message_iterator.data.null?)
      self_message_iterator.data= FFI::Pointer.new(0xdeadbeef)
      assert_equal(0xdeadbeef, self_message_iterator.data.to_i)
      refute(self_message_iterator.interrupted?)
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

    comp_initialize_method = lambda { |self_component, configuration, params, data|
      self_component.add_output_port("p0")
      trace_class = BT2::BTTraceClass.new(self_component: self_component)
      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      trace = BT2::BTTrace.new(trace_class: trace_class)
      stream = BT2::BTStream.new(stream_class: stream_class, trace: trace)
    }

    iter_class = BT2::BTMessageIteratorClass.new(next_method: next_method)
    iter_class.initialize_method = ini
    source_class = BT2::BTComponentClass::Source.new(name: "empty_stream", message_iterator_class: iter_class)
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
    assert_equal(1, stream_beginning_count)
    assert_equal(1, stream_end_count)
  end

end

