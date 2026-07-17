class BTFieldLocationTest < Minitest::Test
  def test_field_location
    consume = lambda { |iterator, _| iterator.next_messages }

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

      loc = trace_class.create_field_location(
        :BT_FIELD_LOCATION_SCOPE_EVENT_PAYLOAD, ["len"])
      assert_equal(:BT_FIELD_LOCATION_SCOPE_EVENT_PAYLOAD, loc.root_scope)
      assert_equal(["len"], loc.items)
      assert_equal(1, loc.item_count)
      assert_equal("len", loc[0])
      h = { root_scope: :BT_FIELD_LOCATION_SCOPE_EVENT_PAYLOAD, items: ["len"] }
      assert_equal(h, loc.to_h)
      assert_equal(h, BT2::BTFieldLocation.from_h(trace_class, loc.to_h).to_h)

      loc = trace_class.create_field_location(
        :BT_FIELD_LOCATION_SCOPE_PACKET_CONTEXT, ["outer", "inner"])
      assert_equal(["outer", "inner"], loc.items)

      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      trace = BT2::BTTrace.new(trace_class: trace_class)
      stream = BT2::BTStream.new(stream_class: stream_class, trace: trace)
    }

    iter_class = BT2::BTMessageIteratorClass.new(next_method: next_method)
    source_class = BT2::BTComponentClass::Source.new(name: "field_location", message_iterator_class: iter_class)
    source_class.initialize_method = comp_initialize_method

    graph = BT2::BTGraph.new(mip_version: 1)
    comp1 = graph.add(source_class, "source")
    comp2 = graph.add_simple_sink("count", consume)
    graph.connect_ports(comp1.output_port(0), comp2.input_port(0))
    graph.run
  end
end
