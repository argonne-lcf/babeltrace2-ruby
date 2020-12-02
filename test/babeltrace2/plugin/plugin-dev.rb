class BTUserPluginTest < Minitest::Test
  def test_user_plugin
    plugin = BT2.load_plugin_file(PLUGIN_PATH).first
    source = plugin.get_source_component_class("test_source")
    filter = plugin.get_filter_component_class("TestFilter")
    sink = plugin.get_sink_component_class(0)
    graph = BT2::BTGraph.new
    comp1 = graph.add(source, "source")
    comp2 = graph.add(filter, "filter")
    comp3 = graph.add(sink, "sink")
    op = comp1.output_port(0)
    ip = comp2.input_port(0)
    graph.connect_ports(op, ip)
    op = comp2.output_port(0)
    ip = comp3.input_port(0)
    graph.connect_ports(op, ip)
    graph.run
    comp1 = nil
    comp2 = nil
    comp3 = nil
    op = nil
    ip = nil
    graph = nil
    GC.start
    user_comp_source = plugin.user_component_classes.find { |c| c.kind_of? BT2::UserSource }
    user_comp_filter = plugin.user_component_classes.find { |c| c.kind_of? BT2::UserFilter }
    user_comp_sink = plugin.user_component_classes.find { |c| c.kind_of? BT2::UserSink }
    assert(user_comp_source.fini)
    assert(user_comp_source.user_message_iterator_class.fini)
    assert(user_comp_filter.fini)
    assert(user_comp_filter.user_message_iterator_class.fini)
    assert(user_comp_sink.fini)
    assert_equal(1, user_comp_sink.stream_beginning_count)
    assert_equal(1, user_comp_sink.stream_end_count)
  end
end
