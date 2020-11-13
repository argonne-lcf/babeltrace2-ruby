module Babeltrace2
  BT_MESSAGE_TYPE_STREAM_BEGINNING = 1 << 0
  BT_MESSAGE_TYPE_STREAM_END = 1 << 1
  BT_MESSAGE_TYPE_EVENT = 1 << 2
  BT_MESSAGE_TYPE_PACKET_BEGINNING = 1 << 3
  BT_MESSAGE_TYPE_PACKET_END = 1 << 4
  BT_MESSAGE_TYPE_DISCARDED_EVENTS = 1 << 5
  BT_MESSAGE_TYPE_DISCARDED_PACKETS = 1 << 6
  BT_MESSAGE_TYPE_MESSAGE_ITERATOR_INACTIVITY =  1 << 7
  BTMessageType = enum :bt_message_type,
    [ :BT_MESSAGE_TYPE_STREAM_BEGINNING,
       BT_MESSAGE_TYPE_STREAM_BEGINNING,
      :BT_MESSAGE_TYPE_STREAM_END,
       BT_MESSAGE_TYPE_STREAM_END,
      :BT_MESSAGE_TYPE_EVENT,
       BT_MESSAGE_TYPE_EVENT,
      :BT_MESSAGE_TYPE_PACKET_BEGINNING,
       BT_MESSAGE_TYPE_PACKET_BEGINNING,
      :BT_MESSAGE_TYPE_PACKET_END,
       BT_MESSAGE_TYPE_PACKET_END,
      :BT_MESSAGE_TYPE_DISCARDED_EVENTS,
       BT_MESSAGE_TYPE_DISCARDED_EVENTS,
      :BT_MESSAGE_TYPE_DISCARDED_PACKETS,
       BT_MESSAGE_TYPE_DISCARDED_PACKETS,
      :BT_MESSAGE_TYPE_MESSAGE_ITERATOR_INACTIVITY,
       BT_MESSAGE_TYPE_MESSAGE_ITERATOR_INACTIVITY ]

  attach_function :bt_message_get_type,
                  [ :bt_message_handle ],
                  :bt_message_type

  attach_function :bt_message_get_ref,
                  [ :bt_message_handle ],
                  :void

  attach_function :bt_message_put_ref,
                  [ :bt_message_handle ],
                  :void

  class BTMessage < BTSharedObject
    Type = BTMessageType
    @get_ref = :bt_message_get_ref
    @put_ref = :bt_message_put_ref

    def self.from_handle(handle, retain: true, auto_release: true)
      case Babeltrace2.bt_message_get_type(handle)
      when :BT_MESSAGE_TYPE_STREAM_BEGINNING
        StreamBeginning
      when :BT_MESSAGE_TYPE_STREAM_END
        StreamEnd
      when :BT_MESSAGE_TYPE_EVENT
        Event
      when :BT_MESSAGE_TYPE_PACKET_BEGINNING
        PacketBeginning
      when :BT_MESSAGE_TYPE_PACKET_END
        PacketEnd
      when :BT_MESSAGE_TYPE_DISCARDED_EVENTS
        DiscardedEvents
      when :BT_MESSAGE_TYPE_DISCARDED_PACKETS
        DiscardedPackets
      when :BT_MESSAGE_TYPE_MESSAGE_ITERATOR_INACTIVITY
        MessageIteratorInactivity
      else
        raise Error.new("unknown message type")
      end.new(handle, retain: retain, auto_release: auto_release)
    end

    def get_type
      Babeltrace2.bt_message_get_type(@handle)
    end
    alias type get_type
  end

  BT_MESSAGE_STREAM_CLOCK_SNAPSHOT_STATE_KNOWN = 1
  BT_MESSAGE_STREAM_CLOCK_SNAPSHOT_STATE_UNKNOWN = 0
  BTMessageStreamClockSnapshotState = enum :bt_message_stream_clock_snapshot_state,
    [ :BT_MESSAGE_STREAM_CLOCK_SNAPSHOT_STATE_KNOWN,
       BT_MESSAGE_STREAM_CLOCK_SNAPSHOT_STATE_KNOWN,
      :BT_MESSAGE_STREAM_CLOCK_SNAPSHOT_STATE_UNKNOWN,
       BT_MESSAGE_STREAM_CLOCK_SNAPSHOT_STATE_UNKNOWN ]

  attach_function :bt_message_stream_beginning_create,
                  [ :bt_self_message_iterator_handle,
                    :bt_stream_handle ],
                  :bt_message_handle

  attach_function :bt_message_stream_beginning_borrow_stream,
                  [ :bt_message_handle ],
                  :bt_stream_handle

  attach_function :bt_message_stream_beginning_borrow_stream_const,
                  [ :bt_message_handle ],
                  :bt_stream_handle

  attach_function :bt_message_stream_beginning_set_default_clock_snapshot,
                  [ :bt_message_handle, :uint64_t ],
                  :void

  attach_function :bt_message_stream_beginning_borrow_default_clock_snapshot_const,
                  [ :bt_message_handle, :pointer ],
                  :bt_message_stream_clock_snapshot_state

  attach_function :bt_message_stream_beginning_borrow_stream_class_default_clock_class_const,
                  [ :bt_message_handle ],
                  :bt_clock_class_handle

  class BTMessage
    StreamClockSnapshotState = BTMessageStreamClockSnapshotState
    class StreamBeginning < BTMessage
      def initialize(handle = nil, retain: true, auto_release: true,
                     self_message_iterator: nil, stream: nil)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = Babeltrace2.bt_message_stream_beginning_create(
                     self_message_iterator, stream)
          raise NoMemoryError if handle.null?
          super(handle)
        end
      end

      def get_stream
        handle = Babeltrace2.bt_message_stream_beginning_borrow_stream(@handle)
        BTStream.new(handle, retain: true, auto_release: true)
      end
      alias stream get_stream

      def set_default_clock_snapshot(value)
        Babeltrace2.bt_message_stream_beginning_set_default_clock_snapshot(@handle, value)
        self
      end

      def default_clock_snapshot=(value)
        Babeltrace2.bt_message_stream_beginning_set_default_clock_snapshot(@handle, value)
        value
      end

      def get_default_clock_snapshot
        ptr = FFI::MemoryPointer.new(:pointer)
        res = Babeltrace2.bt_message_stream_beginning_borrow_default_clock_snapshot_const(@handle, ptr)
        return nil if res == :BT_MESSAGE_STREAM_CLOCK_SNAPSHOT_STATE_UNKNOWN
        BTClockSnapshot.new(ptr.read_pointer)
      end
      alias default_clock_snapshot get_default_clock_snapshot

      def get_stream_class_default_clock_class
        handle = Babeltrace2.bt_message_stream_beginning_borrow_stream_class_default_clock_class_const(@handle)
        BTClockClass.new(handle, retain: true, auto_release: true)
      end
      alias stream_class_default_clock_class get_stream_class_default_clock_class
    end
  end
  BTMessageStreamBeginning = BTMessage::StreamBeginning

  attach_function :bt_message_stream_end_create,
                  [ :bt_self_message_iterator_handle,
                    :bt_stream_handle ],
                  :bt_message_handle

  attach_function :bt_message_stream_end_borrow_stream,
                  [ :bt_message_handle ],
                  :bt_stream_handle

  attach_function :bt_message_stream_end_borrow_stream_const,
                  [ :bt_message_handle ],
                  :bt_stream_handle

  attach_function :bt_message_stream_end_set_default_clock_snapshot,
                  [ :bt_message_handle, :uint64_t ],
                  :void

  attach_function :bt_message_stream_end_borrow_default_clock_snapshot_const,
                  [ :bt_message_handle, :pointer ],
                  :bt_message_stream_clock_snapshot_state

  attach_function :bt_message_stream_end_borrow_stream_class_default_clock_class_const,
                  [ :bt_message_handle ],
                  :bt_clock_class_handle

  class BTMessage
    class StreamEnd < BTMessage
      def initialize(handle = nil, retain: true, auto_release: true,
                     self_message_iterator: nil, stream: nil)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = Babeltrace2.bt_message_stream_end_create(
                     self_message_iterator, stream)
          raise NoMemoryError if handle.null?
          super(handle)
        end
      end

      def get_stream
        handle = Babeltrace2.bt_message_stream_end_borrow_stream(@handle)
        BTStream.new(handle, retain: true, auto_release: true)
      end
      alias stream get_stream

      def set_default_clock_snapshot(value)
        Babeltrace2.bt_message_stream_end_set_default_clock_snapshot(@handle, value)
        self
      end

      def default_clock_snapshot=(value)
        Babeltrace2.bt_message_stream_end_set_default_clock_snapshot(@handle, value)
        value
      end

      def get_default_clock_snapshot
        handle = Babeltrace2.bt_message_stream_end_borrow_default_clock_snapshot_const(@handle)
        BTClockSnapshot.new(handle)
      end
      alias default_clock_snapshot get_default_clock_snapshot

      def get_stream_class_default_clock_class
        handle = Babeltrace2.bt_message_stream_end_borrow_stream_class_default_clock_class_const(@handle)
        BTClockClass.new(handle, retain: true, auto_release: true)
      end
      alias stream_class_default_clock_class get_stream_class_default_clock_class
    end
  end
  BTMessageStreamEnd = BTMessage::StreamEnd

  attach_function :bt_message_event_create,
                  [ :bt_self_message_iterator_handle,
                    :bt_event_class_handle,
                    :bt_stream_handle ],
                  :bt_message_handle

  attach_function :bt_message_event_create_with_default_clock_snapshot,
                  [ :bt_self_message_iterator_handle,
                    :bt_event_class_handle,
                    :bt_stream_handle, :uint64 ],
                  :bt_message_handle

  attach_function :bt_message_event_create_with_packet,
                  [ :bt_self_message_iterator_handle,
                    :bt_event_class_handle,
                    :bt_packet_handle ],
                  :bt_message_handle

  attach_function :bt_message_event_create_with_packet_and_default_clock_snapshot,
                  [ :bt_self_message_iterator_handle,
                    :bt_event_class_handle,
                    :bt_packet_handle, :uint64 ],
                  :bt_message_handle

  attach_function :bt_message_event_borrow_event,
                  [ :bt_message_handle ],
                  :bt_event_handle

  attach_function :bt_message_event_borrow_event_const,
                  [ :bt_message_handle ],
                  :bt_event_handle

  attach_function :bt_message_event_borrow_default_clock_snapshot_const,
                  [ :bt_message_handle ],
                  :bt_clock_snapshot_handle

  attach_function :bt_message_event_borrow_stream_class_default_clock_class_const,
                  [ :bt_message_handle ],
                  :bt_clock_class_handle

  class BTMessage
    class Event < BTMessage
      def initialize(handle = nil, retain: true, auto_release: true,
                     self_message_iterator: nil, event_class: nil, stream: nil,
                     clock_snapshot_value: nil, packet: nil)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = if clock_snapshot_value
              if packet
                Babeltrace2.bt_message_event_create_with_default_clock_snapshot(
                  self_message_iterator, event_class, packet, clock_snapshot_value)
              else
                Babeltrace2.bt_message_event_create_with_default_clock_snapshot(
                  self_message_iterator, event_class, stream, clock_snapshot_value)
              end
            else
              if packet
                Babeltrace2.bt_message_event_create_with_packet(
                  self_message_iterator, event_class, packet)
              else
                Babeltrace2.bt_message_event_create(
                  self_message_iterator, event_class, stream)
              end
            end
          raise NoMemoryError if handle.null?
          super(handle)
        end
      end

      def get_event
        handle = Babeltrace2.bt_message_event_borrow_event(@handle)
        BTEvent.new(handle, retain: true, auto_release: true)
      end
      alias event get_event

      def get_default_clock_snapshot
        handle = Babeltrace2.bt_message_event_borrow_default_clock_snapshot_const(@handle)
        BTClockSnapshot.new(handle)
      end
      alias default_clock_snapshot get_default_clock_snapshot

      def get_stream_class_default_clock_class
        handle = Babeltrace2.bt_message_event_borrow_stream_class_default_clock_class_const(@handle)
        BTClockClass.new(handle, retain: true, auto_release: true)
      end
      alias stream_class_default_clock_class get_stream_class_default_clock_class
    end
  end
  BTMessageEvent = BTMessage::Event

  attach_function :bt_message_packet_beginning_create,
                  [ :bt_self_message_iterator_handle,
                    :bt_packet_handle ],
                  :bt_message_handle

  attach_function :bt_message_packet_beginning_create_with_default_clock_snapshot,
                  [ :bt_self_message_iterator_handle,
                    :bt_packet_handle, :uint64 ],
                  :bt_message_handle

  attach_function :bt_message_packet_beginning_borrow_packet,
                  [ :bt_message_handle ],
                  :bt_packet_handle

  attach_function :bt_message_packet_beginning_borrow_packet_const,
                  [ :bt_message_handle ],
                  :bt_packet_handle

  attach_function :bt_message_packet_beginning_borrow_default_clock_snapshot_const,
                  [ :bt_message_handle ],
                  :bt_clock_snapshot_handle

  attach_function :bt_message_packet_beginning_borrow_stream_class_default_clock_class_const,
                  [ :bt_message_handle ],
                  :bt_clock_class_handle

  class BTMessage
    class PacketBeginning < BTMessage
      def initialize(handle = nil, retain: true, auto_release: true,
                     self_message_iterator: nil, packet: nil, clock_snapshot_value: nil)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = if clock_snapshot_value
              Babeltrace2.bt_message_packet_beginning_create_with_default_clock_snapshot(
                self_message_iterator, packet, clock_snapshot_value)
            else
              Babeltrace2.bt_message_packet_beginning_create(
                self_message_iterator, packet)
            end
          raise NoMemoryError if handle.null?
          super(handle)
        end
      end

      def get_packet
        bt_message_packet_beginning_borrow_packet(@handle)
        BTPacket.new(handle, retain: true, auto_release: true)
      end
      alias packet get_packet

      def get_default_clock_snapshot
        handle = Babeltrace2.bt_message_packet_beginning_borrow_default_clock_snapshot_const(@handle)
        BTClockSnapshot.new(handle)
      end
      alias default_clock_snapshot get_default_clock_snapshot

      def get_stream_class_default_clock_class
        handle = Babeltrace2.bt_message_packet_beginning_borrow_stream_class_default_clock_class_const(@handle)
        BTClockClass.new(handle, retain: true, auto_release: true)
      end
      alias stream_class_default_clock_class get_stream_class_default_clock_class
    end
  end
  BTMessagePacketBeginning = BTMessage::PacketBeginning

  attach_function :bt_message_packet_end_create,
                  [ :bt_self_message_iterator_handle,
                    :bt_packet_handle ],
                  :bt_message_handle

  attach_function :bt_message_packet_end_create_with_default_clock_snapshot,
                  [ :bt_self_message_iterator_handle,
                    :bt_packet_handle, :uint64 ],
                  :bt_message_handle

  attach_function :bt_message_packet_end_borrow_packet,
                  [ :bt_message_handle ],
                  :bt_packet_handle

  attach_function :bt_message_packet_end_borrow_packet_const,
                  [ :bt_message_handle ],
                  :bt_packet_handle

  attach_function :bt_message_packet_end_borrow_default_clock_snapshot_const,
                  [ :bt_message_handle ],
                  :bt_clock_snapshot_handle

  attach_function :bt_message_packet_end_borrow_stream_class_default_clock_class_const,
                  [ :bt_message_handle ],
                  :bt_clock_class_handle

  class BTMessage
    class PacketEnd < BTMessage
      def initialize(handle = nil, retain: true, auto_release: true,
                     self_message_iterator: nil, packet: nil, clock_snapshot_value: nil)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = if clock_snapshot_value
              Babeltrace2.bt_message_packet_end_create_with_default_clock_snapshot(
                self_message_iterator, packet, clock_snapshot_value)
            else
              Babeltrace2.bt_message_packet_end_create(
                self_message_iterator, packet)
            end
          raise NoMemoryError if handle.null?
          super(handle)
        end
      end

      def get_packet
        bt_message_packet_end_borrow_packet(@handle)
        BTPacket.new(handle, retain: true, auto_release: true)
      end
      alias packet get_packet

      def get_default_clock_snapshot
        handle = Babeltrace2.bt_message_packet_end_borrow_default_clock_snapshot_const(@handle)
        BTClockSnapshot.new(handle)
      end
      alias default_clock_snapshot get_default_clock_snapshot

      def get_stream_class_default_clock_class
        handle = Babeltrace2.bt_message_packet_end_borrow_stream_class_default_clock_class_const(@handle)
        BTClockClass.new(handle, retain: true, auto_release: true)
      end
      alias stream_class_default_clock_class get_stream_class_default_clock_class
    end
  end
  BTMessagePacketEnd = BTMessage::PacketEnd

  attach_function :bt_message_discarded_events_create,
                  [ :bt_self_message_iterator_handle,
                    :bt_stream_handle ],
                  :bt_message_handle

  attach_function :bt_message_discarded_events_create_with_default_clock_snapshots,
                  [ :bt_self_message_iterator_handle,
                    :bt_stream_handle, :uint64, :uint64 ],
                  :bt_message_handle

  attach_function :bt_message_discarded_events_borrow_stream,
                  [ :bt_message_handle ],
                  :bt_stream_handle

  attach_function :bt_message_discarded_events_borrow_stream_const,
                  [ :bt_message_handle ],
                  :bt_stream_handle

  attach_function :bt_message_discarded_events_borrow_beginning_default_clock_snapshot_const,
                  [ :bt_message_handle ],
                  :bt_clock_snapshot_handle

  attach_function :bt_message_discarded_events_borrow_end_default_clock_snapshot_const,
                  [ :bt_message_handle ],
                  :bt_clock_snapshot_handle

  attach_function :bt_message_discarded_events_borrow_stream_class_default_clock_class_const,
                  [ :bt_message_handle ],
                  :bt_clock_class_handle

  attach_function :bt_message_discarded_events_set_count,
                  [ :bt_message_handle, :uint64 ],
                  :void

  attach_function :bt_message_discarded_events_get_count,
                  [ :bt_message_handle, :pointer ],
                  :bt_property_availability

  class BTMessage
    class DiscardedEvents < BTMessage
      def initialize(handle = nil, retain: true, auto_release: true,
                     self_message_iterator: nil, stream: nil,
                     beginning_clock_snapshot_value: nil,
                     end_clock_snapshot_value: nil)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = if beginning_clock_snapshot_value && end_clock_snapshot_value
              Babeltrace2.bt_message_discarded_events_create_with_default_clock_snapshots(
                self_message_iterator, stream,
                beginning_clock_snapshot_value, end_clock_snapshot_value)
            else
              Babeltrace2.bt_message_discarded_events_create(
                self_message_iterator, stream)
            end
          raise NoMemoryError if handle.null?
          super(handle)
        end
      end

      def get_stream
        handle = Babeltrace2.bt_message_discarded_events_borrow_stream(@handle)
        BTStream.new(handle, retain: true, auto_release: true)
      end
      alias stream get_stream

      def get_beginning_default_clock_snapshot
        handle = Babeltrace2.bt_message_discarded_events_borrow_beginning_default_clock_snapshot_const(@handle)
        BTClockSnapshot.new(handle)
      end
      alias beginning_default_clock_snapshot get_beginning_default_clock_snapshot

      def get_end_default_clock_snapshot
        handle = Babeltrace2.bt_message_discarded_events_borrow_end_default_clock_snapshot_const(@handle)
        BTClockSnapshot.new(handle)
      end
      alias end_default_clock_snapshot get_end_default_clock_snapshot

      def get_stream_class_default_clock_class
        handle = Babeltrace2.bt_message_discarded_events_borrow_stream_class_default_clock_class_const(@handle)
        BTClockClass.new(handle, retain: true, auto_release: true)
      end
      alias stream_class_default_clock_class get_stream_class_default_clock_class

      def set_count(count)
        Babeltrace2.bt_message_discarded_events_set_count(@handle, count)
        self
      end

      def count=(count)
        Babeltrace2.bt_message_discarded_events_set_count(@handle, count)
        count
      end

      def get_count
        ptr = FFI::MemoryPointer.new(:pointer)
        res = Babeltrace2.bt_message_discarded_events_get_count(@handle, ptr)
        return nil if res == :BT_PROPERTY_AVAILABILITY_NOT_AVAILABLE
        ptr.read_uint64
      end
      alias count get_count
    end
  end
  BTMessageDiscardedEvents = BTMessage::DiscardedEvents

  attach_function :bt_message_discarded_packets_create,
                  [ :bt_self_message_iterator_handle,
                    :bt_stream_handle ],
                  :bt_message_handle

  attach_function :bt_message_discarded_packets_create_with_default_clock_snapshots,
                  [ :bt_self_message_iterator_handle,
                    :bt_stream_handle, :uint64, :uint64 ],
                  :bt_message_handle

  attach_function :bt_message_discarded_packets_borrow_stream,
                  [ :bt_message_handle ],
                  :bt_stream_handle

  attach_function :bt_message_discarded_packets_borrow_stream_const,
                  [ :bt_message_handle ],
                  :bt_stream_handle

  attach_function :bt_message_discarded_packets_borrow_beginning_default_clock_snapshot_const,
                  [ :bt_message_handle ],
                  :bt_clock_snapshot_handle

  attach_function :bt_message_discarded_packets_borrow_end_default_clock_snapshot_const,
                  [ :bt_message_handle ],
                  :bt_clock_snapshot_handle

  attach_function :bt_message_discarded_packets_borrow_stream_class_default_clock_class_const,
                  [ :bt_message_handle ],
                  :bt_clock_class_handle

  attach_function :bt_message_discarded_packets_set_count,
                  [ :bt_message_handle, :uint64 ],
                  :void

  attach_function :bt_message_discarded_packets_get_count,
                  [ :bt_message_handle, :pointer ],
                  :bt_property_availability

  class BTMessage
    class DiscardedPackets < BTMessage
      def initialize(handle = nil, retain: true, auto_release: true,
                     self_message_iterator: nil, stream: nil,
                     beginning_clock_snapshot_value: nil,
                     end_clock_snapshot_value: nil)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = if beginning_clock_snapshot_value && end_clock_snapshot_value
              Babeltrace2.bt_message_discarded_packets_create_with_default_clock_snapshots(
                self_message_iterator, stream,
                beginning_clock_snapshot_value, end_clock_snapshot_value)
            else
              Babeltrace2.bt_message_discarded_packets_create(
                self_message_iterator, stream)
            end
          raise NoMemoryError if handle.null?
          super(handle)
        end
      end

      def get_stream
        handle = Babeltrace2.bt_message_discarded_packets_borrow_stream(@handle)
        BTStream.new(handle, retain: true, auto_release: true)
      end
      alias stream get_stream

      def get_beginning_default_clock_snapshot
        handle = Babeltrace2.bt_message_discarded_packets_borrow_beginning_default_clock_snapshot_const(@handle)
        BTClockSnapshot.new(handle)
      end
      alias beginning_default_clock_snapshot get_beginning_default_clock_snapshot

      def get_end_default_clock_snapshot
        handle = Babeltrace2.bt_message_discarded_packets_borrow_end_default_clock_snapshot_const(@handle)
        BTClockSnapshot.new(handle)
      end
      alias end_default_clock_snapshot get_end_default_clock_snapshot

      def get_stream_class_default_clock_class
        handle = Babeltrace2.bt_message_discarded_packets_borrow_stream_class_default_clock_class_const(@handle)
        BTClockClass.new(handle, retain: true, auto_release: true)
      end
      alias stream_class_default_clock_class get_stream_class_default_clock_class

      def set_count(count)
        Babeltrace2.bt_message_discarded_packets_set_count(@handle, count)
        self
      end

      def count=(count)
        Babeltrace2.bt_message_discarded_packets_set_count(@handle, count)
        count
      end

      def get_count
        ptr = FFI::MemoryPointer.new(:pointer)
        res = Babeltrace2.bt_message_discarded_packets_get_count(@handle, ptr)
        return nil if res == :BT_PROPERTY_AVAILABILITY_NOT_AVAILABLE
        ptr.read_uint64
      end
      alias count get_count
    end
  end
  BTMessageDiscardedPackets = BTMessage::DiscardedPackets

  attach_function :bt_message_message_iterator_inactivity_create,
                  [ :bt_self_message_iterator_handle, 
                    :bt_clock_class_handle,
                    :uint64 ],
                  :bt_message_handle

  attach_function :bt_message_message_iterator_inactivity_borrow_clock_snapshot_const,
                  [ :bt_message_handle ],
                  :bt_clock_snapshot_handle

  class BTMessage
    class IteratorInactivity < BTMessage
      def initialize(handle = nil, retain: true, auto_release: true,
                     self_message_iterator: nil, clock_class: nil,
                     clock_snapshot_value: nil)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = Babeltrace2.bt_message_message_iterator_inactivity_create(
            self_message_iterator, clock_class, clock_snapshot_value)
          raise NoMemoryError if handle.null?
          super(handle)
        end
      end

      def get_clock_snapshot
        handle = Babeltrace2.bt_message_message_iterator_inactivity_borrow_clock_snapshot_const(@handle)
        BTClockSnapshot.new(handle)
      end
      alias clock_snapshot get_clock_snapshot
    end
  end

  BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_OK = BT_FUNC_STATUS_OK
  BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_NO_MATCH = BT_FUNC_STATUS_NO_MATCH
  BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTGetGreatestOperativeMipVersionStatus =
    enum :bt_get_greatest_operative_mip_version_status,
    [ :BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_OK, 
       BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_OK,
      :BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_NO_MATCH,
       BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_NO_MATCH,
      :BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_MEMORY_ERROR,
       BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_MEMORY_ERROR,
      :BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_ERROR,
       BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_ERROR ]

  attach_function :bt_get_greatest_operative_mip_version,
                  [ :bt_component_descriptor_set_handle,
                    :bt_logging_level, :pointer ],
                  :bt_get_greatest_operative_mip_version_status

  attach_function :bt_get_maximal_mip_version,
                  [],
                  :uint64

  alias get_maximal_mip_version bt_get_maximal_mip_version
  alias maximal_mip_version get_maximal_mip_version

end
