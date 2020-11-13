[ '../lib', 'lib' ].each { |d| $:.unshift(d) if File::directory?(d) }
require 'minitest/autorun'
require 'babeltrace2'

class BTGraphTest < Minitest::Test
  def setup
    @trace_path = File.join(__dir__, "thapi-opencl-session-20201021-112005")
    @trace_location = File.join(@trace_path, "ust/uid/1000/64-bit/")
    @ctf_fs = BT2::BTPlugin.find("ctf").get_source_component_class_by_name("fs")
    @utils_muxer = BT2::BTPlugin.find("utils").get_filter_component_class_by_name("muxer")
    @text_pretty = BT2::BTPlugin.find("text").get_sink_component_class_by_name("pretty")
    @expected_output = `babeltrace2 #{@trace_location}`
  end

  def test_graph_add_component
    graph = BT2::BTGraph.new
    comp1 = graph.add_component(@ctf_fs, "trace", params: {"inputs" => [@trace_location]})
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
    comp1 = graph.add_component(@ctf_fs, "trace", params: {"inputs" => [@trace_location]})
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

  def get_graph
    graph = BT2::BTGraph.new
    comp1 = graph.add_component(@ctf_fs, "trace", params: {"inputs" => [@trace_location]})
    comp2 = graph.add_component(@utils_muxer, "mux")
    comp3 = graph.add_component(@text_pretty, "pretty")
    ops = comp1.output_ports
    ops.each_with_index { |op, i|
      ip = comp2.input_port(i)
      graph.connect_ports(op, ip)
    }

    op = comp2.output_port(0)
    ip = comp3.input_port(0)
    graph.connect_ports(op, ip)
    graph
  end

  def test_run
    assert_equal(@expected_output, `ruby #{File.join(__dir__,"run_graph.rb")}`)
  end

  def test_add_simple_sink
    graph = BT2::BTGraph.new
    comp1 = graph.add(@ctf_fs, "trace", params: {"inputs" => [@trace_location]})
    comp2 = graph.add(@utils_muxer, "mux")
    event_count = 0
    consume = lambda { |iterator, _|
      mess = iterator.next_messages
      mess.each { |m|
        event_count += 1 if m.type == :BT_MESSAGE_TYPE_EVENT
      }
    }
    comp3 = graph.add_simple_sink("print", consume)
    ops = comp1.output_ports
    ops.each_with_index { |op, i|
      ip = comp2.input_port(i)
      graph.connect_ports(op, ip)
    }

    op = comp2.output_port(0)
    ip = comp3.input_port(0)
    graph.connect_ports(op, ip)
    graph.run
    assert_equal(@expected_output.lines.count, event_count)
  end
end
