class BTConnectionTest
  def setup
    @ctf_fs = BT2::BTPlugin.find("ctf").get_source_component_class_by_name("fs")
    @utils_muxer = BT2::BTPlugin.find("utils").get_filter_component_class_by_name("muxer")
    @text_pretty = BT2::BTPlugin.find("text").get_sink_component_class_by_name("pretty")
  end

  def test_port
    graph = BT2::BTGraph.new
    comp1 = graph.add_component(@ctf_fs, "trace", params: {"inputs" => [TRACE_LOCATION]})
    comp2 = graph.add_component(@utils_muxer, "mux")
    comp3 = graph.add_component(@text_pretty, "pretty")
    ops = comp1.output_ports
    ops.each_with_index { |op, i|
      ip = comp2.input_port(i)
      c = graph.connect_ports(op, ip)
      assert_instance_of(BT2::BTConnection, c)
      assert_equal(c.upstream_port, op)
      assert_equal(c.downstream_port, ip)
    }

    op = comp2.output_port(0)
    ip = comp3.input_port(0)
    c = graph.connect_ports(op, ip)
    assert_instance_of(BT2::BTConnection, c)
    assert_equal(c.upstream_port, op)
    assert_equal(c.downstream_port, ip)
    assert(op.connected?)
    assert(ip.connected?)
  end
end
