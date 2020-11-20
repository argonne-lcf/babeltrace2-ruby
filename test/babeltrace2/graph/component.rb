class BTComponentTest < Minitest::Test
  def setup
    @ctf_fs = BT2::BTPlugin.find("ctf").get_source_component_class_by_name("fs")
    @utils_muxer = BT2::BTPlugin.find("utils").get_filter_component_class_by_name("muxer")
    @text_pretty = BT2::BTPlugin.find("text").get_sink_component_class_by_name("pretty")
  end

  def test_source
    graph = BT2::BTGraph.new
    comp = graph.add_component(@ctf_fs, "trace", params: {"inputs" => [TRACE_LOCATION]})
    assert_instance_of(BT2::BTComponentSource, comp)
    assert_equal(:BT_COMPONENT_CLASS_TYPE_SOURCE, comp.class_type)
    assert(comp.source?)
    refute(comp.filter?)
    refute(comp.sink?)
    klass = comp.get_class
    assert_instance_of(BT2::BTComponentClassSource, klass)
    assert_equal("trace", comp.name)
    assert_equal(BT2::BTLogging.global_level, comp.logging_level)
    assert_equal(TRACE_STREAM_COUNT, comp.output_port_count)
    comp.output_port_count.times { |i|
      p = comp.output_port(i)
      assert_instance_of(BT2::BTPortOutput, p)
      assert_equal(p, comp.output_port("#{TRACE_UUID} | 0 | #{i}"))
    }
    comp.output_ports.each_with_index { |p, i|
      assert_equal(comp.output_port(i), p)
    }
  end

  def test_filter
    graph = BT2::BTGraph.new
    comp = graph.add_component(@utils_muxer, "mux")
    assert_instance_of(BT2::BTComponentFilter, comp)
    assert_equal(:BT_COMPONENT_CLASS_TYPE_FILTER, comp.class_type)
    assert(comp.filter?)
    refute(comp.source?)
    refute(comp.sink?)
    klass = comp.get_class
    assert_instance_of(BT2::BTComponentClassFilter, klass)
    assert_equal("mux", comp.name)
    assert_equal(BT2::BTLogging.global_level, comp.logging_level)
    assert_equal(1, comp.output_port_count)
    p = comp.output_port(0)
    assert_instance_of(BT2::BTPortOutput, p)
    assert_equal(p, comp.output_port(p.name))
    assert_equal([p], comp.output_ports)
    assert_equal(1, comp.input_port_count)
    p = comp.input_port(0)
    assert_instance_of(BT2::BTPortInput, p)
    assert_equal(p, comp.input_port(p.name))
    assert_equal([p], comp.input_ports)
  end

  def test_sink
    graph = BT2::BTGraph.new
    comp = graph.add_component(@text_pretty, "pretty")
    assert_instance_of(BT2::BTComponentSink, comp)
    assert_equal(:BT_COMPONENT_CLASS_TYPE_SINK, comp.class_type)
    assert(comp.sink?)
    refute(comp.source?)
    refute(comp.filter?)
    klass = comp.get_class
    assert_instance_of(BT2::BTComponentClassSink, klass)
    assert_equal("pretty", comp.name)
    assert_equal(1, comp.input_port_count)
    p = comp.input_port(0)
    assert_instance_of(BT2::BTPortInput, p)
    assert_equal(p, comp.input_port(p.name))
    assert_equal([p], comp.input_ports)
  end
end
