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

  class BTIntegerRange < BTObject
    def value
      lower..upper
    end

    def include?(val)
      lower <= val && upper >= val
    end
  end

  class BTIntegerRangeUnsigned < BTIntegerRange
    def get_lower
      Babeltrace2.bt_integer_range_unsigned_get_lower(@handle)
    end
    alias lower get_lower
    alias min get_lower

    def get_upper
      Babeltrace2.bt_integer_range_unsigned_get_upper(@handle)
    end
    alias upper get_upper
    alias max get_upper

    def is_equal(other)
      Babeltrace2.bt_integer_range_unsigned_is_equal(other) != BT_FALSE
    end
    alias == is_equal
  end

  attach_function :bt_integer_range_signed_get_lower,
                  [:bt_integer_range_signed_handle],
                  :int64

  attach_function :bt_integer_range_signed_get_upper,
                  [:bt_integer_range_signed_handle],
                  :int64

  attach_function :bt_integer_range_signed_is_equal,
                  [:bt_integer_range_signed_handle, :bt_integer_range_signed_handle],
                  :bt_bool

  class BTIntegerRangeSigned < BTIntegerRange
    def get_lower
      Babeltrace2.bt_integer_range_signed_get_lower(@handle)
    end
    alias lower get_lower

    def get_upper
      Babeltrace2.bt_integer_range_signed_get_upper(@handle)
    end
    alias upper get_upper

    def is_equal(other)
      Babeltrace2.bt_integer_range_signed_is_equal(other) != BT_FALSE
    end
    alias == is_equal
  end

  BTIntegerRangeSetAddRangeStatus = enum :bt_integer_range_set_add_range_status,
    [ :BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_OK, BT_FUNC_STATUS_OK,
      :BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_MEMORY_ERROR, BT_FUNC_STATUS_MEMORY_ERROR]

  attach_function :bt_integer_range_set_get_range_count,
                  [:bt_integer_range_set_handle],
                  :uint64

  class BTIntegerRangeSet < BTSharedObject
    AddRangeStatus = BTIntegerRangeSetAddRangeStatus

    def self.from_value(value)
      case value
      when self
        return value
      when Array
        range = self.new
        range.push(*value)
      else
        range = self.new
        range.add_range(value)
      end
    end

    def get_range_count
      return Babeltrace2.bt_integer_range_set_get_range_count(@handle)
    end
    alias range_count get_range_count
    alias size get_range_count

    def get_ranges
      range_count.times.collect { |i|
        get_range(i)
      }
    end
    alias ranges get_ranges
    alias to_a get_ranges

    def push(*args)
      args.each { |arg| add_range(arg) }
      self
    end

    def each
      if block_given?
        range_count.times.each { |i|
          yield get_range(i)
        }
      else
        to_enum(:each)
      end
    end

    def value
      each.collect(&:value).to_a
    end

    private
    def range_arg_get(lower, upper)
      if not upper
        case lower
        when BTIntegerRange, Range, Array
          upper = lower.max
          lower = lower.min
        else
          upper = lower
        end
      end
      [lower, upper]
    end
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

  class BTIntegerRangeSet
    class Unsigned < BTIntegerRangeSet
      @get_ref = :bt_integer_range_set_unsigned_get_ref
      @put_ref = :bt_integer_range_set_unsigned_put_ref

      def initialize(handle = nil, retain: true, auto_release: true)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = Babeltrace2.bt_integer_range_set_unsigned_create()
          raise Babeltrace2.process_error if handle.null?
          super(handle)
        end
      end

      def add_range(lower, upper = nil)
        res = Babeltrace2.bt_integer_range_set_unsigned_add_range(
                @handle, *range_arg_get(lower, upper))
        raise Babeltrace2.process_error(res) if res != :BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_OK
        self
      end
      alias add add_range

      def get_range(index)
        count = range_count
        index += count if count < 0
        return nil if index >= count || index < 0
        BTIntegerRangeUnsigned.new(
          Babeltrace2.bt_integer_range_set_unsigned_borrow_range_by_index_const(
            @handle, index))
      end
      alias [] get_range

      def is_equal(other)
        Babeltrace2.bt_integer_range_set_unsigned_is_equal(@handle, other) != BT_FALSE
      end
      alias == is_equal
    end
  end
  BTIntegerRangeSetUnsigned = BTIntegerRangeSet::Unsigned

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

  class BTIntegerRangeSet
    class Signed < BTIntegerRangeSet
      @get_ref = :bt_integer_range_set_signed_get_ref
      @put_ref = :bt_integer_range_set_signed_put_ref

      def initialize(handle = nil, retain: true, auto_release: true)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = Babeltrace2.bt_integer_range_set_signed_create()
          raise Babeltrace2.process_error if handle.null?
          super(handle)
        end
      end

      def add_range(lower, upper = nil)
        res = Babeltrace2.bt_integer_range_set_signed_add_range(
                @handle, *range_arg_get(lower, upper))
        raise Babeltrace2.process_error(res) if res != :BT_INTEGER_RANGE_SET_ADD_RANGE_STATUS_OK
        self
      end
      alias add add_range

      def get_range(index)
        count = range_count
        index += count if count < 0
        return nil if index >= count || index < 0
        BTIntegerRangeSigned.new(
          Babeltrace2.bt_integer_range_set_signed_borrow_range_by_index_const(
            @handle, index))
      end
      alias [] get_range

      def is_equal(other)
        Babeltrace2.bt_integer_range_set_signed_is_equal(@handle, other) != BT_FALSE
      end
      alias == is_equal
    end
  end
  BTIntegerRangeSetSigned = BTIntegerRangeSet::Signed

end
