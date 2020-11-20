class BTComponentClassDevTest < Minitest::Test

  def test_source
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

    help_text = "Help text."
    description_text = "Description text."

    comp_initialize_method = lambda { |self_component, configuration, params, data|
      self_component.add_output_port("p0")
      trace_class = BT2::BTTraceClass.new(self_component: self_component)
      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      trace = BT2::BTTrace.new(trace_class: trace_class)
      stream = BT2::BTStream.new(stream_class: stream_class, trace: trace)
    }

    fini_done = false
    comp_finalize_method = lambda { |self_component|
      assert_instance_of(BT2::BTSelfComponentSource, self_component)
      fini_done = true
    }

    comp_mip_method = lambda { |self_component_class, params, initialize_method_data, logging_level, supported_versions|
      supported_versions.add_range(0, 0)
    }

    comp_query_method = lambda { |self_component_class, query_executor, object_name, params, method_data|
      assert_instance_of(BT2::BTSelfComponentClassSource, self_component_class)
      assert_instance_of(BT2::BTPrivateQueryExecutor, query_executor)
      assert_instance_of(FFI::Pointer, method_data)
      case object_name
      when "Yes"
        assert_equal(15, params.value)
        true
      when "No"
        assert_equal(1.0, params.value)
        false
      else
        nil
      end
    }

    port_connected_count = 0
    comp_port_connected_method = lambda { |self_component, self_port, other_port|
      assert_instance_of(BT2::BTSelfComponentSource, self_component)
      assert_instance_of(BT2::BTSelfComponentPortOutput, self_port)
      assert_instance_of(BT2::BTPortInput, other_port)
      port_connected_count += 1
    }

    iter_class = BT2::BTMessageIteratorClass.new(next_method: next_method)
    assert_instance_of(BT2::BTMessageIteratorClass, iter_class)

    source_class = BT2::BTComponentClass::Source.new(name: "empty_stream", message_iterator_class: iter_class)
    assert_instance_of(BT2::BTComponentClass::Source, source_class)
    refute(source_class.handle.null?)
    source_class.initialize_method = comp_initialize_method
    source_class.finalize_method = comp_finalize_method
    source_class.get_supported_mip_versions_method = comp_mip_method
    source_class.query_method = comp_query_method
    source_class.output_port_connected_method= comp_port_connected_method

    source_class.help = help_text
    assert_equal(help_text, source_class.help)
    source_class.description = description_text
    assert_equal(description_text, source_class.description)

    query_executor = BT2::BTQueryExecutor.new(
                       component_class: source_class,
                       object_name: "Yes",
                       params: 15)
    assert_equal(true, query_executor.query.value)

    query_executor = BT2::BTQueryExecutor.new(
                       component_class: source_class,
                       object_name: "No",
                       params: 1.0)
    assert_equal(false, query_executor.query.value)

    graph = BT2::BTGraph.new
    comp1 = graph.add(source_class, "source")
    comp2 = graph.add_simple_sink("count", consume)
    op = comp1.output_port(0)
    ip = comp2.input_port(0)
    graph.connect_ports(op, ip)
    graph.run
    assert_equal(1, stream_beginning_count)
    assert_equal(1, stream_end_count)
    assert_equal(1, port_connected_count)
    graph = nil
    comp1 = nil
    comp2 = nil
    op = ip = nil
    GC.start
    assert(fini_done)
  end

  def test_filter
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

    comp_source_initialize_method = lambda { |self_component, configuration, params, data|
      self_component.add_output_port("p0")
      trace_class = BT2::BTTraceClass.new(self_component: self_component)
      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      trace = BT2::BTTrace.new(trace_class: trace_class)
      stream = BT2::BTStream.new(stream_class: stream_class, trace: trace)
    }

    filter_upstream_it = nil

    filter_next_method = lambda { |it, capacity|
      filter_upstream_it.next_messages
    }

    filter_iter_init_method = lambda { |self_message_iterator, configuration, port|
      filter_upstream_it = self_message_iterator.create_message_iterator(
                             self_message_iterator.component.input_port(0))
    }

    fini_done = false
    comp_finalize_method = lambda { |self_component|
      assert_instance_of(BT2::BTSelfComponentFilter, self_component)
      fini_done = true
    }

    comp_mip_method = lambda { |self_component_class, params, initialize_method_data, logging_level, supported_versions|
      supported_versions.add_range(0, 0)
    }

    comp_query_method = lambda { |self_component_class, query_executor, object_name, params, method_data|
      assert_instance_of(BT2::BTSelfComponentClassFilter, self_component_class)
      assert_instance_of(BT2::BTPrivateQueryExecutor, query_executor)
      assert_instance_of(FFI::Pointer, method_data)
      case object_name
      when "Yes"
        assert_equal(15, params.value)
        true
      when "No"
        assert_equal(1.0, params.value)
        false
      else
        nil
      end
    }

    port_connected_count = 0
    comp_output_port_connected_method = lambda { |self_component, self_port, other_port|
      assert_instance_of(BT2::BTSelfComponentFilter, self_component)
      assert_instance_of(BT2::BTSelfComponentPortOutput, self_port)
      assert_instance_of(BT2::BTPortInput, other_port)
      port_connected_count += 1
    }

    comp_input_port_connected_method = lambda { |self_component, self_port, other_port|
      assert_instance_of(BT2::BTSelfComponentFilter, self_component)
      assert_instance_of(BT2::BTSelfComponentPortInput, self_port)
      assert_instance_of(BT2::BTPortOutput, other_port)
      port_connected_count += 1
    }

    comp_filter_initialize_method = lambda { |self_component, configuration, params, data|
      self_component.add_input_port("fi0")
      self_component.add_output_port("fo0")
    }

    iter_class = BT2::BTMessageIteratorClass.new(next_method: next_method)
    assert_instance_of(BT2::BTMessageIteratorClass, iter_class)

    source_class = BT2::BTComponentClass::Source.new(name: "empty_stream", message_iterator_class: iter_class)
    assert_instance_of(BT2::BTComponentClass::Source, source_class)
    refute(source_class.handle.null?)
    source_class.initialize_method = comp_source_initialize_method

    filter_iter_class = BT2::BTMessageIteratorClass.new(next_method: filter_next_method)
    assert_instance_of(BT2::BTMessageIteratorClass, filter_iter_class)
    filter_iter_class.initialize_method = filter_iter_init_method

    filter_class = BT2::BTComponentClass::Filter.new(name: "repeat", message_iterator_class: filter_iter_class)
    filter_class.initialize_method = comp_filter_initialize_method
    filter_class.finalize_method = comp_finalize_method
    filter_class.get_supported_mip_versions_method = comp_mip_method
    filter_class.query_method = comp_query_method
    filter_class.output_port_connected_method= comp_output_port_connected_method
    filter_class.input_port_connected_method= comp_input_port_connected_method

    query_executor = BT2::BTQueryExecutor.new(
                       component_class: filter_class,
                       object_name: "Yes",
                       params: 15)
    assert_equal(true, query_executor.query.value)

    query_executor = BT2::BTQueryExecutor.new(
                       component_class: filter_class,
                       object_name: "No",
                       params: 1.0)
    assert_equal(false, query_executor.query.value)

    graph = BT2::BTGraph.new
    comp1 = graph.add(source_class, "source")
    comp2 = graph.add(filter_class, "filter")
    comp3 = graph.add_simple_sink("count", consume)
    op = comp1.output_port(0)
    ip = comp2.input_port(0)
    graph.connect_ports(op, ip)
    op = comp2.output_port(0)
    ip = comp3.input_port(0)
    graph.connect_ports(op, ip)
    graph.run
    assert_equal(1, stream_beginning_count)
    assert_equal(1, stream_end_count)
    assert_equal(2, port_connected_count)
    graph = nil
    comp1 = nil
    comp2 = nil
    comp3 = nil
    op = ip = nil
    GC.start
    assert(fini_done)
  end
end
