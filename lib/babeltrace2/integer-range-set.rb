module Babeltrace2

  attach_function :bt_integer_range_unsigned_get_lower,
                  [:bt_integer_range_unsigned_handle],
                  :uint64

  attach_function :bt_integer_range_unsigned_get_upper,
                  [:bt_integer_range_unsigned_handle],
                  :uint64

  attach_function :bt_integer_range_unsigned_is_equal,
                  [:bt_integer_range_unsigned_handle, :bt_integer_range_unsigned_handle],
                  :bt_bool

  attach_function :bt_integer_range_signed_get_lower,
                  [:bt_integer_range_signed_handle],
                  :int64

  attach_function :bt_integer_range_signed_get_upper,
                  [:bt_integer_range_signed_handle],
                  :int64

  attach_function :bt_integer_range_signed_is_equal,
                  [:bt_integer_range_signed_handle, :bt_integer_range_signed_handle],
                  :bt_bool

  BTIntegerRangeSetAddRangeStatus = enum :bt_integer_range_set_add_range_status,
    [ :BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_OK, BT_FUNC_STATUS_OK,
      :BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_MEMORY_ERROR, BT_FUNC_STATUS_MEMORY_ERROR]

  attach_function :bt_integer_range_set_get_range_count,
                  [:bt_integer_range_set_handle],
                  :uint64

  class BTIntergerRangeSet < BTSharedObject
    AddRangeStatus = BTIntegerRangeSetAddRangeStatus

    def get_range_count
      return Babeltrace2.bt_integer_range_set_get_range_count(@handle)
    end
    alias range_count get_range_count
  end

  attach_function :bt_integer_range_set_unsigned_create,
                  [],
                  :bt_integer_range_set_unsigned_handle

  attach_function :bt_integer_range_set_unsigned_add_range,
                  [:bt_integer_range_set_unsigned_handle, :uint64, :uint64],
                  :bt_integer_range_set_add_range_status

  attach_function :bt_integer_range_set_unsigned_borrow_range_by_index_const,
                  [:bt_integer_range_set_unsigned_handle, :uint64],
                  :bt_integer_range_unsigned_handle

  attach_function :bt_integer_range_set_unsigned_is_equal,
                  [:bt_integer_range_set_unsigned_handle, :bt_integer_range_set_unsigned_handle],
                  :bt_bool

  attach_function :bt_integer_range_set_unsigned_get_ref,
                  [:bt_integer_range_set_unsigned_handle],
                  :void

  attach_function :bt_integer_range_set_unsigned_put_ref,
                  [:bt_integer_range_set_unsigned_handle],
                  :void

  class BTIntergerRangeSet
    class Unsigned < BTIntergerRangeSet
      @get_ref = :bt_integer_range_set_unsigned_get_ref
      @put_ref = :bt_integer_range_set_unsigned_put_ref
    end

    def initialize(handle = nil)
      if handle
        super(handle, retain: true)
      else
        handle = Babeltrace2.bt_integer_range_set_unsigned_create()
        raise :BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_MEMORY_ERROR if handle.null?
        super(handle)
      end
    end

    def add_range(*args)
      lower, upper = *args
      lower, upper = *[lower.min, lower.max] unless upper
      res = Babeltrace2.bt_integer_range_set_unsigned_add_range(@handle, lower, upper)
      raise res if res != :BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_OK
      self
    end

    def get_range(index)
      return nil if index >= range_count
      handle = Babeltrace2.bt_integer_range_set_unsigned_borrow_range_by_index_const(@handle, index)
      lower = Babeltrace2.bt_integer_range_unsigned_get_lower(handle)
      upper = Babeltrace2.bt_integer_range_unsigned_get_upper(handle)
      return lower..upper
    end
    alias [] get_range
  end
  BTIntergerRangeSetUnsigned = BTIntergerRangeSet::Unsigned

  attach_function :bt_integer_range_set_signed_create,
                  [],
                  :bt_integer_range_set_signed_handle

  attach_function :bt_integer_range_set_signed_add_range,
                  [:bt_integer_range_set_signed_handle, :int64, :int64],
                  :bt_integer_range_set_add_range_status

  attach_function :bt_integer_range_set_signed_borrow_range_by_index_const,
                  [:bt_integer_range_set_signed_handle, :uint64],
                  :bt_integer_range_signed_handle

  attach_function :bt_integer_range_set_signed_is_equal,
                  [:bt_integer_range_set_signed_handle, :bt_integer_range_set_signed_handle],
                  :bt_bool

  attach_function :bt_integer_range_set_signed_get_ref,
                  [:bt_integer_range_set_signed_handle],
                  :void

  attach_function :bt_integer_range_set_signed_put_ref,
                  [:bt_integer_range_set_signed_handle],
                  :void

  class BTIntergerRangeSet
    class Signed < BTIntergerRangeSet
      @get_ref = :bt_integer_range_set_signed_get_ref
      @put_ref = :bt_integer_range_set_signed_put_ref
    end

    def initialize(handle = nil)
      if handle
        super(handle, retain: true)
      else
        handle = Babeltrace2.bt_integer_range_set_signed_create()
        raise :BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_MEMORY_ERROR if handle.null?
        super(handle)
      end
    end

    def add_range(*args)
      lower, upper = *args
      lower, upper = *[lower.min, lower.max] unless upper
      res = Babeltrace2.bt_integer_range_set_signed_add_range(@handle, lower, upper)
      raise res if res != :BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_OK
      self
    end

    def get_range(index)
      return nil if index >= range_count
      handle = Babeltrace2.bt_integer_range_set_signed_borrow_range_by_index_const(@handle, index)
      lower = Babeltrace2.bt_integer_range_signed_get_lower(handle)
      upper = Babeltrace2.bt_integer_range_signed_get_upper(handle)
      return lower..upper
    end
    alias [] get_range
  end
  BTIntergerRangeSetSigned = BTIntergerRangeSet::Signed

end
