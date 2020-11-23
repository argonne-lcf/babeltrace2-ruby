module Babeltrace2

  attach_function :bt_self_message_iterator_borrow_component,
                  [ :bt_self_message_iterator_handle ],
                  :bt_self_component_handle

  attach_function :bt_self_message_iterator_borrow_port,
                  [ :bt_self_message_iterator_handle ],
                  :bt_self_component_port_output_handle

  attach_function :bt_self_message_iterator_set_data,
                  [ :bt_self_message_iterator_handle, :pointer ],
                  :void

  attach_function :bt_self_message_iterator_get_data,
                  [ :bt_self_message_iterator_handle ],
                  :pointer

  attach_function :bt_self_message_iterator_is_interrupted,
                  [ :bt_self_message_iterator_handle ],
                  :bt_bool

  class BTSelfMessageIterator < BTMessageIterator
    def get_component
      handle = Babeltrace2.bt_self_message_iterator_borrow_component(@handle)
      BTSelfComponent.from_handle(handle)
    end
    alias component get_component

    def get_port
      handle = Babeltrace2.bt_self_message_iterator_borrow_port(@handle)
      BTSelfComponentPortOutput.new(handle, retain: true)
    end
    alias port get_port

    def set_data(user_data)
      Babeltrace2.bt_self_message_iterator_set_data(@handle, user_data)
      self
    end

    def data=(user_data)
      Babeltrace2.bt_self_message_iterator_set_data(@handle, user_data)
      user_data
    end

    def get_data
      Babeltrace2.bt_self_message_iterator_get_data(@handle)
    end
    alias data get_data

    def is_interrupted
      Babeltrace2.bt_self_message_iterator_is_interrupted(@handle) != BT_FALSE
    end
    alias interrupted? is_interrupted

    def create_message_stream_beginning(stream)
      BTMessageStreamBeginning.new(self_message_iterator: @handle, stream: stream)
    end
    alias create_stream_beginning_message create_message_stream_beginning
    alias create_stream_beginning create_message_stream_beginning

    def create_message_stream_end(stream)
      BTMessageStreamEnd.new(self_message_iterator: @handle, stream: stream)
    end
    alias create_stream_end_message create_message_stream_end
    alias create_stream_end create_message_stream_end

    def create_message_event(event_class, stream_or_packet, clock_snapshot_value: nil)
      case stream_or_packet
      when BTStream
        stream = stream_or_packet
        packet = nil
      when BTPacket
        stream = nil
        packet = stream_or_packet
      else
        raise "invalid stream or packet"
      end
      BTMessageEvent.new(self_message_iterator: @handle, event_class: event_class,
                         stream: stream, clock_snapshot_value: clock_snapshot_value,
                         packet: packet)
    end
    alias create_event_message create_message_event
    alias create_event create_message_event

    def create_message_packet_beginning(packet, clock_snapshot_value: nil)
      BTMessagePacketBeginning.new(self_message_iterator: @handle, packet: packet,
                                   clock_snapshot_value: clock_snapshot_value)
    end
    alias create_packet_beginning_message create_message_packet_beginning
    alias create_packet_beginning create_message_packet_beginning

    def create_message_packet_end(packet, clock_snapshot_value: nil)
      BTMessagePacketEnd.new(self_message_iterator: @handle, packet: packet,
                             clock_snapshot_value: clock_snapshot_value)
    end
    alias create_packet_end_message create_message_packet_end
    alias create_packet_end create_message_packet_end

    def create_message_discarded_events(stream, beginning_clock_snapshot_value: nil,
                                                end_clock_snapshot_value: nil)
      BTMessageDiscardedEvents.new(self_message_iterator: @handle, stream: stream,
        beginning_clock_snapshot_value: beginning_clock_snapshot_value,
        end_clock_snapshot_value: end_clock_snapshot_value)
    end
    alias create_discarded_events_message create_message_discarded_events
    alias create_discarded_events create_message_discarded_events

    def create_message_discarded_packets(stream, beginning_clock_snapshot_value: nil,
                                                 end_clock_snapshot_value: nil)
      BTMessageDiscardedPackets.new(self_message_iterator: @handle, stream: stream,
        beginning_clock_snapshot_value: beginning_clock_snapshot_value,
        end_clock_snapshot_value: end_clock_snapshot_value)
    end
    alias create_discarded_packets_message create_message_discarded_packets
    alias create_discarded_packets create_message_discarded_packets

    def create_message_message_iterator_inactivity(clock_class, clock_snapshot_value)
      BTMessageMessageIteratorInactivity.new(self_message_iterator: @handle,
                                             clock_class: clock_class,
                                             clock_snapshot_value: clock_snapshot_value)
    end
    alias create_message_iterator_inactivity_message create_message_message_iterator_inactivity
    alias create_message_iterator_inactivity create_message_message_iterator_inactivity
  end

  attach_function :bt_self_message_iterator_configuration_set_can_seek_forward,
                  [ :bt_self_message_iterator_configuration_handle, :bt_bool ],
                  :void

  class BTSelfMessageIterator
    class Configuration < BTObject
      def set_can_seek_forward(can_seek_forward)
        Babeltrace2.bt_self_message_iterator_configuration_set_can_seek_forward(
          @handle, can_seek_forward ? BT_TRUE : BT_FALSE)
        self
      end

      def can_seek_forward=(can_seek_forward)
        Babeltrace2.bt_self_message_iterator_configuration_set_can_seek_forward(
          @handle, can_seek_forward ? BT_TRUE : BT_FALSE)
        can_seek_forward
      end
    end
  end
  BTSelfMessageIteratorConfiguration = BTSelfMessageIterator::Configuration
end
