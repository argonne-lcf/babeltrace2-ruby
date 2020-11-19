class BTGraphTest < Minitest::Test
  def setup
    @ctf_fs = BT2::BTPlugin.find("ctf").get_source_component_class_by_name("fs")
    @utils_muxer = BT2::BTPlugin.find("utils").get_filter_component_class_by_name("muxer")
    @text_pretty = BT2::BTPlugin.find("text").get_sink_component_class_by_name("pretty")
  end

  def test_graph_add_component
    graph = BT2::BTGraph.new
    comp1 = graph.add_component(@ctf_fs, "trace", params: {"inputs" => [TRACE_LOCATION]})
    assert_instance_of(BT2::BTComponentSource, comp1)
    assert_equal("trace", comp1.name)
    comp2 = graph.add_component(@utils_muxer, "mux")
    assert_instance_of(BT2::BTComponentFilter, comp2)
    assert_equal("mux", comp2.name)
    comp3 = graph.add_component(@text_pretty, "pretty")
    assert_instance_of(BT2::BTComponentSink, comp3)
    assert_equal("pretty", comp3.name)
  end

  def test_connect_port
    graph = BT2::BTGraph.new
    comp1 = graph.add_component(@ctf_fs, "trace", params: {"inputs" => [TRACE_LOCATION]})
    comp2 = graph.add_component(@utils_muxer, "mux")
    comp3 = graph.add_component(@text_pretty, "pretty")
    ops = comp1.output_ports
    ops.each_with_index { |op, i|
      ip = comp2.input_port(i)
      c = graph.connect_ports(op, ip)
      assert_instance_of(BT2::BTConnection, c)
    }

    op = comp2.output_port(0)
    ip = comp3.input_port(0)
    c = graph.connect_ports(op, ip)
    assert_instance_of(BT2::BTConnection, c)
  end

  def test_run
    assert_equal(EXPECTED_OUTPUT, `ruby #{RUN_GRAPH_PATH}`)
  end

  def test_add_simple_sink
    init_done = false
    fini_done = false
    event_count = 0
    init = lambda { |iterator, _|
      init_done = true
    }
    consume = lambda { |iterator, _|
      mess = iterator.next_messages
      mess.each { |m|
        event_count += 1 if m.type == :BT_MESSAGE_TYPE_EVENT
      }
    }
    fini = lambda { |_|
      fini_done = true
    }

    graph = BT2::BTGraph.new
    comp1 = graph.add(@ctf_fs, "trace", params: {"inputs" => [TRACE_LOCATION]})
    comp2 = graph.add(@utils_muxer, "mux")
    comp3 = graph.add_simple_sink("print", consume, initialize_func: init, finalize_func: fini)
    ops = comp1.output_ports
    ops.each_with_index { |op, i|
      ip = comp2.input_port(i)
      graph.connect_ports(op, ip)
    }

    op = comp2.output_port(0)
    ip = comp3.input_port(0)
    graph.connect_ports(op, ip)
    graph.run
    assert_equal(EXPECTED_OUTPUT.lines.count, event_count)
    assert(init_done)
    graph = nil
    comp1 = nil
    comp2 = nil
    comp3 = nil
    ops = op = ip = nil
    GC.start
    assert(fini_done)
  end

  def test_run_once
    event_count = 0
    consume = lambda { |iterator, _|
      mess = iterator.next_messages
      mess.each { |m|
        event_count += 1 if m.type == :BT_MESSAGE_TYPE_EVENT
      }
    }
    graph = BT2::BTGraph.new
    comp1 = graph.add(@ctf_fs, "trace", params: {"inputs" => [TRACE_LOCATION]})
    comp2 = graph.add(@utils_muxer, "mux")
    comp3 = graph.add_simple_sink("print", consume)
    ops = comp1.output_ports
    ops.each_with_index { |op, i|
      ip = comp2.input_port(i)
      graph.connect_ports(op, ip)
    }

    op = comp2.output_port(0)
    ip = comp3.input_port(0)
    graph.connect_ports(op, ip)
    loop do
      graph.run_once
    end
    assert_equal(EXPECTED_OUTPUT.lines.count, event_count)
  end

  def test_port_added_listener
    in_port = 0
    out_port = 0
    list = lambda { |comp, port, _|
      if port.type == :BT_PORT_TYPE_INPUT
        in_port += 1
      else
        out_port += 1
      end
    }

    graph = BT2::BTGraph.new
    graph.add_source_component_output_port_added_listener(list)
    graph.add_filter_component_input_port_added_listener(list)
    graph.add_filter_component_output_port_added_listener(list)
    graph.add_sink_component_input_port_added_listener(list)
    comp1 = graph.add_component(@ctf_fs, "trace", params: {"inputs" => [TRACE_LOCATION]})
    comp2 = graph.add_component(@utils_muxer, "mux")
    comp3 = graph.add_component(@text_pretty, "pretty")
    ops = comp1.output_ports
    cnt = ops.size
    ops.each_with_index { |op, i|
      ip = comp2.input_port(i)
      graph.connect_ports(op, ip)
    }

    op = comp2.output_port(0)
    ip = comp3.input_port(0)
    graph.connect_ports(op, ip)
    assert_equal(cnt + 1, out_port)
    assert_equal(cnt + 2, in_port)
  end

  def test_interrupter
    event_count = 0
    consume = lambda { |iterator, _|
      mess = iterator.next_messages
      mess.each { |m|
        event_count += 1 if m.type == :BT_MESSAGE_TYPE_EVENT
      }
    }
    graph = BT2::BTGraph.new
    comp1 = graph.add(@ctf_fs, "trace", params: {"inputs" => [TRACE_LOCATION]})
    comp2 = graph.add(@utils_muxer, "mux")
    comp3 = graph.add_simple_sink("print", consume)
    ops = comp1.output_ports
    ops.each_with_index { |op, i|
      ip = comp2.input_port(i)
      graph.connect_ports(op, ip)
    }

    op = comp2.output_port(0)
    ip = comp3.input_port(0)
    graph.connect_ports(op, ip)
    int = graph.default_interrupter
    assert_instance_of(BT2::BTInterrupter, int)
    int.set!
    thr = Thread.new { sleep 0.5; int.reset! }
    graph.run
    thr.join
    assert_equal(EXPECTED_OUTPUT.lines.count, event_count)
  end
end
