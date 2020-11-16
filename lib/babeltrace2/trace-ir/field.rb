module Babeltrace2
  attach_function :bt_field_get_class_type,
                  [ :bt_field_handle ],
                  :bt_field_class_type

  attach_function :bt_field_borrow_class,
                  [ :bt_field_handle ],
                  :bt_field_class_handle

  attach_function :bt_field_borrow_class_const,
                  [ :bt_field_handle ],
                  :bt_field_class_handle

  class BTField < BTObject
    TYPE_MAP = {}

    def self.from_handle(handle)
      clss = TYPE_MAP[Babeltrace2.bt_field_get_class_type(handle)]
      raise "unsupported field class type" unless clss
      handle = clss[0].new(handle)
      clss[1].new(handle, retain: retain, auto_release: auto_release)
    end

    def get_class_type
      Babeltrace2.bt_field_get_class_type(@handle)
    end
    alias class_type get_class_type

    def get_class
      @class ||= BTFieldClass.from_handle(Babeltrace2.bt_field_borrow_class(@handle))
    end
  end

  attach_function :bt_field_bool_set_value,
                  [ :bt_field_bool_handle, :bt_bool ],
                  :void

  attach_function :bt_field_bool_get_value,
                  [ :bt_field_bool_handle ],
                  :bt_bool

  class BTField::Bool < BTField
    def set_value(value)
      Babeltrace2.bt_field_bool_set_value(value ? BT_TRUE : BT_FALSE)
      self
    end

    def value=(value)
      set_value(value)
      value
    end

    def get_value
      Babeltrace2.bt_field_bool_get_value(@handle) == BT_FALSE ? false : true
    end
    alias value get_value
  end
  BTFieldBool = BTField::Bool
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_BOOL] = [
    BTFieldBoolHandle,
    BTFieldBool ]

  attach_function :bt_field_bit_array_set_value_as_integer,
                  [ :bt_field_bit_array_handle, :uint64 ],
                  :void

  attach_function :bt_field_bit_array_get_value_as_integer,
                  [ :bt_field_bit_array_handle ],
                  :uint64

  class BTField::BitArray < BTField
    def set_value_as_integer(bits)
      Babeltrace2.bt_field_bit_array_set_value_as_integer(@handle, bits)
      self
    end

    def value_as_integer=(bits)
      set_value_as_integer(bits)
      bits
    end

    def get_value_as_integer
      Babeltrace2.bt_field_bit_array_get_value_as_integer(@handle)
    end
    alias value_as_integer get_value_as_integer

    def get_length
      get_class.get_length
    end
    alias length get_length

    def [](position)
      raise "invalid position" if position > get_length
      get_value_as_integer[position]
    end

    def []=(position, bool)
      raise "invalid position" if position > get_length
      v = get_value_as_integer
      if bool then v |= (1 << position) else v ^= (1 << position) end
      set_value_as_integer(v)
      bool
    end
  end
  BTFieldBitArray = BTField::BitArray
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_BIT_ARRAY] = [
    BTFieldBitArrayHandle,
    BTFieldBitArray ]

  class BTField::Integer < BTField
    def get_field_value_range
      get_class.get_field_value_range
    end
    alias field_value_range get_field_value_range

    def get_preferred_display_base
      get_class.get_preferred_display_base
    end
    alias preferred_display_base get_preferred_display_base
  end
  BTFieldInteger = BTField::Integer

  attach_function :bt_field_integer_unsigned_set_value,
                  [ :bt_field_integer_unsigned_handle, :uint64 ],
                  :void

  attach_function :bt_field_integer_unsigned_get_value,
                  [ :bt_field_integer_unsigned_handle ],
                  :uint64

  class BTField::Integer::Unsigned < BTField::Integer
    def set_value(value)
      raise "invalid range" if (1 << get_field_value_range) - 1 < value || value < 0
      Babeltrace2.bt_field_integer_unsigned_set_value(@handle, value)
      self
    end

    def value=(value)
      set_value(value)
      value
    end

    def get_value
      Babeltrace2.bt_field_integer_unsigned_get_value(@handle)
    end
    alias value get_value

    def get_field_value_range
      get_class.get_field_value_range
    end
    alias field_value_range get_field_value_range

    def get_preferred_display_base
      get_class.get_preferred_display_base
    end
    alias preferred_display_base get_preferred_display_base

    def to_s
      v = get_value
      case preferred_display_base
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_BINARY
        "0b#{v.to_s(2)}"
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_OCTAL
        "0#{v.to_s(8)}"
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_DECIMAL
        v.to_s
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_HEXADECIMAL
        "0x#{v.to_s(16)}"
      else
        raise "invalid preffered display base"
      end
    end
  end
  BTFieldIntegerUnsigned = BTField::Integer::Unsigned
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER] = [
    BTFieldIntegerUnsignedHandle,
    BTFieldIntegerUnsigned ]

  attach_function :bt_field_integer_signed_set_value,
                  [ :bt_field_integer_signed_handle, :uint64 ],
                  :void

  attach_function :bt_field_integer_signed_get_value,
                  [ :bt_field_integer_signed_handle ],
                  :uint64

  class BTField::Integer::Signed < BTField::Integer
    def set_value(value)
      range = get_field_value_range
      raise "invalid range" if (1 << range) - 1 < value || value < -(1 << range)
      Babeltrace2.bt_field_integer_signed_set_value(@handle, value)
      self
    end

    def value=(value)
      set_value(value)
      value
    end

    def get_value
      Babeltrace2.bt_field_integer_signed_get_value(@handle)
    end
    alias value get_value

    def get_twos_complement(v)
      (((v << get_field_value_range) -1) ^ -v) + 1
    end
    private :get_twos_complement

    def to_s
      v = get_value
      case preferred_display_base
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_BINARY
        "0b#{(v < 0 ? get_twos_complement(v) : v).to_s(2)}"
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_OCTAL
        "0#{(v < 0 ? get_twos_complement(v) : v).to_s(8)}"
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_DECIMAL
        v.to_s
      when :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_HEXADECIMAL
        "0x#{(v < 0 ? get_twos_complement(v) : v).to_s(16)}"
      else
        raise "invalid preffered display base"
      end
    end
  end
  BTFieldIntegerSigned = BTField::Integer::Signed
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_SIGNED_INTEGER] = [
    BTFieldIntegerSignedHandle,
    BTFieldIntegerSigned ]

  BT_FIELD_ENUMERATION_GET_MAPPING_LABELS_STATUS_OK = BT_FUNC_STATUS_OK
  BT_FIELD_ENUMERATION_GET_MAPPING_LABELS_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTFieldEnumerationGetMappingLabelsStatus =
    enum :bt_field_enumeration_get_mapping_labels_status,
    [ :BT_FIELD_ENUMERATION_GET_MAPPING_LABELS_STATUS_OK,
       BT_FIELD_ENUMERATION_GET_MAPPING_LABELS_STATUS_OK,
      :BT_FIELD_ENUMERATION_GET_MAPPING_LABELS_STATUS_MEMORY_ERROR,
       BT_FIELD_ENUMERATION_GET_MAPPING_LABELS_STATUS_MEMORY_ERROR ]

  module BTField::Enumeration
    GetMappingLabelsStatus = BTFieldEnumerationGetMappingLabelsStatus
  end
  BTFieldEnumeration = BTField::Enumeration

  attach_function :bt_field_enumeration_unsigned_get_mapping_labels,
                  [ :bt_field_enumeration_unsigned_handle,
                    :pointer, :pointer ],
                  :bt_field_enumeration_get_mapping_labels_status

  class BTField::Enumeration::Unsigned < BTField::Integer::Unsigned
    include BTField::Enumeration
    def get_mapping_labels
      ptr1 = FFI::MemoryPointer.new(:pointer)
      ptr2 = FFI::MemoryPointer.new(:uint64)
      res = Babeltrace2.bt_field_enumeration_unsigned_get_mapping_labels(
              @handle, ptr1, ptr2)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_ENUMERATION_GET_MAPPING_LABELS_STATUS_OK
      count = ptr2.read_uint64
      ptr1.read_array_of_pointer(count).collect(&:read_string)
    end
    alias mapping_labels get_mapping_labels
  end
  BTFieldEnumerationUnsigned = BTField::Enumeration::Unsigned
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_UNSIGNED_ENUMERATION] = [
    BTFieldEnumerationUnsignedHandle,
    BTFieldEnumerationUnsigned ]

  attach_function :bt_field_enumeration_signed_get_mapping_labels,
                  [ :bt_field_enumeration_signed_handle,
                    :pointer, :pointer ],
                  :bt_field_enumeration_get_mapping_labels_status

  class BTField::Enumeration::Signed < BTField::Integer::Signed
    include BTField::Enumeration
    def get_mapping_labels
      ptr1 = FFI::MemoryPointer.new(:pointer)
      ptr2 = FFI::MemoryPointer.new(:uint64)
      res = Babeltrace2.bt_field_enumeration_signed_get_mapping_labels(
              @handle, ptr1, ptr2)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_ENUMERATION_GET_MAPPING_LABELS_STATUS_OK
      count = ptr2.read_uint64
      ptr1.read_array_of_pointer(count).collect(&:read_string)
    end
    alias mapping_labels get_mapping_labels
  end
  BTFieldEnumerationSigned = BTField::Enumeration::Signed
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_SIGNED_ENUMERATION] = [
    BTFieldEnumerationSignedHandle,
    BTFieldEnumerationSigned ]

  class BTField::Real < BTField
  end
  BTFieldReal = BTField::Real

  attach_function :bt_field_real_single_precision_set_value,
                  [ :bt_field_real_single_precision_handle, :float ],
                  :void

  attach_function :bt_field_real_single_precision_get_value,
                  [ :bt_field_real_single_precision_handle ],
                  :float

  class BTField::Real::SinglePrecision < BTField::Real
    def set_value(value)
      Babeltrace2.bt_field_real_single_precision_handle(@handle, value)
      self
    end

    def value=(value)
      set_value(value)
      value
    end

    def get_value
      Babeltrace2.bt_field_real_single_precision_get_value(@handle)
    end
    alias value get_value
  end
  BTFieldRealSinglePrecision = BTField::Real::SinglePrecision
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_SINGLE_PRECISION_REAL] = [
    BTFieldRealSinglePrecisionHandle,
    BTFieldRealSinglePrecision ]

  attach_function :bt_field_real_double_precision_set_value,
                  [ :bt_field_real_double_precision_handle, :double ],
                  :void

  attach_function :bt_field_real_double_precision_get_value,
                  [ :bt_field_real_double_precision_handle ],
                  :double

  class BTField::Real::DoublePrecision < BTField::Real
    def set_value(value)
      Babeltrace2.bt_field_real_double_precision_handle(@handle, value)
      self
    end

    def value=(value)
      set_value(value)
      value
    end

    def get_value
      Babeltrace2.bt_field_real_double_precision_get_value(@handle)
    end
    alias value get_value
  end
  BTFieldRealDoublePrecision = BTField::Real::DoublePrecision
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_DOUBLE_PRECISION_REAL] = [
    BTFieldRealDoublePrecisionHandle,
    BTFieldRealDoublePrecision ]

  BT_FIELD_STRING_SET_VALUE_STATUS_OK = BT_FUNC_STATUS_OK
  BT_FIELD_STRING_SET_VALUE_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTFieldStringSetValueStatus = enum :bt_field_string_set_value_status,
    [ :BT_FIELD_STRING_SET_VALUE_STATUS_OK,
       BT_FIELD_STRING_SET_VALUE_STATUS_OK,
      :BT_FIELD_STRING_SET_VALUE_STATUS_MEMORY_ERROR,
       BT_FIELD_STRING_SET_VALUE_STATUS_MEMORY_ERROR ]

  attach_function :bt_field_string_set_value,
                  [ :bt_field_string_handle, :string ],
                  :bt_field_string_set_value_status

  attach_function :bt_field_string_get_length,
                  [ :bt_field_string_handle ],
                  :uint64

  attach_function :bt_field_string_get_value,
                  [ :bt_field_string_handle ],
                  :string

  attach_function :bt_field_string_get_value_ptr, :bt_field_string_get_value,
                  [ :bt_field_string_handle ],
                  :pointer

  BT_FIELD_STRING_APPEND_STATUS_OK = BT_FUNC_STATUS_OK
  BT_FIELD_STRING_APPEND_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTFieldStringAppendStatus = enum :bt_field_string_append_status,
    [ :BT_FIELD_STRING_APPEND_STATUS_OK,
       BT_FIELD_STRING_APPEND_STATUS_OK,
      :BT_FIELD_STRING_APPEND_STATUS_MEMORY_ERROR,
       BT_FIELD_STRING_APPEND_STATUS_MEMORY_ERROR ]

  attach_function :bt_field_string_append,
                  [ :bt_field_string_handle, :string ],
                  :bt_field_string_append_status

  attach_function :bt_field_string_append_with_length,
                  [ :bt_field_string_handle, :string, :uint64 ],
                  :bt_field_string_append_status

  attach_function :bt_field_string_clear,
                  [ :bt_field_string_handle ],
                  :void

  class BTField::String < BTField
    SetValueStatus = BTFieldStringSetValueStatus
    AppendStatus = BTFieldStringAppendStatus
    def set_value(value)
      res = Babeltrace2.bt_field_string_set_value(@handle, value)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_STRING_APPEND_STATUS_OK
      self
    end

    def value=(value)
      set_value(value)
      value
    end

    def get_length
      Babeltrace2.bt_field_string_get_length(@handle)
    end
    alias length get_length

    def get_value
      Babeltrace2.bt_field_string_get_value(@handle)
    end
    alias value get_value

    def get_raw_value
      Babeltrace2.bt_field_string_get_value_ptr(@handle).slice(0, get_length)
    end
    alias raw_value get_raw_value

    def append(value, length: nil)
      res = if length
          Babeltrace2.bt_field_string_append_with_length(@handle, value, length)
        else
          Babeltrace2.bt_field_string_append(@handle, value)
        end
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_STRING_APPEND_STATUS_OK
      self
    end
    alias << append

    def clear
      Babeltrace2.bt_field_string_clear(@handle)
      self
    end
  end
  BTFieldString = BTField::String
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_STRING] = [
    BTFieldStringHandle,
    BTFieldString ]

  attach_function :bt_field_array_get_length,
                  [ :bt_field_array_handle ],
                  :uint64

  attach_function :bt_field_array_borrow_element_field_by_index,
                  [ :bt_field_array_handle, :uint64 ],
                  :bt_field_handle

  attach_function :bt_field_array_borrow_element_field_by_index_const,
                  [ :bt_field_array_handle, :uint64 ],
                  :bt_field_handle

  class BTField::Array < BTField
    def get_length
       Babeltrace2.bt_field_array_get_length(@handle)
    end
    alias length get_length

    def get_element_field_by_index(index)
      return nil if index >= get_length
      BTField.from_handle(
        Babeltrace2.bt_field_array_borrow_element_field_by_index(@handle, index))
    end
    alias [] get_element_field_by_index

    def each
      if block_given?
        get_length.times { |index|
          yield get_element_field_by_index(index)
        }
      else
        to_enum(:each)
      end
    end
  end
  BTFieldArray = BTField::Array

  class BTField::Array::Static < BTField::Array
  end
  BTFieldArrayStatic = BTField::Array::Static
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_STATIC_ARRAY] = [
    BTFieldArrayStaticHandle,
    BTFieldArrayStatic ]

  BT_FIELD_DYNAMIC_ARRAY_SET_LENGTH_STATUS_OK = BT_FUNC_STATUS_OK
  BT_FIELD_DYNAMIC_ARRAY_SET_LENGTH_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTFieldArrayDynamicSetLengthStatus =
    enum :bt_field_array_dynamic_set_length_status,
    [ :BT_FIELD_DYNAMIC_ARRAY_SET_LENGTH_STATUS_OK,
       BT_FIELD_DYNAMIC_ARRAY_SET_LENGTH_STATUS_OK,
      :BT_FIELD_DYNAMIC_ARRAY_SET_LENGTH_STATUS_MEMORY_ERROR,
       BT_FIELD_DYNAMIC_ARRAY_SET_LENGTH_STATUS_MEMORY_ERROR ]

  attach_function :bt_field_array_dynamic_set_length,
                  [ :bt_field_array_dynamic_handle, :uint64 ],
                  :bt_field_array_dynamic_set_length_status
 
  class BTField::Array::Dynamic < BTField::Array
    SetLengthStatus = BTFieldArrayDynamicSetLengthStatus
    def set_length(length)
      res = Babeltrace2.bt_field_array_dynamic_set_length(@handle, length)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_DYNAMIC_ARRAY_SET_LENGTH_STATUS_OK
      self
    end

    def length=(length)
      set_length(length)
      length
    end
  end
  BTFieldArrayDynamic = BTField::Array::Dynamic
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITHOUT_LENGTH_FIELD] = [
    BTFieldArrayDynamicHandle,
    BTFieldArrayDynamic ]
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITH_LENGTH_FIELD] = [
    BTFieldArrayDynamicHandle,
    BTFieldArrayDynamic ]

  attach_function :bt_field_structure_borrow_member_field_by_index,
                  [ :bt_field_structure_handle, :uint64 ],
                  :bt_field_handle

  attach_function :bt_field_structure_borrow_member_field_by_index_const,
                  [ :bt_field_structure_handle, :uint64 ],
                  :bt_field_handle

  attach_function :bt_field_structure_borrow_member_field_by_name,
                  [ :bt_field_structure_handle, :string ],
                  :bt_field_handle

  attach_function :bt_field_structure_borrow_member_field_by_name_const,
                  [ :bt_field_structure_handle, :string ],
                  :bt_field_handle

  class BTField::Structure < BTField
    def get_member_count
      get_class.get_member_count
    end
    alias member_count get_member_count
    
    def get_member_field_by_index(index)
      return nil if index >= get_member_count
      BTField.from_handle(
        Babeltrace2.bt_field_structure_borrow_member_field_by_index(@handle, index))
    end

    def get_member_field_by_name(name)
      handle = Babeltrace2.bt_field_structure_borrow_member_field_by_name(@handle, name)
      return nil if handle.null?
      BTField.from_handle(name)
    end

    def get_member_field(member_field)
      case member_field
      when String
        get_member_field_by_name(member_field)
      when Integer
        get_member_field_by_index(member_field)
      else
        raise TypeError, "wrong type for member field query"
      end
    end
    alias [] get_member_field
  end
  BTFieldStructure = BTField::Structure
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_STRUCTURE] = [
    BTFieldStructureHandle,
    BTFieldStructure ]

  attach_function :bt_field_option_set_has_field,
                  [ :bt_field_option_handle, :bt_bool ],
                  :void

  attach_function :bt_field_option_borrow_field,
                  [ :bt_field_option_handle ],
                  :bt_field_handle

  attach_function :bt_field_option_borrow_field_const,
                  [ :bt_field_option_handle ],
                  :bt_field_handle

  class BTField::Option < BTField
    def set_has_field(has_field)
      Babeltrace2.bt_field_option_set_has_field(@handle, has_field)
      self
    end

    def has_field=(has_field)
      set_has_field(has_field)
      has_field
    end

    def get_field
      handle = Babeltrace2.bt_field_option_borrow_field(@handle)
      return nil if handle.null?
      BTField.from_handle(handle)
    end
    alias field get_field
  end
  BTFieldOption = BTField::Option

  class BTField::Option::WithoutSelectorField < BTField::Option
  end
  BTFieldOptionWithoutSelectorField = BTField::Option::WithoutSelectorField
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_OPTION_WITHOUT_SELECTOR_FIELD] = [
    BTFieldOptionWithoutSelectorFieldHandle,
    BTFieldOptionWithoutSelectorField ]

  class BTField::Option::WithSelectorField < BTField::Option
  end
  BTFieldOptionWithSelectorField = BTField::Option::WithSelectorField

  class BTField::Option::WithSelectorField::Bool < BTField::Option::WithSelectorField
  end
  BTFieldOptionWithSelectorFieldBool = BTField::Option::WithSelectorField::Bool
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_OPTION_WITH_BOOL_SELECTOR_FIELD] = [
    BTFieldOptionWithSelectorFieldBoolHandle,
    BTFieldOptionWithSelectorFieldBool ]

  class BTField::Option::WithSelectorField::IntegerUnsigned < BTField::Option::WithSelectorField
  end
  BTFieldOptionWithSelectorFieldIntegerUnsigned = BTField::Option::WithSelectorField::IntegerUnsigned
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_OPTION_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD] = [
    BTFieldOptionWithSelectorFieldIntegerUnsignedHandle,
    BTFieldOptionWithSelectorFieldIntegerUnsigned ]

  class BTField::Option::WithSelectorField::IntegerSigned < BTField::Option::WithSelectorField
  end
  BTFieldOptionWithSelectorFieldIntegerSigned = BTField::Option::WithSelectorField::IntegerSigned
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_OPTION_WITH_SIGNED_INTEGER_SELECTOR_FIELD] = [
    BTFieldOptionWithSelectorFieldIntegerSignedHandle,
    BTFieldOptionWithSelectorFieldIntegerSigned ]

  BT_FIELD_VARIANT_SELECT_OPTION_STATUS_OK = BT_FUNC_STATUS_OK
  BTFieldVariantSelectOptionByIndexStatus =
    enum :bt_field_variant_select_option_by_index_status,
    [ :BT_FIELD_VARIANT_SELECT_OPTION_STATUS_OK,
       BT_FIELD_VARIANT_SELECT_OPTION_STATUS_OK ]

  attach_function :bt_field_variant_select_option_by_index,
                  [ :bt_field_variant_handle, :uint64 ],
                  :bt_field_variant_select_option_by_index_status

  attach_function :bt_field_variant_borrow_selected_option_field,
                  [ :bt_field_variant_handle ],
                  :bt_field_handle

  attach_function :bt_field_variant_borrow_selected_option_field_const,
                  [ :bt_field_variant_handle ],
                  :bt_field_handle

  attach_function :bt_field_variant_get_selected_option_index,
                  [ :bt_field_variant_handle ],
                  :uint64

  attach_function :bt_field_variant_borrow_selected_option_class_const,
                  [ :bt_field_variant_handle ],
                  :bt_field_class_variant_option_handle

  class BTField::Variant < BTField
    def get_option_count
      get_class.get_option_count
    end
    alias option_count get_option_count

    def select_option_by_index(index)
      raise "invalid index" if index >= get_option_count
      res = Babeltrace2.bt_field_variant_select_option_by_index(@handle, index)
      raise Babeltrace2.process_error(res) if res != :BT_FIELD_VARIANT_SELECT_OPTION_STATUS_OK
      self
    end

    def get_selected_option_field
      handle = Babeltrace2.bt_field_variant_borrow_selected_option_field(@handle)
      return nil if handle.null?
      BTField.from_handle(handle)
    end
    alias selected_option_field get_selected_option_field

    def get_selected_option_index
      Babeltrace2.bt_field_variant_get_selected_option_index(@handle)
    end
    alias selected_option_index get_selected_option_index

    def get_selected_option_class
      handle = Babeltrace2.bt_field_variant_borrow_selected_option_class_const(@handle)
      return nil if handle.null?
      BTFieldClassVariantOption.new(handle)
    end
  end
  BTFieldVariant = BTField::Variant

  class BTField::Variant::WithoutSelectorField < BTField::Variant
  end
  BTFieldVariantWithoutSelectorField = BTField::Variant::WithoutSelectorField
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_VARIANT_WITHOUT_SELECTOR_FIELD] = [
    BTFieldVariantWithoutSelectorFieldHandle,
    BTFieldVariantWithoutSelectorField ]

  class BTField::Variant::WithSelectorField < BTField::Variant
  end
  BTFieldVariantWithSelectorField = BTField::Variant::WithSelectorField

  attach_function :bt_field_variant_with_selector_field_integer_unsigned_borrow_selected_option_class_const,
                  [ :bt_field_variant_with_selector_field_integer_unsigned_handle ],
                  :bt_field_class_variant_with_selector_field_integer_unsigned_option_handle

  class BTField::Variant::WithSelectorField::IntegerUnsigned <
        BTField::Variant::WithSelectorField
    def get_selected_option_class
      handle = Babeltrace2.bt_field_variant_with_selector_field_integer_unsigned_borrow_selected_option_class_const(@handle)
      return nil if handle.null?
      BTFieldClassVariantWithSelectorFieldIntegerUnsignedOption.new(handle)
    end
  end
  BTFieldVariantWithSelectorFieldIntegerUnsigned = BTField::Variant::WithSelectorField::IntegerUnsigned
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_VARIANT_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD] = [
    BTFieldVariantWithSelectorFieldIntegerUnsignedHandle,
    BTFieldVariantWithSelectorFieldIntegerUnsigned ]

  attach_function :bt_field_variant_with_selector_field_integer_signed_borrow_selected_option_class_const,
                  [ :bt_field_variant_with_selector_field_integer_signed_handle ],
                  :bt_field_class_variant_with_selector_field_integer_signed_option_handle

  class BTField::Variant::WithSelectorField::IntegerSigned <
        BTField::Variant::WithSelectorField
    def get_selected_option_class
      handle = Babeltrace2.bt_field_variant_with_selector_field_integer_signed_borrow_selected_option_class_const(@handle)
      return nil if handle.null?
      BTFieldClassVariantWithSelectorFieldIntegerSignedOption.new(handle)
    end
  end
  BTFieldVariantWithSelectorFieldIntegerSigned = BTField::Variant::WithSelectorField::IntegerSigned
  BTField::TYPE_MAP[:BT_FIELD_CLASS_TYPE_VARIANT_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD] = [
    BTFieldVariantWithSelectorFieldIntegerSignedHandle,
    BTFieldVariantWithSelectorFieldIntegerSigned ]
end
