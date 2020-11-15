module Babeltrace2

  attach_function :bt_clock_snapshot_borrow_clock_class_const,
                  [ :bt_clock_snapshot_handle ],
                  :bt_clock_class_handle

  attach_function :bt_clock_snapshot_get_value,
                  [ :bt_clock_snapshot_handle ],
                  :uint64

  BT_CLOCK_SNAPSHOT_GET_NS_FROM_ORIGIN_STATUS_OK = BT_FUNC_STATUS_OK
  BT_CLOCK_SNAPSHOT_GET_NS_FROM_ORIGIN_STATUS_OVERFLOW_ERROR = BT_FUNC_STATUS_OVERFLOW_ERROR
  BTClockSnapshotGetNSFromOriginStatus =
    enum :bt_clock_snapshot_get_ns_from_origin_status,
    [ :BT_CLOCK_SNAPSHOT_GET_NS_FROM_ORIGIN_STATUS_OK,
       BT_CLOCK_SNAPSHOT_GET_NS_FROM_ORIGIN_STATUS_OK,
      :BT_CLOCK_SNAPSHOT_GET_NS_FROM_ORIGIN_STATUS_OVERFLOW_ERROR,
       BT_CLOCK_SNAPSHOT_GET_NS_FROM_ORIGIN_STATUS_OVERFLOW_ERROR ]

  attach_function :bt_clock_snapshot_get_ns_from_origin,
                  [ :bt_clock_snapshot_handle, :pointer ],
                  :bt_clock_snapshot_get_ns_from_origin_status

  class BTClockSnapshot < BTObject
    GetNSFromOriginStatus = BTClockSnapshotGetNSFromOriginStatus
    def get_clock_class
      handle = Babeltrace2.bt_clock_snapshot_borrow_clock_class_const(@handle)
      BTClockClass.new(handle, retain: true)
    end
    alias clock_class get_clock_class

    def get_value
      Babeltrace2.bt_clock_snapshot_get_value(@handle)
    end
    alias value get_value

    def get_ns_from_origin
      ptr = MemoryPointer::new(:int64)
      res = Babeltrace2.bt_clock_snapshot_get_ns_from_origin(@handle, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_CLOCK_SNAPSHOT_GET_NS_FROM_ORIGIN_STATUS_OK
      ptr.read_int64
    end
    alias ns_from_origin get_ns_from_origin
  end
end
