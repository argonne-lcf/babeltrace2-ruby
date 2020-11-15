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
                  [ :bt_field_class_handle, :bt_value_handle ],
                  :void

  attach_function :bt_field_class_borrow_user_attributes,
                  [ :bt_field_class_handle ],
                  :bt_value_handle

  attach_function :bt_field_class_borrow_user_attributes_const,
                  [ :bt_field_class_handle ],
                  :bt_value_handle

  attach_function :bt_field_class_get_ref,
                  [ :bt_field_class_handle ],
                  :void

  attach_function :bt_field_class_put_ref,
                  [ :bt_field_class_handle ],
                  :void

  class BTFieldClass < BTSharedObject
    @get_ref = :bt_field_class_get_ref
    @put_ref = :bt_field_class_put_ref

    def from_handle(handle, retain: true, auto_release: true)
      case Babeltrace2.bt_field_class_get_type(handle)
      when :BT_FIELD_CLASS_TYPE_BOOL
        BTFieldClassBool
      when :BT_FIELD_CLASS_TYPE_BIT_ARRAY
        BTFieldClassBitArray
      when :BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER
        BTFieldClassIntegerUnsigned
      when :BT_FIELD_CLASS_TYPE_SIGNED_INTEGER
        BTFieldClassIntegerSigned
      else
        raise "unsupported field type"
      end.new(handle, retain: retain, auto_release: auto_release)
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
      BTValue.from_handle(Babeltrace2.bt_field_class_borrow_user_attributes(@handle))
    end
    alias user_attributes get_user_attributes
  end

  attach_function :bt_field_class_bool_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_handle

  class BTFieldClass::Bool < BTFieldClass
    def initialize(handle, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_bool_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end
  end
  BTFieldClassBool = BTFieldClass::Bool

  attach_function :bt_field_class_bit_array_create,
                  [ :bt_trace_class_handle, :uint64 ],
                  :bt_field_class_handle

  attach_function :bt_field_class_bit_array_get_length,
                  [ :bt_trace_class_handle ],
                  :uint64

  class BTFieldClass::BitArray < BTFieldClass
    def initialize(handle, retain: true, auto_release: true,
                   trace_class: nil, length: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_bit_array_create(trace_class, length)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def get_length
      Babeltrace2.bt_field_class_bit_array_get_length(@handle)
    end
    alias length get_length
  end
  BTFieldClassBitArray = BTFieldClass::BitArray

  attach_function :bt_field_class_integer_set_field_value_range,
                  [ :bt_field_class_handle, :uint64 ],
                  :void

  attach_function :bt_field_class_integer_get_field_value_range,
                  [ :bt_field_class_handle ],
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
                  [ :bt_field_class_handle,
                    :bt_field_class_integer_preferred_display_base ],
                  :void

  attach_function :bt_field_class_integer_get_preferred_display_base,
                  [ :bt_field_class_handle ],
                  :bt_field_class_integer_preferred_display_base

  class BTFieldClass::Integer < BTFieldClass

    def set_field_value_range(n)
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
  end
  BTFieldClassInteger = BTFieldClass::Integer

  attach_function :bt_field_class_integer_unsigned_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_handle

  class BTFieldClass::Integer::Unsigned < BTFieldClassInteger
    def initialize(handle, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_integer_unsigned_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end
  end
  BTFieldClass::IntegerUnsigned = BTFieldClass::Integer::Unsigned
  BTFieldClassIntegerUnsigned = BTFieldClass::Integer::Unsigned

  attach_function :bt_field_class_integer_signed_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_handle

  class BTFieldClass::Integer::Signed < BTFieldClassInteger
    def initialize(handle, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_integer_signed_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end
  end
  BTFieldClass::IntegerSigned = BTFieldClass::Integer::Signed
  BTFieldClassIntegerSigned = BTFieldClass::Integer::Signed

  class BTFieldClass::Real < BTFieldClass
  end
  BTFieldClassReal = BTFieldClass::Real

  attach_function :bt_field_class_real_single_precision_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_handle

  class BTFieldClass::Real::SinglePrecision < BTFieldClassReal
    def initialize(handle, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_real_single_precision_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end
  end
  BTFieldClass::RealSinglePrecision = BTFieldClass::Real::SinglePrecision
  BTFieldClassRealSinglePrecision = BTFieldClass::Real::SinglePrecision

  attach_function :bt_field_class_real_double_precision_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_handle

  class BTFieldClass::Real::DoublePrecision < BTFieldClassReal
    def initialize(handle, retain: true, auto_release: true,
                   trace_class: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_real_double_precision_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end
  end
  BTFieldClass::RealDoublePrecision = BTFieldClass::Real::DoublePrecision
  BTFieldClassRealDoublePrecision = BTFieldClass::Real::DoublePrecision

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
                  [ :bt_field_class_handle ],
                  :uint64

  attach_function :bt_field_class_enumeration_mapping_get_label,
                  [ :bt_field_class_enumeration_mapping_handle ],
                  :string

  class BTFieldClass::Enumeration < BTFieldClass
    GetMappingLabelsForValueStatus = BTFieldClassEnumerationGetMappingLabelsForValueStatus
    AddMappingStatus = BTFieldClassEnumerationAddMappingStatus

    def get_mapping_count
      Babeltrace2.bt_field_class_enumeration_get_mapping_count(@handle)
    end
    alias mapping_count get_mapping_count
    alias size get_mapping_count

    class Mapping < BTObject
      def get_label
        label = Babeltrace2.bt_field_class_enumeration_mapping_get_label(@handle)
        label.sub(/^:/, "").to_sym if label.match(/^:/)
      end
      alias label get_label
    end
  end
  BTFieldClassEnumeration = BTFieldClass::Enumeration
  BTFieldClassEnumerationMapping = BTFieldClass::Enumeration::Mapping

  attach_function :bt_field_class_enumeration_unsigned_create,
                  [ :bt_trace_class_handle ],
                  :bt_field_class_handle

  attach_function :bt_field_class_enumeration_unsigned_add_mapping,
                  [ :bt_field_class_handle, :string,
                    :bt_integer_range_set_unsigned_handle ],
                  :bt_field_class_enumeration_add_mapping_status

  attach_function :bt_field_class_enumeration_unsigned_borrow_mapping_by_index_const,
                  [ :bt_field_class_handle, :uint64 ],
                  :bt_field_class_enumeration_unsigned_mapping_handle

  attach_function :bt_field_class_enumeration_unsigned_borrow_mapping_by_label_const,
                  [ :bt_field_class_handle, :string ],
                  :bt_field_class_enumeration_unsigned_mapping_handle

  class BTFieldClass::Enumeration::Unsigned < BTFieldClass::Enumeration
    class Mapping < BTFieldClass::Enumeration::Mapping
    end
    def initialize(handle, retain: true, auto_release: true)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_field_class_enumeration_unsigned_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def add_mapping(label, ranges)
      label = ":#{label}" if label.kind_of?(Symbol)
      ranges = BTIntegerRangeSetUnsigned.from_value(ranges)
      res = Babeltrace2.bt_field_class_enumeration_unsigned_add_mapping(
              @handle, label, ranges)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_CLASS_ENUMERATION_ADD_MAPPING_STATUS_OK
      self
    end

    def get_mapping_by_index(index)
      return nil if index >= get_mapping_count
      handle =
        Babeltrace2.bt_field_class_enumeration_unsigned_borrow_mapping_by_index_const(
          @handle, index)
      BTFieldClassEnumerationUnsignedMapping.new(handle)
    end

    def get_mapping_by_label(label)
      label = ":#{label}" if label.kind_of?(Symbol)
      handle =
        Babeltrace2.bt_field_class_enumeration_unsigned_borrow_mapping_by_label_const(
          @handle, index)
      BTFieldClassEnumerationUnsignedMapping.new(handle)
    end
  end
  BTFieldClassEnumerationUnsigned = BTFieldClass::Enumeration::Unsigned
  BTFieldClassEnumerationUnsignedMapping = BTFieldClass::Enumeration::Unsigned::Mapping
end
