module Babeltrace2
  attach_function :bt_clock_class_create,
                  [ :bt_self_component_handle ],
                  :bt_clock_class_handle

  attach_function :bt_clock_class_set_frequency,
                  [ :bt_clock_class_handle, :uint64 ],
                  :void

  attach_function :bt_clock_class_get_frequency,
                  [ :bt_clock_class_handle ],
                  :uint64

  attach_function :bt_clock_class_set_offset,
                  [ :bt_clock_class_handle, :int64, :uint64 ],
                  :void

  attach_function :bt_clock_class_get_offset,
                  [ :bt_clock_class_handle, :pointer, :pointer],
                  :void

  attach_function :bt_clock_class_set_precision,
                  [ :bt_clock_class_handle, :uint64 ],
                  :void

  attach_function :bt_clock_class_get_precision,
                  [ :bt_clock_class_handle ],
                  :uint64

  attach_function :bt_clock_class_set_origin_is_unix_epoch,
                  [ :bt_clock_class_handle, :bt_bool ],
                  :void

  attach_function :bt_clock_class_origin_is_unix_epoch,
                  [ :bt_clock_class_handle ],
                  :bt_bool

  BT_CLOCK_CLASS_SET_NAME_STATUS_OK = BT_FUNC_STATUS_OK
  BT_CLOCK_CLASS_SET_NAME_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTClockClassSetNameStatus = enum :bt_clock_class_set_name_status,
    [ :BT_CLOCK_CLASS_SET_NAME_STATUS_OK,
       BT_CLOCK_CLASS_SET_NAME_STATUS_OK,
      :BT_CLOCK_CLASS_SET_NAME_STATUS_MEMORY_ERROR,
       BT_CLOCK_CLASS_SET_NAME_STATUS_MEMORY_ERROR ]

  attach_function :bt_clock_class_set_name,
                  [ :bt_clock_class_handle, :string ],
                  :bt_clock_class_set_name_status

  attach_function :bt_clock_class_get_name,
                  [ :bt_clock_class_handle ],
                  :string

  BT_CLOCK_CLASS_SET_DESCRIPTION_STATUS_OK = BT_FUNC_STATUS_OK
  BT_CLOCK_CLASS_SET_DESCRIPTION_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTClockClassSetDescriptionStatus = enum :bt_clock_class_set_description_status,
    [ :BT_CLOCK_CLASS_SET_DESCRIPTION_STATUS_OK,
       BT_CLOCK_CLASS_SET_DESCRIPTION_STATUS_OK,
      :BT_CLOCK_CLASS_SET_DESCRIPTION_STATUS_MEMORY_ERROR,
       BT_CLOCK_CLASS_SET_DESCRIPTION_STATUS_MEMORY_ERROR ]

  attach_function :bt_clock_class_set_description,
                  [ :bt_clock_class_handle, :string ],
                  :bt_clock_class_set_description_status

  attach_function :bt_clock_class_get_description,
                  [ :bt_clock_class_handle ],
                  :string

  attach_function :bt_clock_class_set_uuid,
                  [ :bt_clock_class_handle, :bt_uuid ],
                  :void

  attach_function :bt_clock_class_get_uuid,
                  [ :bt_clock_class_handle ],
                  :bt_uuid

  attach_function :bt_clock_class_set_user_attributes,
                  [ :bt_clock_class_handle, :bt_value_map_handle ],
                  :void

  attach_function :bt_clock_class_borrow_user_attributes,
                  [ :bt_clock_class_handle ],
                  :bt_value_map_handle

  attach_function :bt_clock_class_borrow_user_attributes_const,
                  [ :bt_clock_class_handle ],
                  :bt_value_map_handle

  BT_CLOCK_CLASS_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OK = BT_FUNC_STATUS_OK
  BT_CLOCK_CLASS_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OVERFLOW_ERROR = BT_FUNC_STATUS_OVERFLOW_ERROR
  BTClockClassCyclesToNSFromOriginStatus =
    enum :bt_clock_class_cycles_to_ns_from_origin_status,
    [ :BT_CLOCK_CLASS_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OK,
       BT_CLOCK_CLASS_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OK,
      :BT_CLOCK_CLASS_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OVERFLOW_ERROR,
       BT_CLOCK_CLASS_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OVERFLOW_ERROR ]

  attach_function :bt_clock_class_cycles_to_ns_from_origin,
                  [ :bt_clock_class_handle, :uint64, :pointer ],
                  :bt_clock_class_cycles_to_ns_from_origin_status

  attach_function :bt_clock_class_get_ref,
                  [ :bt_clock_class_handle ],
                  :void

  attach_function :bt_clock_class_put_ref,
                  [ :bt_clock_class_handle ],
                  :void

  class BTClockClass < BTSharedObject
    CyclesToNSFromOriginStatus = BTClockClassCyclesToNSFromOriginStatus
    @get_ref = :bt_clock_class_get_ref
    @put_ref = :bt_clock_class_put_ref

    def initialize(handle, retain: true, auto_release: true,
                   self_component: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_clock_class_create(self_component)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def set_frequency(frequency)
      Babeltrace2.bt_clock_class_set_frequency(@handle, frequency)
      self
    end

    def frequency=(frequency)
      set_frequency(frequency)
      frequency
    end

    def get_frequency
      Babeltrace2.bt_clock_class_get_frequency(@handle)
    end
    alias frequency get_frequency

    def set_offset(offset_seconds, offset_cycles)
      Babeltrace2.bt_clock_class_set_offset(@handle, offset_seconds, offset_cycles)
      self
    end

    def get_offset
      ptr1 = FFI::MemoryPointer::new(:int64)
      ptr2 = FFI::MemoryPointer::new(:uint64)
      Babeltrace2.bt_clock_class_get_offset(@handle, ptr1, ptr2)
      [ptr1.read_int64, ptr2.read_uint64]
    end

    def set_precision(precision)
      Babeltrace2.bt_clock_class_set_precision(@handle, precision)
      self
    end

    def precision=(precision)
      set_precision(precision)
      precision
    end

    def get_precision
      Babeltrace2.bt_clock_class_get_precision(@handle)
    end
    alias precision get_precision

    def set_origin_is_unix_epoch(origin_is_unix_epoch)
      Babeltrace2.bt_clock_class_set_origin_is_unix_epoch(
        @handle, origin_is_unix_epoch ? BT_TRUE : BT_FALSE)
      self
    end

    def origin_is_unix_epoch=(origin_is_unix_epoch)
      set_origin_is_unix_epoch(origin_is_unix_epoch)
      origin_is_unix_epoch
    end

    def origin_is_unix_epoch
      Babeltrace2.bt_clock_class_origin_is_unix_epoch(@handle) != BT_FALSE
    end
    alias origin_is_unix_epoch? origin_is_unix_epoch

    def set_name(name)
      res = Babeltrace2.bt_clock_class_set_name(@handle, name)
      raise Babeltrace2.process_error(res) if res != :BT_CLOCK_CLASS_SET_NAME_STATUS_OK
      self
    end

    def name=(name)
      set_name(name)
      name
    end

    def get_name
      Babeltrace2.bt_clock_class_get_name(@handle)
    end
    alias name get_name

    def set_description(description)
      res = Babeltrace2.bt_clock_class_set_description(@handle, description)
      raise Babeltrace2.process_error(res) if res != :BT_CLOCK_CLASS_SET_DESCRIPTION_STATUS_OK
      self
    end

    def description=(description)
      res = Babeltrace2.bt_clock_class_set_description(@handle, description)
      raise Babeltrace2.process_error(res) if res != :BT_CLOCK_CLASS_SET_DESCRIPTION_STATUS_OK
      description
    end

    def get_description
      Babeltrace2.bt_clock_class_get_description(@handle)
    end
    alias description get_description

    def set_uuid(uuid)
      Babeltrace2.bt_clock_class_set_uuid(@handle, uuid)
      self
    end

    def uuid=(uuid)
      set_uuid(uuid)
      uuid
    end

    def get_uuid
      Babeltrace2.bt_clock_class_get_uuid(@handle)
    end
    alias uuid get_uuid

    def set_user_attributes(user_attributes)
      Babeltrace2.bt_clock_class_set_user_attributes(@handle, BTValue.from_value(user_attributes))
      self
    end

    def user_attributes=(user_attributes)
      set_user_attributes(user_attributes)
      user_attributes
    end

    def get_user_attributes
      handle = Babeltrace2.bt_clock_class_borrow_user_attributes(@handle)
      BTValueMap.new(handle)
    end
    alias user_attributes get_user_attributes

    def cycles_to_ns_from_origin(value)
      ptr = FFI::MemoryPointer::new(:int64)
      res = Babeltrace2.bt_clock_class_cycles_to_ns_from_origin(@handle, value, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_CLOCK_CLASS_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OK
      ptr.read_int64
    end
  end
end
