class BTPortTest < Minitest::Test
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
      assert_instance_of(BT2::BTPortOutput, op)
      assert(op.output?)
      refute(op.input?)
      refute(op.connected?)
      assert_nil(op.connection)
      assert_equal(comp1, op.component)
      assert_equal("#{TRACE_UUID} | 0 | #{i}", op.name)

      ip = comp2.input_port(i)
      assert_instance_of(BT2::BTPortInput, ip)
      assert(ip.input?)
      refute(ip.output?)
      refute(ip.connected?)
      assert_nil(ip.connection)
      assert_equal(comp2, ip.component)
      assert_equal("in#{i}", ip.name)

      c = graph.connect_ports(op, ip)
      assert_instance_of(BT2::BTConnection, c)
      assert_equal(c.handle, op.connection.handle)
      assert_equal(c.handle, ip.connection.handle)
      assert(op.connected?)
      assert(ip.connected?)
    }

    op = comp2.output_port(0)
    assert_instance_of(BT2::BTPortOutput, op)
    assert(op.output?)
    refute(op.input?)
    refute(op.connected?)
    assert_nil(op.connection)
    assert_equal(comp2, op.component)
    assert_equal("out", op.name)

    ip = comp3.input_port(0)
    assert_instance_of(BT2::BTPortInput, ip)
    assert(ip.input?)
    refute(ip.output?)
    refute(ip.connected?)
    assert_nil(ip.connection)
    assert_equal(comp3, ip.component)
    assert_equal("in", ip.name)

    c = graph.connect_ports(op, ip)
    assert_instance_of(BT2::BTConnection, c)
    assert_equal(c.handle, op.connection.handle)
    assert_equal(c.handle, ip.connection.handle)
    assert(op.connected?)
    assert(ip.connected?)
  end

end
