class BTMessageTest < Minitest::Test
  def test_message
    packet_beginning_count = 0
    packet_end_count = 0
    stream_beginning_count = 0
    stream_end_count = 0
    event_count = 0
    discarded_events_count = 0
    discarded_packets_count = 0
    iterator_inactivity_count = 0
    consume = lambda { |iterator, _|
      mess = iterator.next_messages
      mess.each { |m|
        case m.type
        when :BT_MESSAGE_TYPE_STREAM_BEGINNING
          stream_beginning_count += 1
        when :BT_MESSAGE_TYPE_EVENT
          event_count += 1
        when :BT_MESSAGE_TYPE_STREAM_END
          stream_end_count += 1
        when :BT_MESSAGE_TYPE_PACKET_BEGINNING
          packet_beginning_count += 1
        when :BT_MESSAGE_TYPE_PACKET_END
          packet_end_count += 1
        when :BT_MESSAGE_TYPE_DISCARDED_EVENTS
          discarded_events_count += 1
        when :BT_MESSAGE_TYPE_DISCARDED_PACKETS
          discarded_packets_count += 1
        when :BT_MESSAGE_TYPE_MESSAGE_ITERATOR_INACTIVITY
          iterator_inactivity_count += 1
        end
      }
    }

    states = [
      :BT_MESSAGE_TYPE_STREAM_BEGINNING,
      :BT_MESSAGE_TYPE_PACKET_BEGINNING,
      :BT_MESSAGE_TYPE_EVENT,
      :BT_MESSAGE_TYPE_PACKET_END,
      :BT_MESSAGE_TYPE_DISCARDED_EVENTS,
      :BT_MESSAGE_TYPE_DISCARDED_PACKETS,
      :BT_MESSAGE_TYPE_MESSAGE_ITERATOR_INACTIVITY,
      :BT_MESSAGE_TYPE_STREAM_END ]
    index = 0
    trace_class = nil
    stream_class = nil
    event_class = nil
    clock_class = nil
    packet = nil
    trace = nil
    stream = nil

    next_method = lambda { |it, capacity|
      return [] if capacity == 0
      m = case states[index]
        when :BT_MESSAGE_TYPE_STREAM_BEGINNING
          mess = it.create_stream_beginning(stream)
          assert_equal(:BT_MESSAGE_TYPE_STREAM_BEGINNING, mess.type)
          assert_instance_of(BT2::BTMessageStreamBeginning, mess)
          assert_equal(stream, mess.stream)
          assert_nil(mess.default_clock_snapshot)
          mess.default_clock_snapshot = 0
          assert_equal(0, mess.default_clock_snapshot.get_value)
          assert_equal(clock_class, mess.stream_class_default_clock_class)
          mess
        when :BT_MESSAGE_TYPE_STREAM_END
          mess = it.create_stream_end(stream)
          assert_equal(:BT_MESSAGE_TYPE_STREAM_END, mess.type)
          assert_instance_of(BT2::BTMessageStreamEnd, mess)
          assert_equal(stream, mess.stream)
          assert_nil(mess.default_clock_snapshot)
          mess.default_clock_snapshot = 500
          assert_equal(500, mess.default_clock_snapshot.get_value)
          assert_equal(clock_class, mess.stream_class_default_clock_class)
          mess
        when :BT_MESSAGE_TYPE_PACKET_BEGINNING
          packet = stream.create_packet
          mess = it.create_packet_beginning(packet, clock_snapshot_value: 100)
          assert_equal(:BT_MESSAGE_TYPE_PACKET_BEGINNING, mess.type)
          assert_instance_of(BT2::BTMessagePacketBeginning, mess)
          assert_equal(packet, mess.packet)
          assert_equal(stream, mess.packet.stream)
          assert_equal(100, mess.default_clock_snapshot.get_value)
          assert_equal(clock_class, mess.stream_class_default_clock_class)
          mess
        when :BT_MESSAGE_TYPE_PACKET_END
          p = packet
          packet = nil
          mess = it.create_packet_end(p, clock_snapshot_value: 200)
          assert_equal(:BT_MESSAGE_TYPE_PACKET_END, mess.type)
          assert_instance_of(BT2::BTMessagePacketEnd, mess)
          assert_equal(p, mess.packet)
          assert_equal(stream, mess.packet.stream)
          assert_equal(200, mess.default_clock_snapshot.get_value)
          assert_equal(clock_class, mess.stream_class_default_clock_class)
          mess
        when :BT_MESSAGE_TYPE_EVENT
          mess = it.create_event(event_class, packet, clock_snapshot_value: 105)
          assert_equal(:BT_MESSAGE_TYPE_EVENT, mess.type)
          assert_instance_of(BT2::BTMessageEvent, mess)
          assert_equal(stream, mess.event.stream)
          assert_equal(packet, mess.event.packet)
          assert_equal(105, mess.default_clock_snapshot.get_value)
          assert_equal(clock_class, mess.stream_class_default_clock_class)
          mess
        when :BT_MESSAGE_TYPE_DISCARDED_EVENTS
          mess = it.create_discarded_events(stream, beginning_clock_snapshot_value: 250,
                                                    end_clock_snapshot_value: 275)
          assert_equal(:BT_MESSAGE_TYPE_DISCARDED_EVENTS, mess.type)
          assert_instance_of(BT2::BTMessageDiscardedEvents, mess)
          assert_nil(mess.count)
          mess.count = 4
          assert_equal(4, mess.count)
          assert_equal(250, mess.beginning_default_clock_snapshot.get_value)
          assert_equal(275, mess.end_default_clock_snapshot.get_value)
          assert_equal(clock_class, mess.stream_class_default_clock_class)
          mess
        when :BT_MESSAGE_TYPE_DISCARDED_PACKETS
          mess = it.create_discarded_packets(stream, beginning_clock_snapshot_value: 255,
                                                     end_clock_snapshot_value: 280)
          assert_equal(:BT_MESSAGE_TYPE_DISCARDED_PACKETS, mess.type)
          assert_instance_of(BT2::BTMessageDiscardedPackets, mess)
          assert_nil(mess.count)
          mess.count = 2
          assert_equal(2, mess.count)
          assert_equal(255, mess.beginning_default_clock_snapshot.get_value)
          assert_equal(280, mess.end_default_clock_snapshot.get_value)
          assert_equal(clock_class, mess.stream_class_default_clock_class)
          mess
        when :BT_MESSAGE_TYPE_MESSAGE_ITERATOR_INACTIVITY
          mess = it.create_message_iterator_inactivity(clock_class, 300)
          assert_equal(:BT_MESSAGE_TYPE_MESSAGE_ITERATOR_INACTIVITY, mess.type)
          assert_instance_of(BT2::BTMessageMessageIteratorInactivity, mess)
          assert_equal(300, mess.clock_snapshot.get_value)
          mess
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
      clock_class = BT2::BTClockClass.new(self_component: self_component)
      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      stream_class.default_clock_class = clock_class
      stream_class.set_supports_packets(true, with_beginning_default_clock_snapshot: true,
                                              with_end_default_clock_snapshot: true)
      stream_class.set_supports_discarded_events(true, with_default_clock_snapshots: true)
      stream_class.set_supports_discarded_packets(true, with_default_clock_snapshots: true)
      ecls = stream_class.create_event_class
      ecls.name = "eclass"
      event_class = ecls
      trace = BT2::BTTrace.new(trace_class: trace_class)
      stream = BT2::BTStream.new(stream_class: stream_class, trace: trace)
    }

    fini_done = false
    comp_finalize_method = lambda { |self_component|
      fini_done = true
    }

    iter_class = BT2::BTMessageIteratorClass.new(next_method: next_method)
    source_class = BT2::BTComponentClass::Source.new(name: "empty_stream", message_iterator_class: iter_class)
    source_class.initialize_method = comp_initialize_method
    source_class.finalize_method = comp_finalize_method

    graph = BT2::BTGraph.new
    comp1 = graph.add(source_class, "source")
    comp2 = graph.add_simple_sink("count", consume)
    op = comp1.output_port(0)
    ip = comp2.input_port(0)
    graph.connect_ports(op, ip)
    graph.run
    assert_equal(1, stream_beginning_count)
    assert_equal(1, stream_end_count)
    assert_equal(1, event_count)
    assert_equal(1, packet_beginning_count)
    assert_equal(1, packet_end_count)
    assert_equal(1, discarded_events_count)
    assert_equal(1, discarded_packets_count)
    assert_equal(1, iterator_inactivity_count)
    source_class = nil
    iter_class = nil
    graph = nil
    comp1 = nil
    comp2 = nil
    op = ip = nil
    trace_class = nil
    stream_class = nil
    clock_class = nil
    trace = nil
    stream = nil
    event_class = nil
    GC.start
    assert(fini_done)
  end
end
