module Babeltrace2

  class BTHandle < FFI::Pointer
    extend FFI::DataConverter
    class << self
      def native_type
        FFI::Type::POINTER
      end

      def from_native(value, context)
        new(value) #value.null? ? nil : new(value)
      end

      def to_native(value, context)
        unless value.nil?
          p = value.to_ptr
          raise "invalid type #{p.class}, expected #{self}" unless p.kind_of?(self)
          p
        else
          nil
        end
      end
    end
  end

  class BTClockClassHandle < BTHandle; end
  typedef BTClockClassHandle, :bt_clock_class_handle

  class BTClockSnapshotHandle < BTHandle; end
  typedef BTClockSnapshotHandle, :bt_clock_snapshot_handle

  class BTComponentClassHandle < BTHandle; end
  typedef BTComponentClassHandle, :bt_component_class_handle

  class BTComponentClassFilterHandle < BTComponentClassHandle; end
  typedef BTComponentClassFilterHandle, :bt_component_class_filter_handle

  class BTComponentClassSinkHandle < BTComponentClassHandle; end
  typedef BTComponentClassSinkHandle, :bt_component_class_sink_handle

  class BTComponentClassSourceHandle < BTComponentClassHandle; end
  typedef BTComponentClassSourceHandle, :bt_component_class_source_handle

  class BTComponentDescriptorSetHandle < BTHandle; end
  typedef BTComponentDescriptorSetHandle, :bt_component_descriptor_set_handle

  class BTComponentHandle < BTHandle; end
  typedef BTComponentHandle, :bt_component_handle

  class BTComponentFilterHandle < BTComponentHandle; end
  typedef BTComponentFilterHandle, :bt_component_filter_handle

  class BTComponentSinkHandle < BTComponentHandle; end
  typedef BTComponentSinkHandle, :bt_component_sink_handle

  class BTComponentSourceHandle < BTComponentHandle; end
  typedef BTComponentSourceHandle, :bt_component_source_handle

  class BTConnectionHandle < BTHandle; end
  typedef BTConnectionHandle, :bt_connection_handle

  class BTErrorHandle < BTHandle; end
  typedef BTErrorHandle, :bt_error_handle

  class BTErrorCauseHandle < BTHandle; end
  typedef BTErrorCauseHandle, :bt_error_cause_handle

  class BTEventHandle < BTHandle; end
  typedef BTEventHandle, :bt_event_handle

  class BTEventClassHandle < BTHandle; end
  typedef BTEventClassHandle, :bt_event_class_handle

  class BTEventHeaderFieldHandle < BTHandle; end
  typedef BTEventHeaderFieldHandle, :bt_event_header_field_handle

  class BTFieldHandle < BTHandle; end
  typedef BTFieldHandle, :bt_field_handle

  class BTFieldClassHandle < BTHandle; end
  typedef BTFieldClassHandle, :bt_field_class_handle

  class BTFieldClassEnumerationMappingHandle < BTHandle; end
  typedef BTFieldClassEnumerationMappingHandle,
          :bt_field_class_enumeration_mapping_handle

  class BTFieldClassEnumerationSignedMappingHandle <
        BTFieldClassEnumerationMappingHandle; end
  typedef BTFieldClassEnumerationSignedMappingHandle,
          :bt_field_class_enumeration_signed_mapping_handle

  class BTFieldClassEnumerationUnsignedMappingHandle <
        BTFieldClassEnumerationMappingHandle; end
  typedef BTFieldClassEnumerationUnsignedMappingHandle,
          :bt_field_class_enumeration_unsigned_mapping_handle

  class BTFieldClassStructureMemberHandle < BTHandle; end
  typedef BTFieldClassStructureMemberHandle, :bt_field_class_structure_member_handle

  class BTFieldClassVariantOptionHandle < BTHandle; end
  typedef BTFieldClassVariantOptionHandle, :bt_field_class_variant_option_handle

  class BTFieldClassVariantWithSelectorFieldIntegerSignedOptionHandle <
        BTFieldClassVariantOptionHandle; end
  typedef BTFieldClassVariantWithSelectorFieldIntegerSignedOptionHandle,
          :bt_field_class_variant_with_selector_field_integer_signed_option_handle

  class BTFieldClassVariantWithSelectorFieldIntegerUnsignedOptionHandle <
        BTFieldClassVariantOptionHandle; end
  typedef BTFieldClassVariantWithSelectorFieldIntegerUnsignedOptionHandle,
          :bt_field_class_variant_with_selector_field_integer_unsigned_option_handle

  class BTFieldPathHandle < BTHandle; end
  typedef BTFieldPathHandle, :bt_field_path_handle

  class BTFieldPathItemHandle < BTHandle; end
  typedef BTFieldPathItemHandle, :bt_field_path_item_handle

  class BTGraphHandle < BTHandle; end
  typedef BTGraphHandle, :bt_graph_handle

  class BTIntegerRangeSetHandle < BTHandle; end
  typedef BTIntegerRangeSetHandle, :bt_integer_range_set_handle

  class BTIntegerRangeSetSignedHandle < BTIntegerRangeSetHandle; end
  typedef BTIntegerRangeSetSignedHandle, :bt_integer_range_set_signed_handle

  class BTIntegerRangeSetUnsignedHandle < BTIntegerRangeSetHandle; end
  typedef BTIntegerRangeSetUnsignedHandle, :bt_integer_range_set_unsigned_handle

  class BTIntegerRangeSignedHandle < BTHandle; end
  typedef BTIntegerRangeSignedHandle, :bt_integer_range_signed_handle

  class BTIntegerRangeUnsignedHandle < BTHandle; end
  typedef BTIntegerRangeUnsignedHandle, :bt_integer_range_unsigned_handle

  class BTInterrupterHandle < BTHandle; end
  typedef BTInterrupterHandle, :bt_interrupter_handle

  class BTMessageHandle < BTHandle; end
  typedef BTMessageHandle, :bt_message_handle

  class BTMessageIteratorHandle < BTHandle; end
  typedef BTMessageIteratorHandle, :bt_message_iterator_handle

  class BTMessageIteratorClassHandle < BTHandle; end
  typedef BTMessageIteratorClassHandle, :bt_message_iterator_class_handle

  class BTObjectHandle < BTHandle; end
  typedef BTObjectHandle, :bt_object_handle

  class BTPacketHandle < BTHandle; end
  typedef BTPacketHandle, :bt_packet_handle

  class BTPortHandle < BTHandle; end
  typedef BTPortHandle, :bt_port_handle

  class BTPortInputHandle < BTPortHandle; end
  typedef BTPortInputHandle, :bt_port_input_handle

  class BTPortOutputHandle < BTPortHandle; end
  typedef BTPortOutputHandle, :bt_port_output_handle

  class BTPortOutputMessageIteratorHandle < BTMessageIteratorHandle; end
  typedef BTPortOutputMessageIteratorHandle, :bt_port_output_message_iterator_handle

  class BTQueryExecutorHandle < BTHandle; end
  typedef BTQueryExecutorHandle, :bt_query_executor_handle

  class BTPrivateQueryExecutorHandle < BTQueryExecutorHandle; end
  typedef BTPrivateQueryExecutorHandle, :bt_private_query_executor_handle

  module BTSelfComponentHandle; end
  class BTSelfComponentHandleCls < BTComponentHandle
    include BTSelfComponentHandle
    class << self
      def to_native(value, context)
        unless value.nil?
          p = value.to_ptr
          raise "invalid type #{p.class}, expected #{BTSelfComponentHandle}" unless p.kind_of?(BTSelfComponentHandle)
          p
        else
          nil
        end
      end
    end
  end
  typedef BTSelfComponentHandleCls, :bt_self_component_handle

  class BTSelfComponentFilterHandle < BTComponentFilterHandle
    include BTSelfComponentHandle
  end
  typedef BTSelfComponentFilterHandle, :bt_self_component_filter_handle

  class BTSelfComponentFilterConfigurationHandle < BTHandle; end
  typedef BTSelfComponentFilterConfigurationHandle,
          :bt_self_component_filter_configuration_handle

  class BTSelfComponentSinkHandle < BTComponentSinkHandle
    include BTSelfComponentHandle
  end
  typedef BTSelfComponentSinkHandle, :bt_self_component_sink_handle

  class BTSelfComponentSinkConfigurationHandle < BTHandle; end
  typedef BTSelfComponentSinkConfigurationHandle,
          :bt_self_component_sink_configuration_handle

  class BTSelfComponentSourceHandle < BTComponentSourceHandle
    include BTSelfComponentHandle
  end
  typedef BTSelfComponentSourceHandle, :bt_self_component_source_handle

  class BTSelfComponentSourceConfigurationHandle < BTHandle; end
  typedef BTSelfComponentSourceConfigurationHandle,
          :bt_self_component_source_configuration_handle

  module BTSelfComponentClassHandle; end
  class BTSelfComponentClassHandleCls < BTComponentClassHandle
    include BTSelfComponentClassHandle
    class << self
      def to_native(value, context)
        unless value.nil?
          p = value.to_ptr
          raise "invalid type #{p.class}, expected #{BTSelfComponentClassHandle}" unless p.kind_of?(BTSelfComponentClassHandle)
          p
        else
          nil
        end
      end
    end
  end
  typedef BTSelfComponentClassHandleCls,
          :bt_self_component_class_handle

  class BTSelfComponentClassFilterHandle < BTComponentClassFilterHandle
    include BTSelfComponentClassHandle
  end
  typedef BTSelfComponentClassFilterHandle,
          :bt_self_component_class_filter_handle

  class BTSelfComponentClassSinkHandle < BTComponentClassSinkHandle
    include BTSelfComponentClassHandle
  end
  typedef BTSelfComponentClassSinkHandle,
          :bt_self_component_class_sink_handle

  class BTSelfComponentClassSourceHandle < BTComponentClassSourceHandle
    include BTSelfComponentClassHandle
  end
  typedef BTSelfComponentClassSourceHandle,
          :bt_self_component_class_source_handle

  module BTSelfComponentPortHandle; end
  class BTSelfComponentPortHandleCls < BTPortHandle
    include BTSelfComponentPortHandle
    class << self
      def to_native(value, context)
        unless value.nil?
          p = value.to_ptr
          raise "invalid type #{p.class}, expected #{BTSelfComponentPortHandle}" unless p.kind_of?(BTSelfComponentPortHandle)
          p
        else
          nil
        end
      end
    end
  end
  typedef BTSelfComponentPortHandleCls, :bt_self_component_port_handle

  class BTSelfComponentPortInputHandle < BTPortInputHandle
    include BTSelfComponentPortHandle
  end
  typedef BTSelfComponentPortInputHandle, :bt_self_component_port_input_handle

  class BTSelfComponentPortOutputHandle < BTPortOutputHandle
    include BTSelfComponentPortHandle
  end
  typedef BTSelfComponentPortOutputHandle, :bt_self_component_port_output_handle

  class BTMessageIteratorHandle < BTHandle; end
  typedef BTMessageIteratorHandle, :bt_message_iterator_handle

  class BTSelfMessageIteratorHandle < BTMessageIteratorHandle; end
  typedef BTSelfMessageIteratorHandle, :bt_self_message_iterator_handle

  class BTSelfMessageIteratorConfigurationHandle < BTHandle; end
  typedef BTSelfMessageIteratorConfigurationHandle, :bt_self_message_iterator_configuration_handle

  class BTPluginHandle < BTHandle; end
  typedef BTPluginHandle, :bt_plugin_handle

  class BTPluginSetHandle < BTHandle; end
  typedef BTPluginSetHandle, :bt_plugin_set_handle

  class BTPluginSoSharedLibHandleHandle < BTHandle; end
  typedef BTPluginSoSharedLibHandleHandle, :bt_plugin_so_shared_lib_handle_handle

  class BTSelfPluginHandle < BTPluginHandle; end
  typedef BTSelfPluginHandle, :bt_self_plugin_handle

  class BTStreamHandle < BTHandle; end
  typedef BTStreamHandle, :bt_stream_handle

  class BTStreamClassHandle < BTHandle; end
  typedef BTStreamClassHandle, :bt_stream_class_handle

  class BTTraceHandle < BTHandle; end
  typedef BTTraceHandle, :bt_trace_handle

  class BTTraceClassHandle < BTHandle; end
  typedef BTTraceClassHandle, :bt_trace_class_handle

  class BTValueHandle < BTHandle; end
  typedef BTValueHandle, :bt_value_handle

  # Additional types for type checking
  class BTValueMapHandle < BTValueHandle; end
  typedef BTValueMapHandle, :bt_value_map_handle

  class BTFieldClassBoolHandle < BTFieldClassHandle; end
  typedef BTFieldClassBoolHandle, :bt_field_class_bool_handle

  class BTFieldClassBitArrayHandle < BTFieldClassHandle; end
  typedef BTFieldClassBitArrayHandle, :bt_field_class_bit_array_handle

  class BTFieldClassIntegerHandle < BTFieldClassHandle; end
  typedef BTFieldClassIntegerHandle, :bt_field_class_integer_handle

  class BTFieldClassIntegerUnsignedHandle < BTFieldClassIntegerHandle; end
  typedef BTFieldClassIntegerUnsignedHandle, :bt_field_class_integer_unsigned_handle

  class BTFieldClassIntegerSignedHandle < BTFieldClassIntegerHandle; end
  typedef BTFieldClassIntegerSignedHandle, :bt_field_class_integer_signed_handle

  class BTFieldClassRealSinglePrecisionHandle < BTFieldClassHandle; end
  typedef BTFieldClassRealSinglePrecisionHandle,
         :bt_field_class_real_single_precision_handle

  class BTFieldClassRealDoublePrecisionHandle < BTFieldClassHandle; end
  typedef BTFieldClassRealDoublePrecisionHandle,
          :bt_field_class_real_double_precision_handle

  class BTFieldClassEnumerationHandle < BTFieldClassHandle; end
  typedef BTFieldClassEnumerationHandle, :bt_field_class_enumeration_handle

  class BTFieldClassEnumerationUnsignedHandle < BTFieldClassEnumerationHandle; end
  typedef BTFieldClassEnumerationUnsignedHandle,
          :bt_field_class_enumeration_unsigned_handle

  class BTFieldClassEnumerationSignedHandle < BTFieldClassEnumerationHandle; end
  typedef BTFieldClassEnumerationSignedHandle,
          :bt_field_class_enumeration_signed_handle

  class BTFieldClassStringHandle < BTFieldClassHandle; end
  typedef BTFieldClassStringHandle, :bt_field_class_string_handle

  class BTFieldClassArrayHandle < BTFieldClassHandle; end
  typedef BTFieldClassArrayHandle, :bt_field_class_array_handle

  class BTFieldClassArrayStaticHandle < BTFieldClassArrayHandle; end
  typedef BTFieldClassArrayStaticHandle, :bt_field_class_array_static_handle

  class BTFieldClassArrayDynamicHandle < BTFieldClassArrayHandle; end
  typedef BTFieldClassArrayDynamicHandle, :bt_field_class_array_dynamic_handle

  class BTFieldClassStructureHandle < BTFieldClassHandle; end
  typedef BTFieldClassStructureHandle, :bt_field_class_structure_handle

  class BTFieldClassOptionHandle < BTFieldClassHandle; end
  typedef BTFieldClassOptionHandle, :bt_field_class_option_handle

  class BTFieldClassOptionWithoutSelectorFieldHandle < BTFieldClassOptionHandle; end
  typedef BTFieldClassOptionWithoutSelectorFieldHandle,
          :bt_field_class_option_without_selector_field_handle

  class BTFieldClassOptionWithSelectorFieldHandle < BTFieldClassOptionHandle; end
  typedef BTFieldClassOptionWithSelectorFieldHandle,
          :bt_field_class_option_with_selector_field_handle

  class BTFieldClassOptionWithSelectorFieldBoolHandle <
        BTFieldClassOptionWithSelectorFieldHandle; end
  typedef BTFieldClassOptionWithSelectorFieldBoolHandle,
          :bt_field_class_option_with_selector_field_bool_handle

  class BTFieldClassOptionWithSelectorFieldIntegerUnsignedHandle <
        BTFieldClassOptionWithSelectorFieldHandle; end
  typedef BTFieldClassOptionWithSelectorFieldIntegerUnsignedHandle,
          :bt_field_class_option_with_selector_field_integer_unsigned_handle

  class BTFieldClassOptionWithSelectorFieldIntegerSignedHandle <
        BTFieldClassOptionWithSelectorFieldHandle; end
  typedef BTFieldClassOptionWithSelectorFieldIntegerSignedHandle,
          :bt_field_class_option_with_selector_field_integer_signed_handle

  class BTFieldClassVariantHandle < BTFieldClassHandle; end
  typedef BTFieldClassVariantHandle, :bt_field_class_variant_handle

  typedef :int, :bt_bool
  typedef :uint64, :bt_listener_id
  typedef :pointer, :bt_object

  class Error < StandardError
  end

  class BTObject
    attr_reader :handle

    def initialize(handle)
      raise "Invalid handle" if !handle
      @handle = handle
    end

    def to_ptr
      @handle
    end
  end

  class BTSharedObject < BTObject
    class Releaser
      def initialize(handle, releaser)
        @handle = handle
        @releaser = releaser
      end

      def call(id)
        Babeltrace2.method(@releaser).call(@handle)
      end
    end

    class << self
      attr_reader :put_ref
      attr_reader :get_ref
    end

    def initialize(handle, retain: false, auto_release: true)
      super(handle)
      Babeltrace2.method(self.class.get_ref).call(handle) if retain
      ObjectSpace.define_finalizer(self, Releaser::new(handle, self.class.put_ref)) if auto_release
    end
  end

  class BTUUID < FFI::Struct
    layout :id, [ :uint8_t, 16 ]
    def to_s
      a = self[:id].to_a
      s = "{ id: "
      s << "%02x" % a[15]
      s << "%02x" % a[14]
      s << "%02x" % a[13]
      s << "%02x" % a[12]
      s << "-"
      s << "%02x" % a[11]
      s << "%02x" % a[10]
      s << "-"
      s << "%02x" % a[9]
      s << "%02x" % a[8]
      s << "-"
      s << "%02x" % a[7]
      s << "%02x" % a[6]
      s << "-"
      s << "%02x" % a[5]
      s << "%02x" % a[4]
      s << "%02x" % a[3]
      s << "%02x" % a[2]
      s << "%02x" % a[1]
      s << "%02x" % a[0]
      s << " }"
    end
  end
  typedef BTUUID.by_ref, :bt_uuid

  BTPropertyAvailability = enum :bt_property_availability,
    [ :BT_PROPERTY_AVAILABILITY_NOT_AVAILABLE, 0,
      :BT_PROPERTY_AVAILABILITY_AVAILABLE, 1 ]

  typedef :pointer, :bt_message_array_const

  BT_TRUE = 1
  BT_FALSE = 0
  BT_SLEEP_TIME = 0.1

  @@callbacks = Hash::new { |h, k| h[k] = {} }
  def self._callbacks
    @@callbacks
  end
end
