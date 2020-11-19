class BTMessageIteratorTest < Minitest::Test

  def setup
    @ctf_fs = BT2::BTPlugin.find("ctf").get_source_component_class_by_name("fs")
    @utils_muxer = BT2::BTPlugin.find("utils").get_filter_component_class_by_name("muxer")
  end

  def test_message_iterator
    event_count = 0
    init_done = false
    comp = nil
    can_seek_beginning = nil
    can_seek_ns_from_origin = nil
    can_seek_forward = nil
    init = lambda { |iterator, _|
      comp = iterator.get_component
      can_seek_beginning = iterator.can_seek_beginning?
      iterator.seek_beginning if can_seek_beginning
      can_seek_ns_from_origin = iterator.can_seek_ns_from_origin?(0)
      iterator.seek_ns_from_origin(0) if can_seek_ns_from_origin
      can_seek_forward = iterator.can_seek_forward?
      init_done = true
    }
    consume = lambda { |iterator, _|
      mess = iterator.next_messages
      mess.each { |m|
        event_count += 1 if m.type == :BT_MESSAGE_TYPE_EVENT
      }
    }
    graph = BT2::BTGraph.new
    comp1 = graph.add(@ctf_fs, "trace", params: {"inputs" => [TRACE_LOCATION]})
    comp2 = graph.add(@utils_muxer, "mux")
    comp3 = graph.add_simple_sink("print", consume, initialize_func: init)
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
    assert_equal(comp2.handle, comp.handle)
    refute_nil(can_seek_beginning)
    refute_nil(can_seek_ns_from_origin)
    refute_nil(can_seek_forward)
  end

end
