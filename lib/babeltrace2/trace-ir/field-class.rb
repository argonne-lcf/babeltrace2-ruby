module Babeltrace2

  BT_FIELD_CLASS_TYPE_BOOL = 1 << 0
  BT_FIELD_CLASS_TYPE_BIT_ARRAY = 1 << 1
  BT_FIELD_CLASS_TYPE_INTEGER = 1 << 2
  BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER = 1 << 3 | BT_FIELD_CLASS_TYPE_INTEGER
  BT_FIELD_CLASS_TYPE_SIGNED_INTEGER = 1 << 4 | BT_FIELD_CLASS_TYPE_INTEGER
  BT_FIELD_CLASS_TYPE_ENUMERATION = 1 << 5
  BT_FIELD_CLASS_TYPE_UNSIGNED_ENUMERATION =
    BT_FIELD_CLASS_TYPE_ENUMERATION | BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER
  BT_FIELD_CLASS_TYPE_SIGNED_ENUMERATION =
    BT_FIELD_CLASS_TYPE_ENUMERATION | BT_FIELD_CLASS_TYPE_SIGNED_INTEGER
  BT_FIELD_CLASS_TYPE_REAL = 1 << 6
  BT_FIELD_CLASS_TYPE_SINGLE_PRECISION_REAL = 1 << 7 | BT_FIELD_CLASS_TYPE_REAL
  BT_FIELD_CLASS_TYPE_DOUBLE_PRECISION_REAL = 1 << 8 | BT_FIELD_CLASS_TYPE_REAL
  BT_FIELD_CLASS_TYPE_STRING = 1 << 9
  BT_FIELD_CLASS_TYPE_STRUCTURE = 1 << 10
  BT_FIELD_CLASS_TYPE_ARRAY = 1 << 11
  BT_FIELD_CLASS_TYPE_STATIC_ARRAY = 1 << 12 | BT_FIELD_CLASS_TYPE_ARRAY
  BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY = 1 << 13 | BT_FIELD_CLASS_TYPE_ARRAY
  BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITHOUT_LENGTH_FIELD =
    1 << 14 | BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY
  BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITH_LENGTH_FIELD =
    1 << 15 | BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY
  BT_FIELD_CLASS_TYPE_OPTION = 1 << 16
  BT_FIELD_CLASS_TYPE_OPTION_WITHOUT_SELECTOR_FIELD =
    1 << 17 | BT_FIELD_CLASS_TYPE_OPTION
  BT_FIELD_CLASS_TYPE_OPTION_WITH_SELECTOR_FIELD =
    1 << 18 | BT_FIELD_CLASS_TYPE_OPTION
  BT_FIELD_CLASS_TYPE_OPTION_WITH_BOOL_SELECTOR_FIELD =
    1 << 19 | BT_FIELD_CLASS_TYPE_OPTION_WITH_SELECTOR_FIELD
  BT_FIELD_CLASS_TYPE_OPTION_WITH_INTEGER_SELECTOR_FIELD =
    1 << 20 | BT_FIELD_CLASS_TYPE_OPTION_WITH_SELECTOR_FIELD
  BT_FIELD_CLASS_TYPE_OPTION_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD =
    1 << 21 | BT_FIELD_CLASS_TYPE_OPTION_WITH_INTEGER_SELECTOR_FIELD
  BT_FIELD_CLASS_TYPE_OPTION_WITH_SIGNED_INTEGER_SELECTOR_FIELD =
    1 << 22 | BT_FIELD_CLASS_TYPE_OPTION_WITH_INTEGER_SELECTOR_FIELD
  BT_FIELD_CLASS_TYPE_VARIANT = 1 << 23
  BT_FIELD_CLASS_TYPE_VARIANT_WITHOUT_SELECTOR_FIELD =
    1 << 24 | BT_FIELD_CLASS_TYPE_VARIANT
  BT_FIELD_CLASS_TYPE_VARIANT_WITH_SELECTOR_FIELD =
    1 << 25 | BT_FIELD_CLASS_TYPE_VARIANT
  BT_FIELD_CLASS_TYPE_VARIANT_WITH_INTEGER_SELECTOR_FIELD =
    1 << 26 | BT_FIELD_CLASS_TYPE_VARIANT_WITH_SELECTOR_FIELD
  BT_FIELD_CLASS_TYPE_VARIANT_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD =
    1 << 27 | BT_FIELD_CLASS_TYPE_VARIANT_WITH_INTEGER_SELECTOR_FIELD
  BT_FIELD_CLASS_TYPE_VARIANT_WITH_SIGNED_INTEGER_SELECTOR_FIELD =
    1 << 28 | BT_FIELD_CLASS_TYPE_VARIANT_WITH_INTEGER_SELECTOR_FIELD
  BTFieldClassType = enum FFI::Type::INT64, :bt_field_class_type,
    [ :BT_FIELD_CLASS_TYPE_BOOL,
       BT_FIELD_CLASS_TYPE_BOOL,
      :BT_FIELD_CLASS_TYPE_BIT_ARRAY,
       BT_FIELD_CLASS_TYPE_BIT_ARRAY,
      :BT_FIELD_CLASS_TYPE_INTEGER,
       BT_FIELD_CLASS_TYPE_INTEGER,
      :BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER,
       BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER,
      :BT_FIELD_CLASS_TYPE_SIGNED_INTEGER,
       BT_FIELD_CLASS_TYPE_SIGNED_INTEGER,
      :BT_FIELD_CLASS_TYPE_ENUMERATION,
       BT_FIELD_CLASS_TYPE_ENUMERATION,
      :BT_FIELD_CLASS_TYPE_UNSIGNED_ENUMERATION,
       BT_FIELD_CLASS_TYPE_UNSIGNED_ENUMERATION,
      :BT_FIELD_CLASS_TYPE_SIGNED_ENUMERATION,
       BT_FIELD_CLASS_TYPE_SIGNED_ENUMERATION,
      :BT_FIELD_CLASS_TYPE_REAL,
       BT_FIELD_CLASS_TYPE_REAL,
      :BT_FIELD_CLASS_TYPE_SINGLE_PRECISION_REAL,
       BT_FIELD_CLASS_TYPE_SINGLE_PRECISION_REAL,
      :BT_FIELD_CLASS_TYPE_DOUBLE_PRECISION_REAL,
       BT_FIELD_CLASS_TYPE_DOUBLE_PRECISION_REAL,
      :BT_FIELD_CLASS_TYPE_STRING,
       BT_FIELD_CLASS_TYPE_STRING,
      :BT_FIELD_CLASS_TYPE_STRUCTURE,
       BT_FIELD_CLASS_TYPE_STRUCTURE,
      :BT_FIELD_CLASS_TYPE_ARRAY,
       BT_FIELD_CLASS_TYPE_ARRAY,
      :BT_FIELD_CLASS_TYPE_STATIC_ARRAY,
       BT_FIELD_CLASS_TYPE_STATIC_ARRAY,
      :BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY,
       BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY,
      :BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITHOUT_LENGTH_FIELD,
       BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITHOUT_LENGTH_FIELD,
      :BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITH_LENGTH_FIELD,
       BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITH_LENGTH_FIELD,
      :BT_FIELD_CLASS_TYPE_OPTION,
       BT_FIELD_CLASS_TYPE_OPTION,
      :BT_FIELD_CLASS_TYPE_OPTION_WITHOUT_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_OPTION_WITHOUT_SELECTOR_FIELD,
      :BT_FIELD_CLASS_TYPE_OPTION_WITH_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_OPTION_WITH_SELECTOR_FIELD,
      :BT_FIELD_CLASS_TYPE_OPTION_WITH_BOOL_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_OPTION_WITH_BOOL_SELECTOR_FIELD,
      :BT_FIELD_CLASS_TYPE_OPTION_WITH_INTEGER_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_OPTION_WITH_INTEGER_SELECTOR_FIELD,
      :BT_FIELD_CLASS_TYPE_OPTION_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_OPTION_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD,
      :BT_FIELD_CLASS_TYPE_OPTION_WITH_SIGNED_INTEGER_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_OPTION_WITH_SIGNED_INTEGER_SELECTOR_FIELD,
      :BT_FIELD_CLASS_TYPE_VARIANT,
       BT_FIELD_CLASS_TYPE_VARIANT,
      :BT_FIELD_CLASS_TYPE_VARIANT_WITHOUT_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_VARIANT_WITHOUT_SELECTOR_FIELD,
      :BT_FIELD_CLASS_TYPE_VARIANT_WITH_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_VARIANT_WITH_SELECTOR_FIELD,
      :BT_FIELD_CLASS_TYPE_VARIANT_WITH_INTEGER_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_VARIANT_WITH_INTEGER_SELECTOR_FIELD,
      :BT_FIELD_CLASS_TYPE_VARIANT_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_VARIANT_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD,
      :BT_FIELD_CLASS_TYPE_VARIANT_WITH_SIGNED_INTEGER_SELECTOR_FIELD,
       BT_FIELD_CLASS_TYPE_VARIANT_WITH_SIGNED_INTEGER_SELECTOR_FIELD ]

  attach_function :bt_field_class_get_type,
                  [ :bt_field_class_handle ],
                  :bt_field_class_type

  attach_function :bt_field_class_set_user_attributes,
                  [ :bt_field_class_handle, :bt_value_map_handle ],
                  :void

  attach_function :bt_field_class_borrow_user_attributes,
                  [ :bt_field_class_handle ],
                  :bt_value_map_handle

  attach_function :bt_field_class_borrow_user_attributes_const,
                  [ :bt_field_class_handle ],
                  :bt_value_map_handle

  attach_function :bt_field_class_get_ref,
                  [ :bt_field_class_handle ],
                  :void

  attach_function :bt_field_class_put_ref,
                  [ :bt_field_class_handle ],
                  :void

  class BTFieldClass < BTSharedObject
    @get_ref = :bt_field_class_get_ref
    @put_ref = :bt_field_class_put_ref

    TYPE_MAP = {}

    def self.from_handle(handle, retain: true, auto_release: true)
      clss = TYPE_MAP[Babeltrace2.bt_field_class_get_type(handle)]
      raise "unsupported field class type" unless clss
      handle = clss[0].new(handle)
      clss[1].new(handle, retain: retain, auto_release: auto_release)
    end

    def get_type
      Babeltrace2.bt_field_class_get_type(@handle)
    end
    alias type get_type

    def type_is(other_type)
      (type & other_type) == other_type
    end
    alias type_is? type_is
    alias type? type_is

    def set_user_attributes(user_attributes)
      Babeltrace2.bt_field_class_set_user_attributes(@handle, BTValue.from_value(user_attributes))
      self
    end

    def user_attributes=(user_attributes)
      set_user_attributes(user_attributes)
      user_attributes
    end

    def get_user_attributes
      BTValueMap.new(Babeltrace2.bt_field_class_borrow_user_attributes(@handle), retain: true)
    end
    alias user_attributes get_user_attributes
  end

  attach_function :bt_field_class_bool_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_bool_handle

  class BTFieldClass::Bool < BTFieldClass
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_bool_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end
  end
  BTFieldClassBool = BTFieldClass::Bool
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_BOOL] = [
    BTFieldClassBoolHandle,
    BTFieldClassBool ]

  attach_function :bt_field_class_bit_array_create,
                  [ :bt_trace_class_handle, :uint64 ],
                  :bt_field_class_bit_array_handle

  attach_function :bt_field_class_bit_array_get_length,
                  [ :bt_field_class_bit_array_handle ],
                  :uint64

  class BTFieldClass::BitArray < BTFieldClass
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil, length: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_bit_array_create(trace_class, length)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def get_length
      Babeltrace2.bt_field_class_bit_array_get_length(@handle)
    end
    alias length get_length
  end
  BTFieldClassBitArray = BTFieldClass::BitArray
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_BIT_ARRAY] = [
    BTFieldClassBitArrayHandle,
    BTFieldClassBitArray ]

  attach_function :bt_field_class_integer_set_field_value_range,
                  [ :bt_field_class_integer_handle, :uint64 ],
                  :void

  attach_function :bt_field_class_integer_get_field_value_range,
                  [ :bt_field_class_integer_handle ],
                  :uint64

  BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_BINARY = 2
  BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_OCTAL = 8
  BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_DECIMAL = 10
  BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_HEXADECIMAL = 16
  BTFieldClassIntegerPreferredDisplayBase =
    enum :bt_field_class_integer_preferred_display_base,
    [ :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_BINARY,
       BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_BINARY,
      :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_OCTAL,
       BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_OCTAL,
      :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_DECIMAL,
       BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_DECIMAL,
      :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_HEXADECIMAL,
       BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_HEXADECIMAL ]

  attach_function :bt_field_class_integer_set_preferred_display_base,
                  [ :bt_field_class_integer_handle,
                    :bt_field_class_integer_preferred_display_base ],
                  :void

  attach_function :bt_field_class_integer_get_preferred_display_base,
                  [ :bt_field_class_integer_handle ],
                  :bt_field_class_integer_preferred_display_base

  class BTFieldClass::Integer < BTFieldClass

    def set_field_value_range(n)
      raise "invalid range" if n < 0 || n > 64
      Babeltrace2.bt_field_class_integer_set_field_value_range(@handle, n)
      self
    end

    def field_value_range=(n)
      set_field_value_range(n)
      n
    end

    def get_field_value_range
      Babeltrace2.bt_field_class_integer_get_field_value_range(@handle)
    end
    alias field_value_range get_field_value_range

    def set_preferred_display_base(preferred_display_base)
      Babeltrace2.bt_field_class_integer_set_preferred_display_base(
        @handle, preferred_display_base)
      self
    end

    def preferred_display_base=(preferred_display_base)
      set_preferred_display_base(preferred_display_base)
      preferred_display_base
    end

    def get_preferred_display_base
      Babeltrace2.bt_field_class_integer_get_preferred_display_base(@handle)
    end
    alias preferred_display_base get_preferred_display_base

    def preferred_display_base_integer
      case preferred_display_base
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_BINARY
        2
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_OCTAL
        8
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_DECIMAL
        10
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_HEXADECIMAL
        16
      else
        preferred_display_base
      end
    end
  end
  BTFieldClassInteger = BTFieldClass::Integer

  attach_function :bt_field_class_integer_unsigned_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_integer_unsigned_handle

  class BTFieldClass::Integer::Unsigned < BTFieldClassInteger
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_integer_unsigned_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end
  end
  BTFieldClass::IntegerUnsigned = BTFieldClass::Integer::Unsigned
  BTFieldClassIntegerUnsigned = BTFieldClass::Integer::Unsigned
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER] = [
    BTFieldClassIntegerUnsignedHandle,
    BTFieldClassIntegerUnsigned ]

  attach_function :bt_field_class_integer_signed_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_integer_signed_handle

  class BTFieldClass::Integer::Signed < BTFieldClassInteger
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_integer_signed_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end
  end
  BTFieldClass::IntegerSigned = BTFieldClass::Integer::Signed
  BTFieldClassIntegerSigned = BTFieldClass::Integer::Signed
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_SIGNED_INTEGER] = [
    BTFieldClassIntegerSignedHandle,
    BTFieldClassIntegerSigned ]

  class BTFieldClass::Real < BTFieldClass
  end
  BTFieldClassReal = BTFieldClass::Real

  attach_function :bt_field_class_real_single_precision_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_real_single_precision_handle

  class BTFieldClass::Real::SinglePrecision < BTFieldClassReal
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_real_single_precision_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end
  end
  BTFieldClass::RealSinglePrecision = BTFieldClass::Real::SinglePrecision
  BTFieldClassRealSinglePrecision = BTFieldClass::Real::SinglePrecision
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_SINGLE_PRECISION_REAL] = [
        BTFieldClassRealSinglePrecisionHandle,
        BTFieldClassRealSinglePrecision ]

  attach_function :bt_field_class_real_double_precision_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_real_double_precision_handle

  class BTFieldClass::Real::DoublePrecision < BTFieldClassReal
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_real_double_precision_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end
  end
  BTFieldClass::RealDoublePrecision = BTFieldClass::Real::DoublePrecision
  BTFieldClassRealDoublePrecision = BTFieldClass::Real::DoublePrecision
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_DOUBLE_PRECISION_REAL] = [
    BTFieldClassRealDoublePrecisionHandle,
    BTFieldClassRealDoublePrecision ]

  BT_FIELD_CLASS_ENUMERATION_GET_MAPPING_LABELS_BY_VALUE_STATUS_OK = BT_FUNC_STATUS_OK
  BT_FIELD_CLASS_ENUMERATION_GET_MAPPING_LABELS_BY_VALUE_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTFieldClassEnumerationGetMappingLabelsForValueStatus =
    enum :bt_field_class_enumeration_get_mapping_labels_for_value_status,
    [ :BT_FIELD_CLASS_ENUMERATION_GET_MAPPING_LABELS_BY_VALUE_STATUS_OK,
       BT_FIELD_CLASS_ENUMERATION_GET_MAPPING_LABELS_BY_VALUE_STATUS_OK,
      :BT_FIELD_CLASS_ENUMERATION_GET_MAPPING_LABELS_BY_VALUE_STATUS_MEMORY_ERROR,
       BT_FIELD_CLASS_ENUMERATION_GET_MAPPING_LABELS_BY_VALUE_STATUS_MEMORY_ERROR ]

  BT_FIELD_CLASS_ENUMERATION_ADD_MAPPING_STATUS_OK = BT_FUNC_STATUS_OK
  BT_FIELD_CLASS_ENUMERATION_ADD_MAPPING_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTFieldClassEnumerationAddMappingStatus =
    enum :bt_field_class_enumeration_add_mapping_status,
    [ :BT_FIELD_CLASS_ENUMERATION_ADD_MAPPING_STATUS_OK,
       BT_FIELD_CLASS_ENUMERATION_ADD_MAPPING_STATUS_OK,
      :BT_FIELD_CLASS_ENUMERATION_ADD_MAPPING_STATUS_MEMORY_ERROR,
       BT_FIELD_CLASS_ENUMERATION_ADD_MAPPING_STATUS_MEMORY_ERROR ]

  attach_function :bt_field_class_enumeration_get_mapping_count,
                  [ :bt_field_class_enumeration_handle ],
                  :uint64

  attach_function :bt_field_class_enumeration_mapping_get_label,
                  [ :bt_field_class_enumeration_mapping_handle ],
                  :string

  module BTFieldClass::Enumeration
    GetMappingLabelsForValueStatus = BTFieldClassEnumerationGetMappingLabelsForValueStatus
    AddMappingStatus = BTFieldClassEnumerationAddMappingStatus

    def get_mapping_count
      Babeltrace2.bt_field_class_enumeration_get_mapping_count(@handle)
    end
    alias mapping_count get_mapping_count
    alias size get_mapping_count

    def get_mapping(map)
      case map
      when Integer
        get_mapping_by_index(map)
      when String, Symbol
        get_mapping_by_label(map)
      else
        raise "unsupported mapping query"
      end
    end
    alias mapping get_mapping

    class Mapping < BTObject
      def get_label
        label = Babeltrace2.bt_field_class_enumeration_mapping_get_label(@handle)
        if label[0] == ':'
          label[1..-1].to_sym
        else
          label
        end
      end
      alias label get_label
    end
  end
  BTFieldClassEnumeration = BTFieldClass::Enumeration
  BTFieldClassEnumerationMapping = BTFieldClass::Enumeration::Mapping

  attach_function :bt_field_class_enumeration_unsigned_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_enumeration_unsigned_handle

  attach_function :bt_field_class_enumeration_unsigned_add_mapping,
                  [ :bt_field_class_enumeration_unsigned_handle, :string,
                    :bt_integer_range_set_unsigned_handle ],
                  :bt_field_class_enumeration_add_mapping_status

  attach_function :bt_field_class_enumeration_unsigned_borrow_mapping_by_index_const,
                  [ :bt_field_class_enumeration_unsigned_handle, :uint64 ],
                  :bt_field_class_enumeration_unsigned_mapping_handle

  attach_function :bt_field_class_enumeration_unsigned_borrow_mapping_by_label_const,
                  [ :bt_field_class_enumeration_unsigned_handle, :string ],
                  :bt_field_class_enumeration_unsigned_mapping_handle

  attach_function :bt_field_class_enumeration_unsigned_get_mapping_labels_for_value,
                  [ :bt_field_class_enumeration_unsigned_handle,
                    :uint64, :pointer, :pointer ],
                  :bt_field_class_enumeration_get_mapping_labels_for_value_status

  attach_function :bt_field_class_enumeration_unsigned_mapping_borrow_ranges_const,
                  [ :bt_field_class_enumeration_unsigned_mapping_handle ],
                  :bt_integer_range_set_unsigned_handle

  class BTFieldClass::Enumeration::Unsigned < BTFieldClass::Integer::Unsigned
    include BTFieldClass::Enumeration
    class Mapping < BTFieldClass::Enumeration::Mapping
      def get_ranges
        BTIntegerRangeSetUnsigned.new(
          Babeltrace2.bt_field_class_enumeration_unsigned_mapping_borrow_ranges_const(
            @handle), retain: true)
      end
      alias ranges get_ranges
    end

    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_enumeration_unsigned_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def add_mapping(label, ranges)
      label = label.inspect if label.kind_of?(Symbol)
      ranges = BTIntegerRangeSetUnsigned.from_value(ranges)
      res = Babeltrace2.bt_field_class_enumeration_unsigned_add_mapping(
              @handle, label, ranges)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_CLASS_ENUMERATION_ADD_MAPPING_STATUS_OK
      self
    end

    def get_mapping_by_index(index)
      count = get_mapping_count
      index += count if index < 0
      return nil if index >= count || index < 0
      handle =
        Babeltrace2.bt_field_class_enumeration_unsigned_borrow_mapping_by_index_const(
          @handle, index)
      BTFieldClassEnumerationUnsignedMapping.new(handle)
    end

    def get_mapping_by_label(label)
      label = label.inspect if label.kind_of?(Symbol)
      handle =
        Babeltrace2.bt_field_class_enumeration_unsigned_borrow_mapping_by_label_const(
          @handle, label)
      BTFieldClassEnumerationUnsignedMapping.new(handle)
    end

    def get_mapping_labels_for_value(value)
      ptr1 = FFI::MemoryPointer.new(:pointer)
      ptr2 = FFI::MemoryPointer.new(:uint64)
      res = Babeltrace2.bt_field_class_enumeration_unsigned_get_mapping_labels_for_value(
              @handle, value, ptr1, ptr2)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_CLASS_ENUMERATION_GET_MAPPING_LABELS_BY_VALUE_STATUS_OK
      count = ptr2.read_uint64
      return [] if count == 0
      ptr1 = ptr1.read_pointer
      ptr1.read_array_of_pointer(count).collect.collect { |v|
        v = v.read_string
        v[0] == ':' ? v[1..-1].to_sym : v
      }
    end
    alias mapping_labels_for_value get_mapping_labels_for_value
  end
  BTFieldClassEnumerationUnsigned = BTFieldClass::Enumeration::Unsigned
  BTFieldClassEnumerationUnsignedMapping = BTFieldClass::Enumeration::Unsigned::Mapping
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_UNSIGNED_ENUMERATION] = [
    BTFieldClassEnumerationUnsignedHandle,
    BTFieldClassEnumerationUnsigned ]

  attach_function :bt_field_class_enumeration_signed_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_enumeration_signed_handle

  attach_function :bt_field_class_enumeration_signed_add_mapping,
                  [ :bt_field_class_enumeration_signed_handle, :string,
                    :bt_integer_range_set_signed_handle ],
                  :bt_field_class_enumeration_add_mapping_status

  attach_function :bt_field_class_enumeration_signed_borrow_mapping_by_index_const,
                  [ :bt_field_class_enumeration_signed_handle, :uint64 ],
                  :bt_field_class_enumeration_signed_mapping_handle

  attach_function :bt_field_class_enumeration_signed_borrow_mapping_by_label_const,
                  [ :bt_field_class_enumeration_signed_handle, :string ],
                  :bt_field_class_enumeration_signed_mapping_handle

  attach_function :bt_field_class_enumeration_signed_get_mapping_labels_for_value,
                  [ :bt_field_class_enumeration_signed_handle,
                    :uint64, :pointer, :pointer ],
                  :bt_field_class_enumeration_get_mapping_labels_for_value_status

  attach_function :bt_field_class_enumeration_signed_mapping_borrow_ranges_const,
                  [ :bt_field_class_enumeration_signed_mapping_handle ],
                  :bt_integer_range_set_signed_handle

  class BTFieldClass::Enumeration::Signed < BTFieldClass::Integer::Signed
    include BTFieldClass::Enumeration
    class Mapping < BTFieldClass::Enumeration::Mapping
      def get_ranges
        BTIntegerRangeSetSigned.new(
          Babeltrace2.bt_field_class_enumeration_signed_mapping_borrow_ranges_const(
            @handle), retain: true)
      end
      alias ranges get_ranges
    end

    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_enumeration_signed_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def add_mapping(label, ranges)
      label = label.inspect if label.kind_of?(Symbol)
      ranges = BTIntegerRangeSetSigned.from_value(ranges)
      res = Babeltrace2.bt_field_class_enumeration_signed_add_mapping(
              @handle, label, ranges)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_CLASS_ENUMERATION_ADD_MAPPING_STATUS_OK
      self
    end

    def get_mapping_by_index(index)
      count = get_mapping_count
      index += count if index < 0
      return nil if index >= count || index < 0
      handle =
        Babeltrace2.bt_field_class_enumeration_signed_borrow_mapping_by_index_const(
          @handle, index)
      BTFieldClassEnumerationSignedMapping.new(handle)
    end

    def get_mapping_by_label(label)
      label = label.inspect if label.kind_of?(Symbol)
      handle =
        Babeltrace2.bt_field_class_enumeration_signed_borrow_mapping_by_label_const(
          @handle, label)
      BTFieldClassEnumerationSignedMapping.new(handle)
    end

    def get_mapping_labels_for_value(value)
      ptr1 = FFI::MemoryPointer.new(:pointer)
      ptr2 = FFI::MemoryPointer.new(:uint64)
      res = Babeltrace2.bt_field_class_enumeration_signed_get_mapping_labels_for_value(
              @handle, value, ptr1, ptr2)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_CLASS_ENUMERATION_GET_MAPPING_LABELS_BY_VALUE_STATUS_OK
      count = ptr2.read_uint64
      return [] if count == 0
      ptr1 = ptr1.read_pointer
      ptr1.read_array_of_pointer(count).collect.collect { |v|
        v = v.read_string
        v[0] == ':' ? v[1..-1].to_sym : v
      }
    end
    alias mapping_labels_for_value get_mapping_labels_for_value
  end
  BTFieldClassEnumerationSigned = BTFieldClass::Enumeration::Signed
  BTFieldClassEnumerationSignedMapping = BTFieldClass::Enumeration::Signed::Mapping
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_SIGNED_ENUMERATION] = [
    BTFieldClassEnumerationSignedHandle,
    BTFieldClassEnumerationSigned ]

  attach_function :bt_field_class_string_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_string_handle

  class BTFieldClass::String < BTFieldClass
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_string_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end
  end
  BTFieldClassString = BTFieldClass::String
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_STRING] = [
    BTFieldClassStringHandle,
    BTFieldClassString ]

  attach_function :bt_field_class_array_borrow_element_field_class,
                  [ :bt_field_class_array_handle ],
                  :bt_field_class_handle
 
  attach_function :bt_field_class_array_borrow_element_field_class_const,
                  [ :bt_field_class_array_handle ],
                  :bt_field_class_handle

  class BTFieldClass::Array < BTFieldClass
    def get_element_field_class
      BTFieldClass.from_handle(
        Babeltrace2.bt_field_class_array_borrow_element_field_class(@handle))
    end
    alias element_field_class get_element_field_class
  end
  BTFieldClassArray = BTFieldClass::Array

  attach_function :bt_field_class_array_static_create,
                  [ :bt_trace_class_handle, :bt_field_class_handle, :uint64 ],
                  :bt_field_class_array_static_handle

  attach_function :bt_field_class_array_static_get_length,
                  [ :bt_field_class_array_static_handle ],
                  :uint64

  class BTFieldClass::Array::Static < BTFieldClass::Array
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil, element_field_class: nil, length: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_array_static_create(
                   trace_class, element_field_class, length)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def get_length
      Babeltrace2.bt_field_class_array_static_get_length(@handle)
    end
    alias length get_length
    alias size get_length
  end
  BTFieldClassArrayStatic = BTFieldClass::Array::Static
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_STATIC_ARRAY] = [
    BTFieldClassArrayStaticHandle,
    BTFieldClassArrayStatic ]

  attach_function :bt_field_class_array_dynamic_create,
                  [ :bt_trace_class_handle, :bt_field_class_handle,
                    :bt_field_class_integer_unsigned_handle ],
                  :bt_field_class_array_dynamic_handle

  attach_function :bt_field_class_array_dynamic_with_length_field_borrow_length_field_path_const,
                  [ :bt_field_class_array_dynamic_handle ],
                  :bt_field_path_handle

  class BTFieldClass::Array::Dynamic < BTFieldClass::Array
    module WithLengthField
      def get_length_field_path
        handle = Babeltrace2.bt_field_class_array_dynamic_with_length_field_borrow_length_field_path_const(@handle)
        return nil if handle.null?
        BTFieldPath.new(handle, retain: true)
      end
      alias length_field_path get_length_field_path
    end
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil, element_field_class: nil, length_field_class: nil)
      if handle
        self.extend(WithLengthField) if Babeltrace2.bt_field_class_get_type(handle) ==
          :BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITH_LENGTH_FIELD
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_array_dynamic_create(
                   trace_class, element_field_class, length_field_class)
        raise Babeltrace2.process_error if handle.null?
        self.extend(WithLengthField) if length_field_class
        super(handle, retain: false)
      end
    end
  end
  BTFieldClassArrayDynamic = BTFieldClass::Array::Dynamic
  BTFieldClassArrayDynamicWithLengthField = BTFieldClass::Array::Dynamic::WithLengthField
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITHOUT_LENGTH_FIELD] = [
    BTFieldClassArrayDynamicHandle,
    BTFieldClassArrayDynamic ]
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITH_LENGTH_FIELD] = [
    BTFieldClassArrayDynamicHandle,
    BTFieldClassArrayDynamic ]

  attach_function :bt_field_class_structure_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_structure_handle

  BT_FIELD_CLASS_STRUCTURE_APPEND_MEMBER_STATUS_OK = BT_FUNC_STATUS_OK
  BT_FIELD_CLASS_STRUCTURE_APPEND_MEMBER_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTFieldClassStructureAppendMemberStatus =
    enum :bt_field_class_structure_append_member_status,
    [ :BT_FIELD_CLASS_STRUCTURE_APPEND_MEMBER_STATUS_OK,
       BT_FIELD_CLASS_STRUCTURE_APPEND_MEMBER_STATUS_OK,
      :BT_FIELD_CLASS_STRUCTURE_APPEND_MEMBER_STATUS_MEMORY_ERROR,
       BT_FIELD_CLASS_STRUCTURE_APPEND_MEMBER_STATUS_MEMORY_ERROR ]

  attach_function :bt_field_class_structure_append_member,
                  [ :bt_field_class_structure_handle, :string, :bt_field_class_handle ],
                  :bt_field_class_structure_append_member_status

  attach_function :bt_field_class_structure_get_member_count,
                  [ :bt_field_class_structure_handle ],
                  :uint64

  attach_function :bt_field_class_structure_borrow_member_by_index,
                  [ :bt_field_class_structure_handle, :uint64],
                  :bt_field_class_structure_member_handle

  attach_function :bt_field_class_structure_borrow_member_by_index_const,
                  [ :bt_field_class_structure_handle, :uint64],
                  :bt_field_class_structure_member_handle

  attach_function :bt_field_class_structure_borrow_member_by_name,
                  [ :bt_field_class_structure_handle, :string ],
                  :bt_field_class_structure_member_handle

  attach_function :bt_field_class_structure_borrow_member_by_name_const,
                  [ :bt_field_class_structure_handle, :string ],
                  :bt_field_class_structure_member_handle

  attach_function :bt_field_class_structure_member_get_name,
                  [ :bt_field_class_structure_member_handle ],
                  :string

  attach_function :bt_field_class_structure_member_borrow_field_class,
                  [ :bt_field_class_structure_member_handle ],
                  :bt_field_class_handle

  attach_function :bt_field_class_structure_member_borrow_field_class_const,
                  [ :bt_field_class_structure_member_handle ],
                  :bt_field_class_handle

  attach_function :bt_field_class_structure_member_set_user_attributes,
                  [ :bt_field_class_structure_member_handle, :bt_value_map_handle ],
                  :void

  attach_function :bt_field_class_structure_member_borrow_user_attributes,
                  [ :bt_field_class_structure_member_handle ],
                  :bt_value_map_handle

  attach_function :bt_field_class_structure_member_borrow_user_attributes_const,
                  [ :bt_field_class_structure_member_handle ],
                  :bt_value_map_handle

  class BTFieldClass::Structure < BTFieldClass
    class Member < BTObject
      def get_name
        name = Babeltrace2.bt_field_class_structure_member_get_name(@handle)
        name[0] == ':' ? name[1..-1].to_sym : name
      end
      alias name get_name

      def get_field_class
        BTFieldClass.from_handle(
          Babeltrace2.bt_field_class_structure_member_borrow_field_class(@handle))
      end
      alias field_class get_field_class

      def set_user_attributes(user_attributes)
        Babeltrace2.bt_field_class_structure_member_set_user_attributes(@handle, BTValue.from_value(user_attributes))
        self
      end

      def user_attributes=(user_attributes)
        set_user_attributes(user_attributes)
        user_attributes
      end

      def get_user_attributes
        BTValueMap.new(Babeltrace2.bt_field_class_structure_member_borrow_user_attributes(@handle), retain: true)
      end
      alias user_attributes get_user_attributes
    end

    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_structure_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def append_member(name, member_field_class)
      name = name.inspect if name.kind_of?(Symbol)
      res = Babeltrace2.bt_field_class_structure_append_member(
              @handle, name, member_field_class)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_CLASS_STRUCTURE_APPEND_MEMBER_STATUS_OK
      self
    end
    alias append append_member

    def get_member_count
      Babeltrace2.bt_field_class_structure_get_member_count(@handle)
    end
    alias member_count get_member_count

    def get_member_by_index(index)
      count = get_member_count
      index += count if index < 0
      return nil if index >= count || index < 0
      BTFieldClassStructureMember.new(
        Babeltrace2.bt_field_class_structure_borrow_member_by_index(@handle, index))
    end

    def get_member_by_name(name)
      name = name.inspect if name.kind_of?(Symbol)
      handle = Babeltrace2.bt_field_class_structure_borrow_member_by_name(@handle, name)
      return nil if handle.null?
      BTFieldClassStructureMember.new(handle)
    end

    def get_member(member)
      case member
      when ::String, ::Symbol
        get_member_by_name(member)
      when ::Integer
        get_member_by_index(member)
      else
        raise TypeError, "wrong type for member query"
      end
    end
    alias [] get_member
  end
  BTFieldClassStructure = BTFieldClass::Structure
  BTFieldClassStructureMember = BTFieldClass::Structure::Member
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_STRUCTURE] = [
    BTFieldClassStructureHandle,
    BTFieldClassStructure ]

  attach_function :bt_field_class_option_borrow_field_class,
                  [ :bt_field_class_option_handle ],
                  :bt_field_class_handle

  attach_function :bt_field_class_option_borrow_field_class_const,
                  [ :bt_field_class_option_handle ],
                  :bt_field_class_handle

  class BTFieldClass::Option < BTFieldClass
    def get_field_class
      BTFieldClass.from_handle(
        Babeltrace2.bt_field_class_option_borrow_field_class(@handle))
    end
    alias field_class get_field_class
  end
  BTFieldClassOption = BTFieldClass::Option

  attach_function :bt_field_class_option_without_selector_create,
                  [ :bt_trace_class_handle, :bt_field_class_handle ],
                  :bt_field_class_option_without_selector_field_handle

  class BTFieldClass::Option::WithoutSelectorField < BTFieldClass::Option
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil, optional_field_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_option_without_selector_create(
                   trace_class, optional_field_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end
  end
  BTFieldClassOptionWithoutSelectorField = BTFieldClass::Option::WithoutSelectorField
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_OPTION_WITHOUT_SELECTOR_FIELD] = [
        BTFieldClassOptionWithoutSelectorFieldHandle,
        BTFieldClassOptionWithoutSelectorField ]

  attach_function :bt_field_class_option_with_selector_field_borrow_selector_field_path_const,
                  [ :bt_field_class_option_with_selector_field_handle ],
                  :bt_field_path_handle

  class BTFieldClass::Option::WithSelectorField < BTFieldClass::Option
    def get_selector_field_path
      handle = Babeltrace2.bt_field_class_option_with_selector_field_borrow_selector_field_path_const(@handle)
      return nil if handle.null?
      BTFieldPath.new(handle, retain: true)
    end
    alias selector_field_path get_selector_field_path
  end
  BTFieldClassOptionWithSelectorField = BTFieldClass::Option::WithSelectorField

  attach_function :bt_field_class_option_with_selector_field_bool_create,
                  [ :bt_trace_class_handle, :bt_field_class_handle,
                    :bt_field_class_bool_handle ],
                  :bt_field_class_option_with_selector_field_bool_handle

  attach_function :bt_field_class_option_with_selector_field_bool_set_selector_is_reversed,
                  [ :bt_field_class_option_with_selector_field_bool_handle,
                    :bt_bool ],
                  :void

  attach_function :bt_field_class_option_with_selector_field_bool_selector_is_reversed,
                  [ :bt_field_class_option_with_selector_field_bool_handle ],
                  :bt_bool

  class BTFieldClass::Option::WithSelectorField::Bool < BTFieldClass::Option::WithSelectorField
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil, optional_field_class: nil, selector_field_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_option_with_selector_field_bool_create(
                   trace_class, optional_field_class, selector_field_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def set_selector_is_reversed(selector_is_reversed)
      Babeltrace2.bt_field_class_option_with_selector_field_bool_set_selector_is_reversed(
        @handle, selector_is_reversed ? BT_TRUE : BT_FALSE)
      self
    end

    def selector_is_reversed=(selector_is_reversed)
      set_selector_is_reversed(selector_is_reversed)
      selector_is_reversed
    end

    def selector_is_reversed
      Babeltrace2.bt_field_class_option_with_selector_field_bool_selector_is_reversed(
        @handle) != BT_FALSE
    end
    alias selector_is_reversed? selector_is_reversed
  end
  BTFieldClassOptionWithSelectorFieldBool = BTFieldClass::Option::WithSelectorField::Bool
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_OPTION_WITH_BOOL_SELECTOR_FIELD] = [
        BTFieldClassOptionWithSelectorFieldBoolHandle,
        BTFieldClassOptionWithSelectorFieldBool ]

  attach_function :bt_field_class_option_with_selector_field_integer_unsigned_create,
                  [ :bt_trace_class_handle, :bt_field_class_handle,
                    :bt_field_class_integer_unsigned_handle,
                    :bt_integer_range_set_unsigned_handle ],
                  :bt_field_class_option_with_selector_field_integer_unsigned_handle

  attach_function :bt_field_class_option_with_selector_field_integer_unsigned_borrow_selector_ranges_const,
                  [ :bt_field_class_option_with_selector_field_integer_unsigned_handle ],
                  :bt_integer_range_set_unsigned_handle

  class BTFieldClass::Option::WithSelectorField::IntegerUnsigned < BTFieldClass::Option::WithSelectorField
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil, optional_field_class: nil, selector_field_class: nil,
                   ranges: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        ranges = BTIntegerRangeSetUnsigned.from_value(ranges)
        handle = Babeltrace2.bt_field_class_option_with_selector_field_integer_unsigned_create(
                   trace_class, optional_field_class, selector_field_class, ranges)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def get_selector_ranges
      BTIntegerRangeSetUnsigned.new(
        Babeltrace2.bt_field_class_option_with_selector_field_integer_unsigned_borrow_selector_ranges_const(
          @handle), retain: true)
    end
    alias selector_ranges get_selector_ranges
  end
  BTFieldClassOptionWithSelectorFieldIntegerUnsigned = BTFieldClass::Option::WithSelectorField::IntegerUnsigned
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_OPTION_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD] = [
    BTFieldClassOptionWithSelectorFieldIntegerUnsignedHandle,
    BTFieldClassOptionWithSelectorFieldIntegerUnsigned ]

  attach_function :bt_field_class_option_with_selector_field_integer_signed_create,
                  [ :bt_trace_class_handle, :bt_field_class_handle,
                    :bt_field_class_integer_signed_handle,
                    :bt_integer_range_set_signed_handle ],
                  :bt_field_class_option_with_selector_field_integer_signed_handle

  attach_function :bt_field_class_option_with_selector_field_integer_signed_borrow_selector_ranges_const,
                  [ :bt_field_class_option_with_selector_field_integer_signed_handle ],
                  :bt_integer_range_set_signed_handle

  class BTFieldClass::Option::WithSelectorField::IntegerSigned < BTFieldClass::Option::WithSelectorField
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil, optional_field_class: nil, selector_field_class: nil,
                   ranges: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        ranges = BTIntegerRangeSetSigned.from_value(ranges)
        handle = Babeltrace2.bt_field_class_option_with_selector_field_integer_signed_create(
                   trace_class, optional_field_class, selector_field_class, ranges)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def get_selector_ranges
      BTIntegerRangeSetSigned.new(
        Babeltrace2.bt_field_class_option_with_selector_field_integer_signed_borrow_selector_ranges_const(
          @handle), retain: true)
    end
    alias selector_ranges get_selector_ranges
  end
  BTFieldClassOptionWithSelectorFieldIntegerSigned = BTFieldClass::Option::WithSelectorField::IntegerSigned
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_OPTION_WITH_SIGNED_INTEGER_SELECTOR_FIELD] = [
   BTFieldClassOptionWithSelectorFieldIntegerSignedHandle,
   BTFieldClassOptionWithSelectorFieldIntegerSigned ]

  attach_function :bt_field_class_variant_create,
                  [ :bt_trace_class_handle, :bt_field_class_integer_handle ],
                  :bt_field_class_variant_handle

  attach_function :bt_field_class_variant_get_option_count,
                  [ :bt_field_class_variant_handle ],
                  :uint64

  attach_function :bt_field_class_variant_borrow_option_by_index,
                  [ :bt_field_class_variant_handle, :uint64 ],
                  :bt_field_class_variant_option_handle

  attach_function :bt_field_class_variant_borrow_option_by_index_const,
                  [ :bt_field_class_variant_handle, :uint64 ],
                  :bt_field_class_variant_option_handle

  attach_function :bt_field_class_variant_borrow_option_by_name,
                  [ :bt_field_class_variant_handle, :string ],
                  :bt_field_class_variant_option_handle

  attach_function :bt_field_class_variant_borrow_option_by_name_const,
                  [ :bt_field_class_variant_handle, :string ],
                  :bt_field_class_variant_option_handle

  attach_function :bt_field_class_variant_option_get_name,
                  [ :bt_field_class_variant_option_handle ],
                  :string

  attach_function :bt_field_class_variant_option_borrow_field_class,
                  [ :bt_field_class_variant_option_handle ],
                  :bt_field_class_handle

  attach_function :bt_field_class_variant_option_borrow_field_class_const,
                  [ :bt_field_class_variant_option_handle ],
                  :bt_field_class_handle

  attach_function :bt_field_class_variant_option_set_user_attributes,
                  [ :bt_field_class_variant_option_handle,
                    :bt_value_map_handle ],
                  :void

  attach_function :bt_field_class_variant_option_borrow_user_attributes,
                  [ :bt_field_class_variant_option_handle ],
                  :bt_value_map_handle

  attach_function :bt_field_class_variant_option_borrow_user_attributes_const,
                  [ :bt_field_class_variant_option_handle ],
                  :bt_value_map_handle

  class BTFieldClass::Variant < BTFieldClass
    class Option < BTObject
      def get_name
        name = Babeltrace2.bt_field_class_variant_option_get_name(@handle)
        name[0] == ':' ? name[1..-1].to_sym : name
      end
      alias name get_name

      def get_field_class
        BTFieldClass.from_handle(
          Babeltrace2.bt_field_class_variant_option_borrow_field_class(@handle))
      end
      alias field_class get_field_class

      def set_user_attributes(user_attributes)
        Babeltrace2.bt_field_class_variant_option_set_user_attributes(@handle,
          BTValue.from_value(user_attributes))
        self
      end

      def user_attributes=(user_attributes)
        set_user_attributes(user_attributes)
        user_attributes
      end

      def get_user_attributes
        BTValueMap.new(
          Babeltrace2.bt_field_class_variant_option_borrow_user_attributes_const(
            @handle), retain: true)
      end
      alias user_attributes get_user_attributes
    end
  end
  BTFieldClassVariantOption = BTFieldClass::Variant::Option

  BT_FIELD_CLASS_VARIANT_WITHOUT_SELECTOR_FIELD_APPEND_OPTION_STATUS_OK = BT_FUNC_STATUS_OK
  BT_FIELD_CLASS_VARIANT_WITHOUT_SELECTOR_FIELD_APPEND_OPTION_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTFieldClassVariantWithoutSelectorAppendOptionStatus =
    enum :bt_field_class_variant_without_selector_append_option_status,
    [ :BT_FIELD_CLASS_VARIANT_WITHOUT_SELECTOR_FIELD_APPEND_OPTION_STATUS_OK,
       BT_FIELD_CLASS_VARIANT_WITHOUT_SELECTOR_FIELD_APPEND_OPTION_STATUS_OK,
      :BT_FIELD_CLASS_VARIANT_WITHOUT_SELECTOR_FIELD_APPEND_OPTION_STATUS_MEMORY_ERROR,
       BT_FIELD_CLASS_VARIANT_WITHOUT_SELECTOR_FIELD_APPEND_OPTION_STATUS_MEMORY_ERROR ]

  attach_function :bt_field_class_variant_without_selector_append_option,
                  [ :bt_field_class_variant_handle, :string,
                    :bt_field_class_handle ],
                  :bt_field_class_variant_without_selector_append_option_status

  BT_FIELD_CLASS_VARIANT_WITH_SELECTOR_FIELD_APPEND_OPTION_STATUS_OK = BT_FUNC_STATUS_OK
  BT_FIELD_CLASS_VARIANT_WITH_SELECTOR_FIELD_APPEND_OPTION_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTFieldClassVariantWithSelectorAppendOptionStatus = 
    enum :bt_field_class_variant_with_selector_field_integer_append_option_status,
    [ :BT_FIELD_CLASS_VARIANT_WITH_SELECTOR_FIELD_APPEND_OPTION_STATUS_OK,
       BT_FIELD_CLASS_VARIANT_WITH_SELECTOR_FIELD_APPEND_OPTION_STATUS_OK,
      :BT_FIELD_CLASS_VARIANT_WITH_SELECTOR_FIELD_APPEND_OPTION_STATUS_MEMORY_ERROR,
       BT_FIELD_CLASS_VARIANT_WITH_SELECTOR_FIELD_APPEND_OPTION_STATUS_MEMORY_ERROR ]

  attach_function :bt_field_class_variant_with_selector_field_borrow_selector_field_path_const,
                  [ :bt_field_class_variant_handle ],
                  :bt_field_path_handle

  attach_function :bt_field_class_variant_with_selector_field_integer_unsigned_append_option,
                  [ :bt_field_class_variant_handle, :string,
                    :bt_field_class_handle, :bt_integer_range_set_unsigned_handle ],
                  :bt_field_class_variant_with_selector_field_integer_append_option_status

  attach_function :bt_field_class_variant_with_selector_field_integer_unsigned_borrow_option_by_index_const,
                  [ :bt_field_class_variant_handle, :uint64 ],
                  :bt_field_class_variant_with_selector_field_integer_unsigned_option_handle

  attach_function :bt_field_class_variant_with_selector_field_integer_unsigned_borrow_option_by_name_const,
                  [ :bt_field_class_variant_handle, :string ],
                  :bt_field_class_variant_with_selector_field_integer_unsigned_option_handle

  attach_function :bt_field_class_variant_with_selector_field_integer_unsigned_option_borrow_ranges_const,
                  [ :bt_field_class_variant_with_selector_field_integer_unsigned_option_handle ],
                  :bt_integer_range_set_unsigned_handle

  attach_function :bt_field_class_variant_with_selector_field_integer_signed_append_option,
                  [ :bt_field_class_variant_handle, :string,
                    :bt_field_class_handle, :bt_integer_range_set_signed_handle ],
                  :bt_field_class_variant_with_selector_field_integer_append_option_status

  attach_function :bt_field_class_variant_with_selector_field_integer_signed_borrow_option_by_index_const,
                  [ :bt_field_class_variant_handle, :uint64 ],
                  :bt_field_class_variant_with_selector_field_integer_signed_option_handle

  attach_function :bt_field_class_variant_with_selector_field_integer_signed_borrow_option_by_name_const,
                  [ :bt_field_class_variant_handle, :string ],
                  :bt_field_class_variant_with_selector_field_integer_signed_option_handle

  attach_function :bt_field_class_variant_with_selector_field_integer_signed_option_borrow_ranges_const,
                  [ :bt_field_class_variant_with_selector_field_integer_signed_option_handle ],
                  :bt_integer_range_set_signed_handle

  class BTFieldClass::Variant
    module WithoutSelectorField
      AppendOptionStatus = BTFieldClassVariantWithoutSelectorAppendOptionStatus
      def append_option(name, option_field_class)
        name = name.inspect if name.kind_of?(Symbol)
        res = Babeltrace2.bt_field_class_variant_without_selector_append_option(
                @handle, name, option_field_class)
        raise Babeltrace2.process_error(res) if res != :BT_FIELD_CLASS_VARIANT_WITHOUT_SELECTOR_FIELD_APPEND_OPTION_STATUS_OK
        self
      end
      alias append append_option
    end
    module WithSelectorField
      AppendOptionStatus = BTFieldClassVariantWithSelectorAppendOptionStatus
      def get_selector_field_path
        handle = Babeltrace2.bt_field_class_variant_with_selector_field_borrow_selector_field_path_const(@handle)
        return nil if handle.null?
        BTFieldPath.new(handle, retain: true)
      end
      alias selector_field_path get_selector_field_path
      module IntegerUnsigned
        class Option < BTFieldClassVariantOption
         def get_ranges
            BTIntegerRangeSetUnsigned.new(
              Babeltrace2.bt_field_class_variant_with_selector_field_integer_unsigned_option_borrow_ranges_const(
                @handle), retain: true)
         end
         alias ranges get_ranges
        end
        include WithSelectorField
        def append_option(name, option_field_class, ranges)
          name = name.inspect if name.kind_of?(Symbol)
          ranges = BTIntegerRangeSetUnsigned.from_value(ranges)
          res = Babeltrace2.bt_field_class_variant_with_selector_field_integer_unsigned_append_option(
                  @handle, name, option_field_class, ranges)
          raise Babeltrace2.process_error(res) if res != :BT_FIELD_CLASS_VARIANT_WITH_SELECTOR_FIELD_APPEND_OPTION_STATUS_OK
          self
        end
        alias append append_option

        def get_option_by_index(index)
          count = get_option_count
          index += count if index < 0
          return nil if index >= count || index < 0
          BTFieldClassVariantWithSelectorFieldIntegerUnsignedOption.new(
            Babeltrace2.bt_field_class_variant_with_selector_field_integer_unsigned_borrow_option_by_index_const(
              @handle, index))
        end

        def get_option_by_name(name)
          name = name.inspect if name.kind_of?(Symbol)
          handle = Babeltrace2.bt_field_class_variant_with_selector_field_integer_unsigned_borrow_option_by_name_const(@handle, name)
          return nil if handle.null?
          BTFieldClassVariantWithSelectorFieldIntegerUnsignedOption.new(handle)
        end
      end
      module IntegerSigned
        class Option < BTFieldClassVariantOption
         def get_ranges
            BTIntegerRangeSetSigned.new(
              Babeltrace2.bt_field_class_variant_with_selector_field_integer_signed_option_borrow_ranges_const(
                @handle), retain: true)
         end
         alias ranges get_ranges
        end
        include WithSelectorField
        def append_option(name, option_field_class, ranges)
          name = name.inspect if name.kind_of?(Symbol)
          ranges = BTIntegerRangeSetSigned.from_value(ranges)
          res = Babeltrace2.bt_field_class_variant_with_selector_field_integer_signed_append_option(
                  @handle, name, option_field_class, ranges)
          raise Babeltrace2.process_error(res) if res != :BT_FIELD_CLASS_VARIANT_WITH_SELECTOR_FIELD_APPEND_OPTION_STATUS_OK
          self
        end
        alias append append_option

        def get_option_by_index(index)
          count = get_option_count
          index += count if index < 0
          return nil if index >= count || index < 0
          BTFieldClassVariantWithSelectorFieldIntegerSignedOption.new(
            Babeltrace2.bt_field_class_variant_with_selector_field_integer_signed_borrow_option_by_index_const(@handle, index))
        end

        def get_option_by_name(name)
          name = name.inspect if name.kind_of?(Symbol)
          handle = Babeltrace2.bt_field_class_variant_with_selector_field_integer_signed_borrow_option_by_name_const(@handle, name)
          return nil if handle.null?
          BTFieldClassVariantWithSelectorFieldIntegerSignedOption.new(handle)
        end
      end
    end
    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil, selector_field_class: nil)
      if handle
        case Babeltrace2.bt_field_class_get_type(handle)
        when :BT_FIELD_CLASS_TYPE_VARIANT_WITHOUT_SELECTOR_FIELD
          self.extend(BTFieldClass::Variant::WithoutSelectorField)
        when :BT_FIELD_CLASS_TYPE_VARIANT_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD
          self.extend(BTFieldClass::Variant::WithSelectorField::IntegerUnsigned)
        when :BT_FIELD_CLASS_TYPE_VARIANT_WITH_SIGNED_INTEGER_SELECTOR_FIELD
          self.extend(BTFieldClass::Variant::WithSelectorField::IntegerSigned)
        else
          raise "unsupported variant type"
        end
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle =
          Babeltrace2.bt_field_class_variant_create(trace_class, selector_field_class)
        raise Babeltrace2.process_error if handle.null?
        case Babeltrace2.bt_field_class_get_type(handle)
        when :BT_FIELD_CLASS_TYPE_VARIANT_WITHOUT_SELECTOR_FIELD
          self.extend(BTFieldClass::Variant::WithoutSelectorField)
        when :BT_FIELD_CLASS_TYPE_VARIANT_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD
          self.extend(BTFieldClass::Variant::WithSelectorField::IntegerUnsigned)
        when :BT_FIELD_CLASS_TYPE_VARIANT_WITH_SIGNED_INTEGER_SELECTOR_FIELD
          self.extend(BTFieldClass::Variant::WithSelectorField::IntegerSigned)
        else
          raise "unsupported variant type"
        end
        super(handle, retain: false)
      end
    end

    def get_option_count
      Babeltrace2.bt_field_class_variant_get_option_count(@handle)
    end
    alias option_count get_option_count

    def get_option_by_index(index)
      count = get_option_count
      index += count if index < 0
      return nil if index >= count || index < 0
      BTFieldClassVariantOption.new(
        Babeltrace2.bt_field_class_variant_borrow_option_by_index(@handle, index))
    end

    def get_option_by_name(name)
      name = name.inspect if name.kind_of?(Symbol)
      handle = Babeltrace2.bt_field_class_variant_borrow_option_by_name(@handle, name)
      return nil if handle.null?
      BTFieldClassVariantOption.new(handle)
    end

    def get_option(option)
      case option
      when ::String, Symbol
        get_option_by_name(option)
      when ::Integer
        get_option_by_index(option)
      else
        raise TypeError, "wrong type for option query"
      end
    end
    alias [] get_option

  end
  BTFieldClassVariantWithoutSelectorField =
    BTFieldClass::Variant::WithoutSelectorField
  BTFieldClassVariantWithSelectorFieldIntegerUnsigned =
    BTFieldClass::Variant::WithSelectorField::IntegerUnsigned
  BTFieldClassVariantWithSelectorFieldIntegerSigned =
    BTFieldClass::Variant::WithSelectorField::IntegerSigned
  BTFieldClassVariantWithSelectorFieldIntegerUnsignedOption =
    BTFieldClass::Variant::WithSelectorField::IntegerUnsigned::Option
  BTFieldClassVariantWithSelectorFieldIntegerSignedOption =
    BTFieldClass::Variant::WithSelectorField::IntegerSigned::Option
  BTFieldClassVariant = BTFieldClass::Variant
  vcls = [ 
    BTFieldClassVariantHandle,
    BTFieldClassVariant ]
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_VARIANT_WITHOUT_SELECTOR_FIELD] = vcls
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_VARIANT_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD] = vcls
  BTFieldClass::TYPE_MAP[:BT_FIELD_CLASS_TYPE_VARIANT_WITH_SIGNED_INTEGER_SELECTOR_FIELD] = vcls
end
