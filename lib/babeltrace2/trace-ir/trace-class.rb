module Babeltrace2

  attach_function :bt_trace_class_create,
                  [ :bt_self_component_handle ],
                  :bt_trace_class_handle

  attach_function :bt_trace_class_get_stream_class_count,
                  [ :bt_trace_class_handle ],
                  :uint64

  attach_function :bt_trace_class_borrow_stream_class_by_index,
                  [ :bt_trace_class_handle, :uint64 ],
                  :bt_stream_class_handle

  attach_function :bt_trace_class_borrow_stream_class_by_index_const,
                  [ :bt_trace_class_handle, :uint64 ],
                  :bt_stream_class_handle

  attach_function :bt_trace_class_borrow_stream_class_by_id,
                  [ :bt_trace_class_handle, :uint64 ],
                  :bt_stream_class_handle

  attach_function :bt_trace_class_borrow_stream_class_by_id_const,
                  [ :bt_trace_class_handle, :uint64 ],
                  :bt_stream_class_handle

  attach_function :bt_trace_class_set_assigns_automatic_stream_class_id,
                  [ :bt_trace_class_handle, :bt_bool ],
                  :void

  attach_function :bt_trace_class_assigns_automatic_stream_class_id,
                  [ :bt_trace_class_handle ],
                  :bt_bool

  attach_function :bt_trace_class_set_user_attributes,
                  [ :bt_trace_class_handle, :bt_value_map_handle ],
                  :void

  attach_function :bt_trace_class_borrow_user_attributes,
                  [ :bt_trace_class_handle ],
                  :bt_value_map_handle

  attach_function :bt_trace_class_borrow_user_attributes_const,
                  [ :bt_trace_class_handle ],
                  :bt_value_map_handle

  callback :bt_trace_class_destruction_listener_func,
           [ :bt_trace_class_handle, :pointer],
           :void

  def self._wrap_trace_class_destruction_listener_func(method)
    method_wrapper = lambda { |trace_class, user_data|
      begin
        method.call(BTTraceClass.new(trace_class,
                      retain: false, auto_release: false), user_data)
      rescue Exception => e
        puts e
      end
    }
    method_wrapper
  end

  BT_TRACE_CLASS_ADD_LISTENER_STATUS_OK = BT_FUNC_STATUS_OK
  BT_TRACE_CLASS_ADD_LISTENER_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTTraceClassAddListenerStatus = enum :bt_trace_class_add_listener_status,
    [ :BT_TRACE_CLASS_ADD_LISTENER_STATUS_OK,
       BT_TRACE_CLASS_ADD_LISTENER_STATUS_OK,
      :BT_TRACE_CLASS_ADD_LISTENER_STATUS_MEMORY_ERROR,
       BT_TRACE_CLASS_ADD_LISTENER_STATUS_MEMORY_ERROR ]

  attach_function :bt_trace_class_add_destruction_listener,
                  [ :bt_trace_class_handle, :bt_trace_class_destruction_listener_func,
                    :pointer, :pointer ],
                  :bt_trace_class_add_listener_status

  BT_TRACE_CLASS_REMOVE_LISTENER_STATUS_OK = BT_FUNC_STATUS_OK
  BT_TRACE_CLASS_REMOVE_LISTENER_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTTraceClassRemoveListenerStatus = enum :bt_trace_class_remove_listener_status,
    [ :BT_TRACE_CLASS_REMOVE_LISTENER_STATUS_OK,
       BT_TRACE_CLASS_REMOVE_LISTENER_STATUS_OK,
      :BT_TRACE_CLASS_REMOVE_LISTENER_STATUS_MEMORY_ERROR,
       BT_TRACE_CLASS_REMOVE_LISTENER_STATUS_MEMORY_ERROR ]

  attach_function :bt_trace_class_remove_destruction_listener,
                  [ :bt_trace_class_handle, :bt_listener_id ],
                  :bt_trace_class_remove_listener_status

  attach_function :bt_trace_class_get_ref,
                  [ :bt_trace_class_handle ],
                  :void

  attach_function :bt_trace_class_put_ref,
                  [ :bt_trace_class_handle ],
                  :void

  class BTTraceClass < BTSharedObject
    AddListenerStatus = BTTraceClassAddListenerStatus
    RemoveListenerStatus = BTTraceClassRemoveListenerStatus
    @get_ref = :bt_trace_class_get_ref
    @put_ref = :bt_trace_class_put_ref

    def initialize(handle = nil, retain: true, auto_release: true,
                   self_component: nil)
      if(handle)
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_trace_class_create(self_component)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def get_stream_class_count
      Babeltrace2.bt_trace_class_get_stream_class_count(@handle)
    end
    alias stream_class_count get_stream_class_count

    def get_stream_class_by_index(index)
      count = get_stream_class_count
      index += count if index < 0
      return nil if index >= count || index < 0
      BTStreamClass.new(
        Babeltrace2.bt_trace_class_borrow_stream_class_by_index(@handle, index))
    end

    def get_stream_class_by_id(id)
      handle = Babeltrace2.bt_trace_class_borrow_stream_class_by_id(@handle, id)
      return nil if handle.null?
      BTStreamClass.new(handle, retain: true)
    end

    def set_assigns_automatic_stream_class_id(assigns_automatic_stream_class_id)
      Babeltrace2.bt_trace_class_set_assigns_automatic_stream_class_id(
        @handle, assigns_automatic_stream_class_id ? BT_TRUE : BT_FALSE)
      self
    end

    def assigns_automatic_stream_class_id=(assigns_automatic_stream_class_id)
      set_assigns_automatic_stream_class_id(assigns_automatic_stream_class_id)
      assigns_automatic_stream_class_id
    end

    def assigns_automatic_stream_class_id
      Babeltrace2.bt_trace_class_assigns_automatic_stream_class_id(@handle) != BT_FALSE
    end
    alias assigns_automatic_stream_class_id? assigns_automatic_stream_class_id

    def set_user_attributes(user_attributes)
      Babeltrace2.bt_trace_class_set_user_attributes(@handle, BTValue.from_value(user_attributes))
      self
    end

    def user_attributes=(user_attributes)
      set_user_attributes(user_attributes)
      user_attributes
    end

    def get_user_attributes
      BTValueMap.new(Babeltrace2.bt_trace_class_borrow_user_attributes(@handle), retain: true)
    end
    alias user_attributes get_user_attributes

    def add_destruction_listener(user_func, user_data: nil)
      user_func = Babeltrace2._wrap_trace_class_destruction_listener_func(user_func)
      id = @handle.to_i
      ptr = FFI::MemoryPointer.new(:uint64)
      res = Babeltrace2.bt_trace_class_add_destruction_listener(@handle, user_func, user_data, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_TRACE_CLASS_ADD_LISTENER_STATUS_OK
      listener_id = ptr.read_uint64
      h = Babeltrace2._callbacks[id][:destruction_listener_funcs]
      if h.nil?
        h = {}
        Babeltrace2._callbacks[id][:destruction_listener_funcs] = h
      end
      h[listener_id] = [user_func, user_data]
      listener_id
    end

    def remove_destruction_listener(listener_id)
      res = Babeltrace2.bt_trace_class_remove_destruction_listener(@handle, listener_id)
      raise Babeltrace2.process_error(res) if res != :BT_TRACE_CLASS_REMOVE_LISTENER_STATUS_OK
      Babeltrace2._callbacks[@handle.to_i][:destruction_listener_funcs].delete(listener_id)
      self
    end

    def create_stream_class(id: nil)
      BTStreamClass.new(trace_class: @handle, id: id)
    end

    def create_trace
      BTTrace.new(trace_class: @handle)
    end

    def create_field_class_bool
      BTFieldClassBool.new(trace_class: @handle)
    end
    alias create_bool_class create_field_class_bool
    alias create_bool create_field_class_bool

    def create_field_class_bit_array(length)
      BTFieldClassBitArray.new(trace_class: @handle, length: length)
    end
    alias create_bit_array_class create_field_class_bit_array
    alias create_bit_array create_field_class_bit_array

    def create_field_class_integer_unsigned
      BTFieldClassIntegerUnsigned.new(trace_class: @handle)
    end
    alias create_unsigned_integer_class create_field_class_integer_unsigned
    alias create_unsigned create_field_class_integer_unsigned

    def create_field_class_integer_signed
      BTFieldClassIntegerSigned.new(trace_class: @handle)
    end
    alias create_signed_integer_class create_field_class_integer_signed
    alias create_signed create_field_class_integer_signed

    def create_field_class_real_single_precision
      BTFieldClassRealSinglePrecision.new(trace_class: @handle)
    end
    alias create_single_precision_real_class create_field_class_real_single_precision
    alias create_single create_field_class_real_single_precision

    def create_field_class_real_double_precision
      BTFieldClassRealDoublePrecision.new(trace_class: @handle)
    end
    alias create_double_precision_real_class create_field_class_real_double_precision
    alias create_double create_field_class_real_double_precision

    def create_field_class_enumeration_unsigned
      BTFieldClassEnumerationUnsigned.new(trace_class: @handle)
    end
    alias create_unsigned_enumeration_class create_field_class_enumeration_unsigned
    alias create_unsigned_enum create_field_class_enumeration_unsigned

    def create_field_class_enumeration_signed
      BTFieldClassEnumerationSigned.new(trace_class: @handle)
    end
    alias create_signed_enumeration_class create_field_class_enumeration_signed
    alias create_signed_enum create_field_class_enumeration_signed

    def create_field_class_string
      BTFieldClassString.new(trace_class: @handle)
    end
    alias create_string_class create_field_class_string
    alias create_string create_field_class_string

    def create_field_class_array_static(element_field_class, length)
      BTFieldClassArrayStatic.new(trace_class: @handle,
                                  element_field_class: element_field_class,
                                  length: length)
    end
    alias create_static_array_class create_field_class_array_static
    alias create_static_array create_field_class_array_static

    def create_field_class_array_dynamic(element_field_class, length_field_class: nil)
      BTFieldClassArrayDynamic.new(trace_class: @handle,
                                   element_field_class: element_field_class,
                                   length_field_class: length_field_class)
    end
    alias create_dynamic_array_class create_field_class_array_dynamic
    alias create_dynamic_array create_field_class_array_dynamic

    def create_field_class_array(element_field_class, length: nil)
      case length
      when Integer
        create_field_class_array_static(element_field_class, length)
      when nil, BTFieldClassIntegerUnsigned
        create_field_class_array_dynamic(element_field_class, length_field_class: length)
      else
        raise "invalid length type"
      end
    end
    alias create_array_class create_field_class_array
    alias create_array create_field_class_array

    def create_field_class_structure
      BTFieldClassStructure.new(trace_class: @handle)
    end
    alias create_structure_class create_field_class_structure
    alias create_structure create_field_class_structure

    def create_field_class_option_without_selector(optional_field_class)
      BTFieldClassOptionWithoutSelectorField.new(
        trace_class: @handle,
        optional_field_class: optional_field_class)
    end
    alias create_option_without_selector_class create_field_class_option_without_selector
    alias create_option_without create_field_class_option_without_selector

    def create_field_class_option_with_selector_field_bool(optional_field_class, selector_field_class)
      BTFieldClassOptionWithSelectorFieldBool.new(
        trace_class: @handle,
        optional_field_class: optional_field_class,
        selector_field_class: selector_field_class)
    end
    alias create_option_with_bool_selector_field_class create_field_class_option_with_selector_field_bool
    alias create_option_with_bool_selector_field create_field_class_option_with_selector_field_bool

    def create_field_class_option_with_selector_field_integer_unsigned(optional_field_class, selector_field_class, ranges)
      BTFieldClassOptionWithSelectorFieldIntegerUnsigned.new(
        trace_class: @handle,
        optional_field_class: optional_field_class,
        selector_field_class: selector_field_class,
        ranges: ranges)
    end
    alias create_option_with_unsigned_integer_selector_field_class create_field_class_option_with_selector_field_integer_unsigned
    alias create_option_with_unsigned_integer_selector_field create_field_class_option_with_selector_field_integer_unsigned

    def create_field_class_option_with_selector_field_integer_signed(optional_field_class, selector_field_class, ranges)
      BTFieldClassOptionWithSelectorFieldIntegerSigned.new(
        trace_class: @handle,
        optional_field_class: optional_field_class,
        selector_field_class: selector_field_class,
        ranges: ranges)
    end
    alias create_option_with_signed_integer_selector_field_class create_field_class_option_with_selector_field_integer_signed
    alias create_option_with_signed_integer_selector_field create_field_class_option_with_selector_field_integer_signed

    def create_field_class_option(optional_field_class, selector_field_class: nil, ranges: nil)
      case selector_field_class
      when nil
        create_field_class_option_without_selector(optional_field_class)
      when BTFieldClassBool
        create_field_class_option_with_selector_field_bool(optional_field_class, selector_field_class)
      when BTFieldClassIntegerUnsigned
        create_field_class_option_with_selector_field_integer_unsigned(optional_field_class, selector_field_class, ranges)
      when BTFieldClassIntegerSigned
        create_field_class_option_with_selector_field_integer_signed(optional_field_class, selector_field_class, ranges)
      else
        raise "invalid selector field class"
      end
    end
    alias create_option_class create_field_class_option
    alias create_option create_field_class_option

    def create_field_class_variant(selector_field_class: nil)
      BTFieldClassVariant.new(trace_class: @handle, selector_field_class: selector_field_class)
    end
    alias create_variant_class create_field_class_variant
    alias create_variant create_field_class_variant
  end
end
