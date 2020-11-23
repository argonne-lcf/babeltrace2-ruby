module Babeltrace2

  attach_function :bt_component_descriptor_set_create,
                  [],
                  :bt_component_descriptor_set_handle

  BT_COMPONENT_DESCRIPTOR_SET_ADD_DESCRIPTOR_STATUS_OK = BT_FUNC_STATUS_OK
  BT_COMPONENT_DESCRIPTOR_SET_ADD_DESCRIPTOR_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTComponentDescriptorSetAddDescriptorStatus =
    enum :bt_component_descriptor_set_add_descriptor_status,
    [ :BT_COMPONENT_DESCRIPTOR_SET_ADD_DESCRIPTOR_STATUS_OK,
       BT_COMPONENT_DESCRIPTOR_SET_ADD_DESCRIPTOR_STATUS_OK,
      :BT_COMPONENT_DESCRIPTOR_SET_ADD_DESCRIPTOR_STATUS_MEMORY_ERROR,
       BT_COMPONENT_DESCRIPTOR_SET_ADD_DESCRIPTOR_STATUS_MEMORY_ERROR ]

  attach_function :bt_component_descriptor_set_add_descriptor,
                  [ :bt_component_descriptor_set_handle,
                    :bt_component_class_handle,
                    :bt_value_handle ],
                  :bt_component_descriptor_set_add_descriptor_status

  attach_function :bt_component_descriptor_set_add_descriptor_with_initialize_method_data,
                  [ :bt_component_descriptor_set_handle,
                    :bt_component_class_handle,
                    :bt_value_handle,
                    :pointer ],
                  :bt_component_descriptor_set_add_descriptor_status

  attach_function :bt_component_descriptor_set_get_ref,
                  [ :bt_component_descriptor_set_handle ],
                  :void

  attach_function :bt_component_descriptor_set_put_ref,
                  [ :bt_component_descriptor_set_handle ],
                  :void

  class BTComponent
    DescriptorSetAddDescriptorStatus = BTComponentDescriptorSetAddDescriptorStatus
    class DescriptorSet < BTSharedObject
      AddDescriptorStatus = BTComponentDescriptorSetAddDescriptorStatus
      @get_ref = :bt_component_descriptor_set_get_ref
      @put_ref = :bt_component_descriptor_set_put_ref

      def initialize(handle = nil, retain: true, auto_release: true)
        if handle
          super(handle, retain: retain, auto_release: auto_release)
        else
          handle = Babeltrace2.bt_component_descriptor_set_create()
          raise Babeltrace2.process_error if handle.null?
          super(handle)
        end
      end

      def add_descriptor(component_class, params: {}, initialize_method_data: nil)
        params = BTValue.from_value(params)
        raise "invalid value" unless params.kind_of?(BTValueMap)
        res = if initialize_method_data
            Babeltrace2.bt_component_descriptor_set_add_descriptor_with_initialize_method_data(@handle, component_class, params, initialize_method_data)
          else
            Babeltrace2.bt_component_descriptor_set_add_descriptor(@handle, component_class, params)
          end
        raise Babeltrace2.process_error(res) if res != :BT_COMPONENT_DESCRIPTOR_SET_ADD_DESCRIPTOR_STATUS_OK
        self
      end

      def get_greatest_operative_mip_version(logging_level = BTLogging.global_level)
        ptr = FFI::MemoryPointer.new(:uint64)
        res = Babeltrace2.bt_get_greatest_operative_mip_version(
                @handle, logging_level, ptr)
        raise Babeltrace2.process_error(res) if res != :BT_GET_GREATEST_OPERATIVE_MIP_VERSION_STATUS_OK
        ptr.read_uint64
      end
      alias greatest_operative_mip_version get_greatest_operative_mip_version
    end
  end
  BTComponentDescriptorSet = BTComponent::DescriptorSet

end
