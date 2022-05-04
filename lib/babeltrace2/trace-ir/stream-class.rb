module Babeltrace2
  attach_function :bt_stream_class_create,
                  [ :bt_trace_class_handle ],
                  :bt_stream_class_handle

  attach_function :bt_stream_class_create_with_id,
                  [ :bt_trace_class_handle, :uint64 ],
                  :bt_stream_class_handle

  attach_function :bt_stream_class_borrow_trace_class,
                  [ :bt_stream_class_handle ],
                  :bt_trace_class_handle

  attach_function :bt_stream_class_borrow_trace_class_const,
                  [ :bt_stream_class_handle ],
                  :bt_trace_class_handle

  attach_function :bt_stream_class_get_event_class_count,
                  [ :bt_stream_class_handle ],
                  :uint64

  attach_function :bt_stream_class_borrow_event_class_by_index,
                  [ :bt_stream_class_handle, :uint64 ],
                  :bt_event_class_handle

  attach_function :bt_stream_class_borrow_event_class_by_index_const,
                  [ :bt_stream_class_handle, :uint64 ],
                  :bt_event_class_handle

  attach_function :bt_stream_class_borrow_event_class_by_id,
                  [ :bt_stream_class_handle, :uint64 ],
                  :bt_event_class_handle

  attach_function :bt_stream_class_borrow_event_class_by_id_const,
                  [ :bt_stream_class_handle, :uint64 ],
                  :bt_event_class_handle

  attach_function :bt_stream_class_get_id,
                  [ :bt_stream_class_handle ],
                  :uint64

  BT_STREAM_CLASS_SET_NAME_STATUS_OK = BT_FUNC_STATUS_OK
  BT_STREAM_CLASS_SET_NAME_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTStreamClassSetNameStatus = enum :bt_stream_class_set_name_status,
    [ :BT_STREAM_CLASS_SET_NAME_STATUS_OK,
       BT_STREAM_CLASS_SET_NAME_STATUS_OK,
      :BT_STREAM_CLASS_SET_NAME_STATUS_MEMORY_ERROR,
       BT_STREAM_CLASS_SET_NAME_STATUS_MEMORY_ERROR ]

  attach_function :bt_stream_class_set_name,
                  [ :bt_stream_class_handle, :string ],
                  :bt_stream_class_set_name_status

  attach_function :bt_stream_class_get_name,
                  [ :bt_stream_class_handle ],
                  :string

  BT_STREAM_CLASS_SET_DEFAULT_CLOCK_CLASS_STATUS_OK = BT_FUNC_STATUS_OK
  BTStreamClassSetDefaultClockClassStatus =
    enum :bt_stream_class_set_default_clock_class_status,
    [ :BT_STREAM_CLASS_SET_DEFAULT_CLOCK_CLASS_STATUS_OK,
       BT_STREAM_CLASS_SET_DEFAULT_CLOCK_CLASS_STATUS_OK ]

  attach_function :bt_stream_class_set_default_clock_class,
                  [ :bt_stream_class_handle, :bt_clock_class_handle ],
                  :bt_stream_class_set_default_clock_class_status

  attach_function :bt_stream_class_borrow_default_clock_class,
                  [ :bt_stream_class_handle ],
                  :bt_clock_class_handle

  attach_function :bt_stream_class_borrow_default_clock_class_const,
                  [ :bt_stream_class_handle ],
                  :bt_clock_class_handle

  BT_STREAM_CLASS_SET_FIELD_CLASS_STATUS_OK = BT_FUNC_STATUS_OK
  BT_STREAM_CLASS_SET_FIELD_CLASS_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTStreamClassSetFieldClassStatus =
    enum :bt_stream_class_set_field_class_status,
    [ :BT_STREAM_CLASS_SET_FIELD_CLASS_STATUS_OK,
       BT_STREAM_CLASS_SET_FIELD_CLASS_STATUS_OK,
      :BT_STREAM_CLASS_SET_FIELD_CLASS_STATUS_MEMORY_ERROR,
       BT_STREAM_CLASS_SET_FIELD_CLASS_STATUS_MEMORY_ERROR ]

  attach_function :bt_stream_class_set_packet_context_field_class,
                  [ :bt_stream_class_handle, :bt_field_class_handle ],
                  :bt_stream_class_set_field_class_status

  attach_function :bt_stream_class_borrow_packet_context_field_class,
                  [ :bt_stream_class_handle ],
                  :bt_field_class_handle

  attach_function :bt_stream_class_borrow_packet_context_field_class_const,
                  [ :bt_stream_class_handle ],
                  :bt_field_class_handle

  attach_function :bt_stream_class_set_event_common_context_field_class,
                  [ :bt_stream_class_handle, :bt_field_class_handle ],
                  :bt_stream_class_set_field_class_status

  attach_function :bt_stream_class_borrow_event_common_context_field_class,
                  [ :bt_stream_class_handle ],
                  :bt_field_class_handle

  attach_function :bt_stream_class_borrow_event_common_context_field_class_const,
                  [ :bt_stream_class_handle ],
                  :bt_field_class_handle

  attach_function :bt_stream_class_set_assigns_automatic_event_class_id,
                  [ :bt_stream_class_handle, :bt_bool ],
                  :void

  attach_function :bt_stream_class_assigns_automatic_event_class_id,
                  [ :bt_stream_class_handle ],
                  :bt_bool

  attach_function :bt_stream_class_set_assigns_automatic_stream_id,
                  [ :bt_stream_class_handle, :bt_bool ],
                  :void

  attach_function :bt_stream_class_assigns_automatic_stream_id,
                  [ :bt_stream_class_handle ],
                  :bt_bool

  attach_function :bt_stream_class_set_supports_packets,
                  [ :bt_stream_class_handle, :bt_bool,
                    :bt_bool, :bt_bool ],
                  :void

  attach_function :bt_stream_class_supports_packets,
                  [ :bt_stream_class_handle ],
                  :bt_bool

  attach_function :bt_stream_class_packets_have_beginning_default_clock_snapshot,
                  [ :bt_stream_class_handle ],
                  :bt_bool

  attach_function :bt_stream_class_packets_have_end_default_clock_snapshot,
                  [ :bt_stream_class_handle ],
                  :bt_bool

  attach_function :bt_stream_class_set_supports_discarded_events,
                  [ :bt_stream_class_handle, :bt_bool, :bt_bool ],
                  :void

  attach_function :bt_stream_class_supports_discarded_events,
                  [ :bt_stream_class_handle ],
                  :bt_bool

  attach_function :bt_stream_class_discarded_events_have_default_clock_snapshots,
                  [ :bt_stream_class_handle ],
                  :bt_bool

  attach_function :bt_stream_class_set_supports_discarded_packets,
                  [ :bt_stream_class_handle, :bt_bool, :bt_bool ],
                  :void

  attach_function :bt_stream_class_supports_discarded_packets,
                  [ :bt_stream_class_handle ],
                  :bt_bool

  attach_function :bt_stream_class_discarded_packets_have_default_clock_snapshots,
                  [ :bt_stream_class_handle ],
                  :bt_bool

  attach_function :bt_stream_class_set_user_attributes,
                  [ :bt_stream_class_handle, :bt_value_map_handle ],
                  :void

  attach_function :bt_stream_class_borrow_user_attributes,
                  [ :bt_stream_class_handle ],
                  :bt_value_map_handle

  attach_function :bt_stream_class_borrow_user_attributes_const,
                  [ :bt_stream_class_handle ],
                  :bt_value_map_handle

  attach_function :bt_stream_class_get_ref,
                  [ :bt_stream_class_handle ],
                  :void

  attach_function :bt_stream_class_put_ref,
                  [ :bt_stream_class_handle ],
                  :void

  class BTStreamClass < BTSharedObject
    SetNameStatus = BTStreamClassSetNameStatus
    SetDefaultClockClassStatus = BTStreamClassSetDefaultClockClassStatus
    SetFieldClassStatus = BTStreamClassSetFieldClassStatus
    @get_ref = :bt_stream_class_get_ref
    @put_ref = :bt_stream_class_put_ref

    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil, id: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = if id
            Babeltrace2.bt_stream_class_create_with_id(trace_class, id)
          else
            Babeltrace2.bt_stream_class_create(trace_class)
          end
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def get_trace_class
      BTTraceClass.new(Babeltrace2.bt_stream_class_borrow_trace_class(@handle), retain: true)
    end
    alias trace_class get_trace_class

    def get_event_class_count
      Babeltrace2.bt_stream_class_get_event_class_count(@handle)
    end
    alias event_class_count get_event_class_count

    def get_event_class_by_index(index)
      count = event_class_count
      index += count if count < 0
      return nil if index >= count || index < 0
      BTEventClass.new(
        Babeltrace2.bt_stream_class_borrow_event_class_by_index(@handle, index), retain: true)
    end

    def get_event_class_by_id(id)
      handle = Babeltrace2.bt_stream_class_borrow_event_class_by_id(@handle, id)
      return nil if handle.null?
      BTEventClass.new(handle, retain: true)
    end

    def get_id
      Babeltrace2.bt_stream_class_get_id(@handle)
    end
    alias id get_id

    def set_name(name)
      res = Babeltrace2.bt_stream_class_set_name(@handle, name)
      raise Babeltrace2.process_error(res) if res != :BT_STREAM_CLASS_SET_NAME_STATUS_OK
      self
    end

    def name=(name)
      set_name(name)
      name
    end

    def get_name
      Babeltrace2.bt_stream_class_get_name(@handle)
    end
    alias name get_name

    def set_default_clock_class(clock_class)
      res = Babeltrace2.bt_stream_class_set_default_clock_class(@handle, clock_class)
      raise Babeltrace2.process_error(res) if res != :BT_STREAM_CLASS_SET_DEFAULT_CLOCK_CLASS_STATUS_OK
      self
    end

    def default_clock_class=(clock_class)
      set_default_clock_class(clock_class)
      clock_class
    end

    def get_default_clock_class
      handle = Babeltrace2.bt_stream_class_borrow_default_clock_class(@handle)
      return nil if handle.null?
      BTClockClass.new(handle, retain: true)
    end
    alias default_clock_class get_default_clock_class

    def set_packet_context_field_class(field_class)
      res = Babeltrace2.bt_stream_class_set_packet_context_field_class(
              @handle, field_class)
      raise Babeltrace2.process_error(res) if res != :BT_STREAM_CLASS_SET_FIELD_CLASS_STATUS_OK
      self
    end

    def packet_context_field_class=(field_class)
      set_packet_context_field_class(field_class)
      field_class
    end

    def get_packet_context_field_class
      handle = Babeltrace2.bt_stream_class_borrow_packet_context_field_class(@handle)
      return nil if handle.null?
      BTFieldClass.from_handle(handle)
    end
    alias packet_context_field_class get_packet_context_field_class

    def set_event_common_context_field_class(field_class)
      res = Babeltrace2.bt_stream_class_set_event_common_context_field_class(
              @handle, field_class)
      raise Babeltrace2.process_error(res) if res != :BT_STREAM_CLASS_SET_FIELD_CLASS_STATUS_OK
      self
    end

    def event_common_context_field_class=(field_class)
      set_event_common_context_field_class(field_class)
      field_class
    end

    def get_event_common_context_field_class
      handle = Babeltrace2.bt_stream_class_borrow_event_common_context_field_class(@handle)
      return nil if handle.null?
      BTFieldClass.from_handle(handle)
    end
    alias event_common_context_field_class get_event_common_context_field_class

    def set_assigns_automatic_event_class_id(assigns_automatic_event_class_id)
      Babeltrace2.bt_stream_class_set_assigns_automatic_event_class_id(
        @handle, assigns_automatic_event_class_id ? BT_TRUE : BT_FALSE)
      self
    end

    def assigns_automatic_event_class_id=(assigns_automatic_event_class_id)
      set_assigns_automatic_event_class_id(assigns_automatic_event_class_id)
      assigns_automatic_event_class_id
    end

    def assigns_automatic_event_class_id
      Babeltrace2.bt_stream_class_assigns_automatic_event_class_id(@handle) != BT_FALSE
    end
    alias assigns_automatic_event_class_id? assigns_automatic_event_class_id

    def set_assigns_automatic_stream_id(assigns_automatic_stream_id)
      Babeltrace2.bt_stream_class_set_assigns_automatic_stream_id(
        @handle, assigns_automatic_stream_id ? BT_TRUE : BT_FALSE)
      self
    end

    def assigns_automatic_stream_id=(assigns_automatic_stream_id)
      set_assigns_automatic_stream_id(assigns_automatic_stream_id)
      assigns_automatic_stream_id
    end

    def assigns_automatic_stream_id
      Babeltrace2.bt_stream_class_assigns_automatic_stream_id(@handle) != BT_FALSE
    end
    alias assigns_automatic_stream_id? assigns_automatic_stream_id

    def set_supports_packets(supports_packets,
                             with_beginning_default_clock_snapshot: false,
                             with_end_default_clock_snapshot: false)
      Babeltrace2.bt_stream_class_set_supports_packets(@handle,
        supports_packets ? BT_TRUE : BT_FALSE,
        with_beginning_default_clock_snapshot ? BT_TRUE : BT_FALSE,
        with_end_default_clock_snapshot ? BT_TRUE : BT_FALSE)
      self
    end

    def supports_packets
      Babeltrace2.bt_stream_class_supports_packets(@handle) != BT_FALSE
    end
    alias supports_packets? supports_packets

    def packets_have_beginning_default_clock_snapshot
      Babeltrace2.bt_stream_class_packets_have_beginning_default_clock_snapshot(@handle) != BT_FALSE
    end
    alias packets_have_beginning_default_clock_snapshot? packets_have_beginning_default_clock_snapshot

    def packets_have_end_default_clock_snapshot
      Babeltrace2.bt_stream_class_packets_have_end_default_clock_snapshot(@handle) != BT_FALSE
    end
    alias packets_have_end_default_clock_snapshot? packets_have_end_default_clock_snapshot

    def set_supports_discarded_events(supports_discarded_events,
                                      with_default_clock_snapshots: false)
      Babeltrace2.bt_stream_class_set_supports_discarded_events(
        @handle, supports_discarded_events ? BT_TRUE : BT_FALSE,
        with_default_clock_snapshots ? BT_TRUE : BT_FALSE)
      self
    end

    def supports_discarded_events
      Babeltrace2.bt_stream_class_supports_discarded_events(@handle) != BT_FALSE
    end
    alias supports_discarded_events? supports_discarded_events

    def discarded_events_have_default_clock_snapshots
      Babeltrace2.bt_stream_class_discarded_events_have_default_clock_snapshots(@handle) != BT_FALSE
    end
    alias discarded_events_have_default_clock_snapshots? discarded_events_have_default_clock_snapshots

    def set_supports_discarded_packets(supports_discarded_packets,
                                      with_default_clock_snapshots: false)
      Babeltrace2.bt_stream_class_set_supports_discarded_packets(
        @handle, supports_discarded_packets ? BT_TRUE : BT_FALSE,
        with_default_clock_snapshots ? BT_TRUE : BT_FALSE)
      self
    end

    def supports_discarded_packets
      Babeltrace2.bt_stream_class_supports_discarded_packets(@handle) != BT_FALSE
    end
    alias supports_discarded_packets? supports_discarded_packets

    def discarded_packets_have_default_clock_snapshots
      Babeltrace2.bt_stream_class_discarded_packets_have_default_clock_snapshots(@handle) != BT_FALSE
    end
    alias discarded_packets_have_default_clock_snapshots? discarded_packets_have_default_clock_snapshots

    def set_user_attributes(user_attributes)
      bt_user_attributes = BTValue.from_value(user_attributes)
      Babeltrace2.bt_stream_class_set_user_attributes(@handle, bt_user_attributes)
      self
    end

    def user_attributes=(user_attributes)
      set_user_attributes(user_attributes)
      user_attributes
    end

    def get_user_attributes
      BTValueMap.new(Babeltrace2.bt_stream_class_borrow_user_attributes(@handle), retain: true)
    end
    alias user_attributes get_user_attributes

    def to_h
      res = {
        id: id,
        supports_packets: supports_packets? }
      if supports_packets?
        res[:packets_have_beginning_default_clock_snapshot] =
          packets_have_beginning_default_clock_snapshot?
        res[:packets_have_end_default_clock_snapshot] =
          packets_have_end_default_clock_snapshot?
      end
      res[:supports_discarded_events] = supports_discarded_events?
      res[:discarded_events_have_default_clock_snapshots] =
        discarded_events_have_default_clock_snapshots? if supports_discarded_events?
      if supports_packets?
        res[:supports_discarded_packets] = supports_discarded_packets?
        if supports_discarded_packets?
          res[:discarded_packets_have_default_clock_snapshots] = discarded_packets_have_default_clock_snapshots?
        end
      end
      if default_clock_class
        res[:default_clock_class] = default_clock_class.to_h
      end
      if supports_packets? && packet_context_field_class
        res[:packet_context_field_class] = packet_context_field_class.to_h
      end
      if event_common_context_field_class
        res[:event_common_context_field_class] = event_common_context_field_class.to_h
      end
      res[:assigns_automatic_event_class_id] = assigns_automatic_event_class_id?
      res[:assigns_automatic_stream_id] = assigns_automatic_stream_id?
      res[:event_classes] = event_class_count.times.collect { |i|
        get_event_class_by_index(i).to_h
      }
      user_attributes_value = user_attributes.value
      res[:user_attributes] = user_attributes_value if !user_attributes_value.empty?
      res
    end

    def self.from_h(self_component, trace_class, h)
      id = trace_class.assigns_automatic_stream_class_id? ? nil : h[:id]
      o = trace_class.create_stream_class(id: id)
      o.default_clock_class = BTClockClass.from_h(self_component,
        h[:default_clock_class]) if h[:default_clock_class]
      o.set_supports_packets( h[:supports_packets],
        with_beginning_default_clock_snapshot:
          h[:packets_have_beginning_default_clock_snapshot],
        with_end_default_clock_snapshot:
          h[:packets_have_end_default_clock_snapshot])
      o.set_supports_discarded_events(h[:supports_discarded_events],
        with_default_clock_snapshots:
          h[:discarded_events_have_default_clock_snapshots])
      o.set_supports_discarded_packets(h[:supports_discarded_packets],
        with_default_clock_snapshots:
          h[:discarded_packets_have_default_clock_snapshots]) if h[:supports_packets]
      o.packet_context_field_class = BTFieldClass.from_h(trace_class,
        h[:packet_context_field_class], h) if h[:packet_context_field_class]
      o.event_common_context_field_class = BTFieldClass.from_h(trace_class,
        h[:event_common_context_field_class], h) if h[:event_common_context_field_class]
      o.assigns_automatic_event_class_id = h[:assigns_automatic_event_class_id] unless h[:assigns_automatic_event_class_id].nil?
      o.assigns_automatic_stream_id = h[:assigns_automatic_stream_id] unless h[:assigns_automatic_stream_id].nil?
      h[:event_classes].each_with_index { |v, i|
        h[:bt_current_event] = i;
        BTEventClass.from_h(trace_class, o, v, h)
      }
      h.delete(:bt_current_event)
      o.user_attributes = h[:user_attributes] if h[:user_attributes]
      h[:bt_stream_class] = o
      o
    end

    def self.locate_field_class(path, h)
      case path[0]
      when :event_payload_field_class
        h[:event_classes][h[:bt_current_event]][:payload_field_class].dig(*path[1..-1])[:bt_field_class]
      when :event_specific_context_field_class
        h[:event_classes][h[:bt_current_event]][:specific_context_field_class].dig(*path[1..-1])[:bt_field_class]
      else
        h.dig(*path)[:bt_field_class]
      end
    end

    def create_stream(trace, id: nil)
      BTStream.new(stream_class: @handle, trace: trace, id: nil)
    end

    def create_event_class(id: nil)
      BTEventClass.new(stream_class: @handle, id: nil)
    end
  end
end
