module Babeltrace2
  BT_UTIL_CLOCK_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OK = BT_FUNC_STATUS_OK
  BT_UTIL_CLOCK_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OVERFLOW_ERROR = BT_FUNC_STATUS_OVERFLOW_ERROR

  BTUtilClockCyclesToNSFromOriginStatus = enum :bt_util_clock_cycles_to_ns_from_origin_status,
    [ :BT_UTIL_CLOCK_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OK, BT_UTIL_CLOCK_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OK,
      :BT_UTIL_CLOCK_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OVERFLOW_ERROR, BT_UTIL_CLOCK_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OVERFLOW_ERROR ]

  attach_function :bt_util_clock_cycles_to_ns_from_origin,
                  [:uint64, :uint64, :int64, :uint64, :pointer],
                  :bt_util_clock_cycles_to_ns_from_origin_status

  module BTUtil
    ClockCyclesToNSFromOriginStatus = BTUtilClockCyclesToNSFromOriginStatus

    def self.clock_cycles_to_ns_from_origin(cycles, frequency, offset_seconds, offset_cycles)
      ptr = FFI::MemoryPointer::new(:int64)
      res = Babeltrace2.bt_util_clock_cycles_to_ns_from_origin(cycles, frequency, offset_seconds, offset_cycles, ptr)
      raise res if res != :BT_UTIL_CLOCK_CYCLES_TO_NS_FROM_ORIGIN_STATUS_OK
      ptr.read_int64
    end
  end
end
