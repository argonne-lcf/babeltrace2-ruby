require 'singleton'
module Babeltrace2

  BT_VALUE_TYPE_NULL = 1 << 0
  BT_VALUE_TYPE_BOOL = 1 << 1
  BT_VALUE_TYPE_INTEGER = 1 << 2
  BT_VALUE_TYPE_UNSIGNED_INTEGER = (1 << 3) | BT_VALUE_TYPE_INTEGER
  BT_VALUE_TYPE_SIGNED_INTEGER = (1 << 4) | BT_VALUE_TYPE_INTEGER
  BT_VALUE_TYPE_REAL = 1 << 5
  BT_VALUE_TYPE_STRING = 1 << 6
  BT_VALUE_TYPE_ARRAY = 1 << 7
  BT_VALUE_TYPE_MAP = 1 << 8

  BTValueType = enum :bt_value_type,
    [ :BT_VALUE_TYPE_NULL, BT_VALUE_TYPE_NULL,
      :BT_VALUE_TYPE_BOOL, BT_VALUE_TYPE_BOOL,
      :BT_VALUE_TYPE_INTEGER, BT_VALUE_TYPE_INTEGER,
      :BT_VALUE_TYPE_UNSIGNED_INTEGER, BT_VALUE_TYPE_UNSIGNED_INTEGER,
      :BT_VALUE_TYPE_SIGNED_INTEGER, BT_VALUE_TYPE_SIGNED_INTEGER,
      :BT_VALUE_TYPE_REAL, BT_VALUE_TYPE_REAL,
      :BT_VALUE_TYPE_STRING, BT_VALUE_TYPE_STRING,
      :BT_VALUE_TYPE_ARRAY, BT_VALUE_TYPE_ARRAY,
      :BT_VALUE_TYPE_MAP, BT_VALUE_TYPE_MAP ]

  attach_function :bt_value_get_type,
                  [:bt_value_handle],
                  :bt_value_type

  BT_VALUE_COPY_STATUS_OK = BT_FUNC_STATUS_OK
  BT_VALUE_COPY_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTValueCopyStatus = enum :bt_value_copy_status,
    [ :BT_VALUE_COPY_STATUS_OK, BT_VALUE_COPY_STATUS_OK,
      :BT_VALUE_COPY_STATUS_MEMORY_ERROR, BT_VALUE_COPY_STATUS_MEMORY_ERROR ]

  attach_function :bt_value_copy,
                  [:bt_value_handle, :pointer],
                  :bt_value_copy_status

  attach_function :bt_value_is_equal,
                  [:bt_value_handle, :bt_value_handle],
                  :bt_bool

  attach_function :bt_value_get_ref,
                  [:bt_value_handle],
                  :void

  attach_function :bt_value_put_ref,
                  [:bt_value_handle],
                  :void

  class BTValue < BTSharedObject
    @get_ref = :bt_value_get_ref
    @put_ref = :bt_value_put_ref

    TYPE_MAP = {}

    def get_type
      Babeltrace2.bt_value_get_type(@handle)
    end
    alias type get_type

    def self.from_handle(handle, retain: true, auto_release: true)
      type = Babeltrace2.bt_value_get_type(handle)
      if type == :BT_VALUE_TYPE_NULL
        return BTValueNull.instance
      else
        clss = TYPE_MAP[type]
        raise "unsupported value type" unless clss
        handle = clss[0].new(handle)
        clss[1].new(handle, retain: retain, auto_release: auto_release)
      end
    end

    def self.from_value(value)
      case value
      when BTValue
        value
      when nil
        return BTValueNull.instance
      when false
        Bool.new(value: false)
      when true
        Bool.new(value: true)
      when ::Integer
        if value > (1<<63) - 1
          BTValueIntegerUnsigned.new(value: value)
        else
          BTValueIntegerSigned.new(value: value)
        end
      when ::Float
        BTValueReal.new(value: value)
      when ::String
        BTValueString.new(value: value)
      when ::Array
        arr = BTValueArray.new
        value.each { |v|
          arr.push(v)
        }
        arr
      when ::Hash
        map = BTValueMap.new
        value.each { |k, v|
          map.insert_entry(k, v)
        }
        map
      else
        raise TypeError, "unsupported value type"
      end
    end

    def to_s
      value.to_s
    end

    def copy
      ptr = FFI::MemoryPointer::new(:pointer)
      res = Babeltrace2.bt_value_copy(@handle, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_VALUE_COPY_STATUS_OK
      BTValue.from_handle(BTValueHandle.new(ptr.read_pointer), retain: false)
    end

    def is_equal(other)
      other = BTValue.from_value(other)
      Babeltrace2.bt_value_is_equal(@handle, other) == BT_FALSE ? false : true
    end
    alias == is_equal
  end

  attach_variable :bt_value_null, :bt_value_null_handle

  class BTValue
    class Null < BTValue
      include Singleton
      def initialize
        super(Babeltrace2.bt_value_null, retain: false, auto_release: false)
      end

      def value
        nil
      end
    end
  end
  BTValueNull = BTValue::Null

  attach_function :bt_value_bool_create,
                  [],
                  :bt_value_bool_handle

  attach_function :bt_value_bool_create_init,
                  [:bt_bool],
                  :bt_value_bool_handle

  attach_function :bt_value_bool_set,
                  [:bt_value_bool_handle, :bt_bool],
                  :void

  attach_function :bt_value_bool_get,
                  [:bt_value_bool_handle],
                  :bt_bool

  class BTValue
    class Bool < BTValue
      def initialize(handle = nil, retain: true, auto_release: true, value: nil)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = if value.nil?
              Babeltrace2.bt_value_bool_create()
            else
              Babeltrace2.bt_value_bool_create_init(value ? BT_TRUE : BT_FALSE)
            end
          raise Babeltrace2.process_error if handle.null?
          super(handle)
        end
      end

      def set(value)
        Babeltrace2.bt_value_bool_set(@handle, value ? BT_TRUE : BT_FALSE)
        self
      end

      def value=(value)
        set(value)
        value
      end

      def get
        Babeltrace2.bt_value_bool_get(@handle) == BT_FALSE ? false : true
      end
      alias value get
    end
  end
  BTValueBool = BTValue::Bool
  BTValue::TYPE_MAP[:BT_VALUE_TYPE_BOOL] = [
    BTValueBoolHandle,
    BTValueBool ]

  class BTValue::Integer < BTValue
  end
  BTValueInteger = BTValue::Integer

  attach_function :bt_value_integer_unsigned_create,
                  [],
                  :bt_value_integer_unsigned_handle

  attach_function :bt_value_integer_unsigned_create_init,
                  [:uint64],
                  :bt_value_integer_unsigned_handle

  attach_function :bt_value_integer_unsigned_set,
                  [:bt_value_integer_unsigned_handle, :uint64],
                  :void

  attach_function :bt_value_integer_unsigned_get,
                  [:bt_value_integer_unsigned_handle],
                  :uint64

  class BTValue::Integer::Unsigned < BTValue::Integer
    def initialize(handle = nil, retain: true, auto_release: true, value: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = if value.nil?
            Babeltrace2.bt_value_integer_unsigned_create()
          else
            Babeltrace2.bt_value_integer_unsigned_create_init(value)
          end
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def set(value)
      Babeltrace2.bt_value_integer_unsigned_set(@handle, value)
      self
    end

    def value=(value)
      set(value)
      value
    end

    def get
      Babeltrace2.bt_value_integer_unsigned_get(@handle)
    end
    alias value get
    alias to_i get
  end
  BTValue::IntegerUnsigned = BTValue::Integer::Unsigned
  BTValueIntegerUnsigned = BTValue::Integer::Unsigned
  BTValue::TYPE_MAP[:BT_VALUE_TYPE_UNSIGNED_INTEGER] = [
    BTValueIntegerUnsignedHandle,
    BTValueIntegerUnsigned ]

  attach_function :bt_value_integer_signed_create,
                  [],
                  :bt_value_integer_signed_handle

  attach_function :bt_value_integer_signed_create_init,
                  [:int64],
                  :bt_value_integer_signed_handle

  attach_function :bt_value_integer_signed_set,
                  [:bt_value_integer_signed_handle, :int64],
                  :void

  attach_function :bt_value_integer_signed_get,
                  [:bt_value_integer_signed_handle],
                  :int64

  class BTValue::Integer::Signed < BTValue::Integer
    def initialize(handle = nil, retain: true, auto_release: true, value: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = if value.nil?
            Babeltrace2.bt_value_integer_signed_create()
          else
            Babeltrace2.bt_value_integer_signed_create_init(value)
          end
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def set(value)
      Babeltrace2.bt_value_integer_signed_set(@handle, value)
      self
    end

    def value=(value)
      set(value)
      value
    end

    def get
      Babeltrace2.bt_value_integer_signed_get(@handle)
    end
    alias value get
    alias to_i get
  end
  BTValue::IntegerSigned = BTValue::Integer::Signed
  BTValueIntegerSigned = BTValue::Integer::Signed
  BTValue::TYPE_MAP[:BT_VALUE_TYPE_SIGNED_INTEGER] = [
    BTValueIntegerSignedHandle,
    BTValueIntegerSigned ]

  attach_function :bt_value_real_create,
                  [],
                  :bt_value_real_handle

  attach_function :bt_value_real_create_init,
                  [:double],
                  :bt_value_real_handle

  attach_function :bt_value_real_set,
                  [:bt_value_real_handle, :double],
                  :void

  attach_function :bt_value_real_get,
                  [:bt_value_real_handle],
                  :double

  class BTValue::Real < BTValue
    def initialize(handle = nil, retain: true, auto_release: true, value: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = if value.nil?
            Babeltrace2.bt_value_real_create()
          else
            Babeltrace2.bt_value_real_create_init(value)
          end
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def set(value)
      Babeltrace2.bt_value_real_set(@handle, value)
      self
    end

    def value=(value)
      set(value)
      value
    end

    def get
      Babeltrace2.bt_value_real_get(@handle)
    end
    alias value get
    alias to_f get
  end
  BTValueReal = BTValue::Real
  BTValue::TYPE_MAP[:BT_VALUE_TYPE_REAL] = [
    BTValueRealHandle,
    BTValueReal ]

  attach_function :bt_value_string_create,
                  [],
                  :bt_value_handle

  attach_function :bt_value_string_create_init,
                  [:string],
                  :bt_value_handle

  BT_VALUE_STRING_SET_STATUS_OK = BT_FUNC_STATUS_OK
  BT_VALUE_STRING_SET_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTValueStringSetStatus = enum :bt_value_string_set_status,
    [ :BT_VALUE_STRING_SET_STATUS_OK, BT_VALUE_STRING_SET_STATUS_OK,
      :BT_VALUE_STRING_SET_STATUS_MEMORY_ERROR, BT_FUNC_STATUS_MEMORY_ERROR ]

  attach_function :bt_value_string_set,
                  [:bt_value_handle, :string],
                  :bt_value_string_set_status

  attach_function :bt_value_string_get,
                  [:bt_value_handle],
                  :string
  class BTValue
    StringSetStatus = BTValueStringSetStatus
    class String < BTValue
      SetStatus = BTValueStringSetStatus
      def initialize(handle = nil, retain: true, auto_release: true, value: nil)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = if value.nil?
              Babeltrace2.bt_value_string_create()
            else
              Babeltrace2.bt_value_string_create_init(value)
            end
          raise Babeltrace2.process_error if handle.null?
          super(handle)
        end
      end

      def set(value)
        raise TypeError, "value is 'nil'" if value.nil?
        res = Babeltrace2.bt_value_string_set(@handle, value)
        raise Babeltrace2.process_error(res) if res != :BT_VALUE_STRING_SET_STATUS_OK
        self
      end

      def value=(value)
        set(value)
        value
      end

      def get
        Babeltrace2.bt_value_string_get(@handle)
      end
      alias value get
      alias to_s get
    end
  end
  BTValueString = BTValue::String
  BTValue::TYPE_MAP[:BT_VALUE_TYPE_STRING] = [
    BTValueStringHandle,
    BTValueString ]

  attach_function :bt_value_array_create,
                  [],
                  :bt_value_handle

  BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_OK = BT_FUNC_STATUS_OK
  BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTValueArrayAppendElementStatus = enum :bt_value_array_append_element_status,
    [ :BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_OK, BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_OK,
      :BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_MEMORY_ERROR, BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_MEMORY_ERROR ]

  attach_function :bt_value_array_append_element,
                  [:bt_value_handle, :bt_value_handle],
                  :bt_value_array_append_element_status

  attach_function :bt_value_array_append_bool_element,
                  [:bt_value_handle, :bt_bool],
                  :bt_value_array_append_element_status

  attach_function :bt_value_array_append_unsigned_integer_element,
                  [:bt_value_handle, :uint64],
                  :bt_value_array_append_element_status

  attach_function :bt_value_array_append_signed_integer_element,
                  [:bt_value_handle, :int64],
                  :bt_value_array_append_element_status

  attach_function :bt_value_array_append_real_element,
                  [:bt_value_handle, :double],
                  :bt_value_array_append_element_status

  attach_function :bt_value_array_append_string_element,
                  [:bt_value_handle, :string],
                  :bt_value_array_append_element_status

  attach_function :bt_value_array_append_empty_array_element,
                  [:bt_value_handle, :pointer],
                  :bt_value_array_append_element_status

  attach_function :bt_value_array_append_empty_map_element,
                  [:bt_value_handle, :pointer],
                  :bt_value_array_append_element_status

  BT_VALUE_ARRAY_SET_ELEMENT_BY_INDEX_STATUS_OK = BT_FUNC_STATUS_OK
  BT_VALUE_ARRAY_SET_ELEMENT_BY_INDEX_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTValueArraySetElementByIndexStatus = enum :bt_value_array_set_element_by_index_status,
    [ :BT_VALUE_ARRAY_SET_ELEMENT_BY_INDEX_STATUS_OK, BT_VALUE_ARRAY_SET_ELEMENT_BY_INDEX_STATUS_OK,
      :BT_VALUE_ARRAY_SET_ELEMENT_BY_INDEX_STATUS_MEMORY_ERROR, BT_VALUE_ARRAY_SET_ELEMENT_BY_INDEX_STATUS_MEMORY_ERROR ]

  attach_function :bt_value_array_set_element_by_index,
                  [:bt_value_handle, :uint64, :bt_value_handle],
                  :bt_value_array_set_element_by_index_status

  attach_function :bt_value_array_borrow_element_by_index,
                  [:bt_value_handle, :uint64],
                  :bt_value_handle
 
  attach_function :bt_value_array_borrow_element_by_index_const,
                  [:bt_value_handle, :uint64],
                  :bt_value_handle

  attach_function :bt_value_array_get_length,
                  [:bt_value_handle],
                  :uint64

  class BTValue
    ArrayAppendElementStatus = BTValueArrayAppendElementStatus
    ArraySetElementByIndexStatus = BTValueArraySetElementByIndexStatus
    class Array < BTValue
      AppendElementStatus = BTValueArrayAppendElementStatus
      SetElementByIndexStatus = BTValueArraySetElementByIndexStatus

      def initialize(handle = nil, retain: true, auto_release: true)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = Babeltrace2.bt_value_array_create()
          raise Babeltrace2.process_error if handle.null?
          super(handle)
        end
      end

      def append_element(value)
        res = case value
          when BTValue
            Babeltrace2.bt_value_array_append_element(@handle, value)
          when nil
            Babeltrace2.bt_value_array_append_element(@handle, Babeltrace2.bt_value_null)
          when true
            Babeltrace2.bt_value_array_append_bool_element(@handle, BT_TRUE)
          when false
            Babeltrace2.bt_value_array_append_bool_element(@handle, BT_FALSE)
          when ::Integer
            if value > (1<<63) - 1
              Babeltrace2.bt_value_array_append_unsigned_integer_element(@handle, value)
            else
              Babeltrace2.bt_value_array_append_signed_integer_element(@handle, value)
            end
          when ::Float
            Babeltrace2.bt_value_array_append_real_element(@handle, value)
          when ::String
            Babeltrace2.bt_value_array_append_string_element(@handle, value)
          when ::Array
            ptr = FFI::MemoryPointer.new(:pointer)
            res = Babeltrace2.bt_value_array_append_empty_array_element(@handle, ptr)
            raise Babeltrace2.process_error(res) if res != :BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_OK
            arr = BTValueArray.new(BTValueArrayHandle.new(ptr.read_pointer),
                                   retain: false, auto_release: false)
            value.each { |v| arr.append_element(v) }
            :BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_OK
          when ::Hash
            ptr = FFI::MemoryPointer.new(:pointer)
            res = Babeltrace2.bt_value_array_append_empty_map_element(@handle, ptr)
            raise Babeltrace2.process_error(res) if res != :BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_OK
            map = BTValueMap.new(BTValueMapHandle.new(ptr.read_pointer),
                                 retain: false, auto_release: false)
            value.each { |k, v| map.insert_entry(k, v) }
            :BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_OK
          else
            raise TypeError, "unsupported value type"
          end
        raise Babeltrace2.process_error(res) if res != :BT_VALUE_ARRAY_APPEND_ELEMENT_STATUS_OK
        self
      end
      alias push append_element

      def set_element_by_index(index, value)
        raise IndexError, "invalid index" if index < 0 || index >= length
        val = value
        val = BTValue.from_value(val) unless val.kind_of?(BTValue)
        res = Babeltrace2.bt_value_array_set_element_by_index(@handle, index, val)
        raise Babeltrace2.process_error(res) if res != :BT_VALUE_ARRAY_SET_ELEMENT_BY_INDEX_STATUS_OK
        self
      end

      def []=(index, value)
        raise IndexError, "invalid index" if index < 0 || index >= length
        val = value
        val = BTValue.from_value(val) unless val.kind_of?(BTValue)
        res = Babeltrace2.bt_value_array_set_element_by_index(@handle, index, val)
        raise Babeltrace2.process_error(res) if res != :BT_VALUE_ARRAY_SET_ELEMENT_BY_INDEX_STATUS_OK
        value
      end

      def get_element_by_index(index)
        raise IndexError, "invalid index" if index < 0 || index >= length
        handle = Babeltrace2.bt_value_array_borrow_element_by_index(@handle, index)
        BTValue.from_handle(handle)
      end
      alias [] get_element_by_index

      def get_length
        Babeltrace2.bt_value_array_get_length(@handle)
      end
      alias length get_length
      alias size length

      def empty?
        length == 0
      end

      def each
        if block_given?
          length.times { |i|
             yield get_element_by_index(i)
          }
        else
          to_enum(:each)
        end
      end

      def value
        each.collect(&:value)
      end
      alias to_a value
    end
  end
  BTValueArray = BTValue::Array
  BTValue::TYPE_MAP[:BT_VALUE_TYPE_ARRAY] = [
    BTValueArrayHandle,
    BTValueArray ]


  attach_function :bt_value_map_create,
                  [],
                  :bt_value_map_handle

  BT_VALUE_MAP_INSERT_ENTRY_STATUS_OK = BT_FUNC_STATUS_OK
  BT_VALUE_MAP_INSERT_ENTRY_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTValueMapInsertEntryStatus = enum :bt_value_map_insert_entry_status,
    [ :BT_VALUE_MAP_INSERT_ENTRY_STATUS_OK, BT_VALUE_MAP_INSERT_ENTRY_STATUS_OK,
      :BT_VALUE_MAP_INSERT_ENTRY_STATUS_MEMORY_ERROR, BT_VALUE_MAP_INSERT_ENTRY_STATUS_MEMORY_ERROR ]

  attach_function :bt_value_map_insert_entry,
                  [:bt_value_map_handle, :string, :bt_value_handle],
                  :bt_value_map_insert_entry_status

  attach_function :bt_value_map_insert_bool_entry,
                  [:bt_value_map_handle, :string, :bt_bool],
                  :bt_value_map_insert_entry_status

  attach_function :bt_value_map_insert_unsigned_integer_entry,
                  [:bt_value_map_handle, :string, :uint64],
                  :bt_value_map_insert_entry_status

  attach_function :bt_value_map_insert_signed_integer_entry,
                  [:bt_value_map_handle, :string, :int64],
                  :bt_value_map_insert_entry_status

  attach_function :bt_value_map_insert_real_entry,
                  [:bt_value_map_handle, :string, :double],
                  :bt_value_map_insert_entry_status

  attach_function :bt_value_map_insert_string_entry,
                  [:bt_value_map_handle, :string, :string],
                  :bt_value_map_insert_entry_status

  attach_function :bt_value_map_insert_empty_array_entry,
                  [:bt_value_map_handle, :string, :pointer],
                  :bt_value_map_insert_entry_status

  attach_function :bt_value_map_insert_empty_map_entry,
                  [:bt_value_map_handle, :string, :pointer],
                  :bt_value_map_insert_entry_status

  attach_function :bt_value_map_borrow_entry_value,
                  [:bt_value_map_handle, :string],
                  :bt_value_handle

  attach_function :bt_value_map_borrow_entry_value_const,
                  [:bt_value_map_handle, :string],
                  :bt_value_handle

  BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_OK = BT_FUNC_STATUS_OK
  BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_INTERRUPT = BT_FUNC_STATUS_INTERRUPTED
  BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTValueMapForeachEntryFuncStatus = enum :bt_value_map_foreach_entry_func_status,
    [ :BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_OK, BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_OK,
      :BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_INTERRUPT,  BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_INTERRUPT,
      :BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_MEMORY_ERROR, BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_MEMORY_ERROR,
      :BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_ERROR, BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_ERROR ]

  callback :bt_value_map_foreach_entry_func,
           [:string, :bt_value_handle, :pointer],
           :bt_value_map_foreach_entry_func_status

  BT_VALUE_MAP_FOREACH_ENTRY_STATUS_OK = BT_FUNC_STATUS_OK
  BT_VALUE_MAP_FOREACH_ENTRY_STATUS_INTERRUPT = BT_FUNC_STATUS_INTERRUPTED
  BT_VALUE_MAP_FOREACH_ENTRY_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_VALUE_MAP_FOREACH_ENTRY_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTValueMapForeachEntryStatus = enum :bt_value_map_foreach_entry_status,
    [ :BT_VALUE_MAP_FOREACH_ENTRY_STATUS_OK, BT_VALUE_MAP_FOREACH_ENTRY_STATUS_OK,
      :BT_VALUE_MAP_FOREACH_ENTRY_STATUS_INTERRUPT,  BT_VALUE_MAP_FOREACH_ENTRY_STATUS_INTERRUPT,
      :BT_VALUE_MAP_FOREACH_ENTRY_STATUS_MEMORY_ERROR, BT_VALUE_MAP_FOREACH_ENTRY_STATUS_MEMORY_ERROR,
      :BT_VALUE_MAP_FOREACH_ENTRY_STATUS_ERROR, BT_VALUE_MAP_FOREACH_ENTRY_STATUS_ERROR ]

  attach_function :bt_value_map_foreach_entry,
                  [:bt_value_map_handle, :bt_value_map_foreach_entry_func, :pointer],
                  :bt_value_map_foreach_entry_status

  BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_OK = BT_FUNC_STATUS_OK
  BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_INTERRUPT = BT_FUNC_STATUS_INTERRUPTED
  BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTValueMapForeachEntryConstFuncStatus = enum :bt_value_map_foreach_entry_const_func_status,
    [ :BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_OK, BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_OK,
      :BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_INTERRUPT,  BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_INTERRUPT,
      :BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_MEMORY_ERROR, BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_MEMORY_ERROR,
      :BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_ERROR, BT_VALUE_MAP_FOREACH_ENTRY_CONST_FUNC_STATUS_ERROR ]

  callback :bt_value_map_foreach_entry_const_func,
           [:string, :bt_value_handle, :pointer],
           :bt_value_map_foreach_entry_const_func_status

  BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_OK = BT_FUNC_STATUS_OK
  BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_INTERRUPT = BT_FUNC_STATUS_INTERRUPTED
  BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTValueMapForeachEntryConstStatus = enum :bt_value_map_foreach_entry_const_status,
    [ :BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_OK, BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_OK,
      :BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_INTERRUPT,  BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_INTERRUPT,
      :BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_MEMORY_ERROR, BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_MEMORY_ERROR,
      :BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_ERROR, BT_VALUE_MAP_FOREACH_ENTRY_CONST_STATUS_ERROR ]

  attach_function :bt_value_map_foreach_entry_const,
                  [:bt_value_map_handle, :bt_value_map_foreach_entry_const_func,
                   :pointer],
                  :bt_value_map_foreach_entry_const_status

  attach_function :bt_value_map_get_size,
                  [:bt_value_map_handle],
                  :uint64

  attach_function :bt_value_map_has_entry,
                  [:bt_value_map_handle],
                  :bt_bool

  BT_VALUE_MAP_EXTEND_STATUS_OK = BT_FUNC_STATUS_OK
  BT_VALUE_MAP_EXTEND_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTValueMapExtendStatus = enum :bt_value_map_extend_status,
    [ :BT_VALUE_MAP_EXTEND_STATUS_OK, BT_VALUE_MAP_EXTEND_STATUS_OK,
      :BT_VALUE_MAP_EXTEND_STATUS_MEMORY_ERROR, BT_VALUE_MAP_EXTEND_STATUS_MEMORY_ERROR ]

  attach_function :bt_value_map_extend,
                  [:bt_value_map_handle, :bt_value_map_handle],
                  :bt_value_map_extend_status

  class BTValue
    MapForeachEntryFuncStatus = BTValueMapForeachEntryFuncStatus
    MapForeachEntryStatus = BTValueMapForeachEntryStatus
    MapForeachEntryConstFuncStatus = BTValueMapForeachEntryConstFuncStatus
    MapForeachEntryConstStatus = BTValueMapForeachEntryConstStatus
    MapExtendStatus = BTValueMapExtendStatus
    class Map < BTValue
      ForeachEntryFuncStatus = BTValueMapForeachEntryFuncStatus
      ForeachEntryStatus = BTValueMapForeachEntryStatus
      ForeachEntryConstFuncStatus = BTValueMapForeachEntryConstFuncStatus
      ForeachEntryConstStatus = BTValueMapForeachEntryConstStatus
      ExtendStatus = BTValueMapExtendStatus

      def initialize(handle = nil, retain: true, auto_release: true)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = Babeltrace2.bt_value_map_create()
          raise Babeltrace2.process_error if handle.null?
          super(handle)
        end
      end

      def insert_entry(key, value)
        key = ":#{key}" if key.kind_of?(Symbol)
        res = case value
          when BTValue
            Babeltrace2.bt_value_map_insert_entry(@handle, key, value)
          when nil
            Babeltrace2.bt_value_map_insert_entry(@handle, key, Babeltrace2.bt_value_null)
          when true
            Babeltrace2.bt_value_map_insert_bool_entry(@handle, key, BT_TRUE)
          when false
            Babeltrace2.bt_value_map_insert_bool_entry(@handle, key, BT_FALSE)
          when ::Integer
            if value > (1<<63) - 1
              Babeltrace2.bt_value_map_insert_unsigned_integer_entry(@handle, key, value)
            else
              Babeltrace2.bt_value_map_insert_signed_integer_entry(@handle, key, value)
            end
          when ::Float
            Babeltrace2.bt_value_map_insert_real_entry(@handle, key, value)
          when ::String
            Babeltrace2.bt_value_map_insert_string_entry(@handle, key, value)
          when ::Array
            ptr = FFI::MemoryPointer.new(:pointer)
            res = Babeltrace2.bt_value_map_insert_empty_array_entry(@handle, key, ptr)
            raise Babeltrace2.process_error(res) if res != :BT_VALUE_MAP_INSERT_ENTRY_STATUS_OK
            arr = BTValueArray.new(BTValueArrayHandle.new(ptr.read_pointer),
                                   retain: false, auto_release: false)
            value.each { |v| arr.append_element(v) }
            :BT_VALUE_MAP_INSERT_ENTRY_STATUS_OK
          when ::Hash
            ptr = FFI::MemoryPointer.new(:pointer)
            res = Babeltrace2.bt_value_map_insert_empty_map_entry(@handle, key, ptr)
            raise Babeltrace2.process_error(res) if res != :BT_VALUE_MAP_INSERT_ENTRY_STATUS_OK
            map = BTValueMap.new(BTValueMapHandle.new(ptr.read_pointer),
                                 retain: false, auto_release: false)
            value.each { |k, v| map.insert_entry(k, v) }
            :BT_VALUE_MAP_INSERT_ENTRY_STATUS_OK
          else
            raise TypeError, "unsupported value type"
          end
        raise Babeltrace2.process_error(res) if res != :BT_VALUE_MAP_INSERT_ENTRY_STATUS_OK
        self
      end

      def []=(key, value)
        insert_entry(key, value)
        value
      end

      def get_size
        Babeltrace2.bt_value_map_get_size(@handle)
      end
      alias size get_size

      def empty?
        size == 0
      end

      def has_entry(key)
        key = ":#{key}" if key.kind_of?(Symbol)
        Babeltrace2.bt_value_map_has_entry(@handle, key) == BT_FALSE ? false : true
      end
      alias include? has_entry

      def get_entry_value(key)
        key = ":#{key}" if key.kind_of?(Symbol)
        handle = Babeltrace2.bt_value_map_borrow_entry_value(@handle, key)
        return nil if handle.null?
        BTValue.from_handle(handle)
      end
      alias [] get_entry_value

      def each(&block)
        if block_given?
          block_wrapper = lambda { |key, handle, ptr|
            val = BTValue.from_handle(handle)
            key = key.sub(/^:/, "").to_sym if key.match(/^:/)
            block.call(key, val)
            :BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_OK
          }
          Babeltrace2.bt_value_map_foreach_entry(@handle, block_wrapper, nil)
        else
          to_enum(:each)
        end
      end

      def value
        val = {}
        each { |k, v| val[k] = v.value }
        val
      end
      alias to_h value

      def extend!(other)
        res = Babeltrace2.bt_value_map_extend(@handle, other)
        raise Babeltrace2.process_error(res) if res != :BT_VALUE_COPY_STATUS_OK
        self
      end

      def extend(other)
        hsh = self.class.new
        hsh.extend!(self)
        hsh.extend!(other)
      end

    end
  end
  BTValueMap = BTValue::Map
  BTValue::TYPE_MAP[:BT_VALUE_TYPE_MAP] = [
    BTValueMapHandle,
    BTValueMap ]
end
