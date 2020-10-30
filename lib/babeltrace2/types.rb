module Babeltrace2

  typedef :pointer, :bt_clock_class_handle
  typedef :pointer, :bt_clock_snapshot_handle
  typedef :pointer, :bt_component_handle
  typedef :pointer, :bt_component_class_handle
  typedef :pointer, :bt_component_class_filter_handle
  typedef :pointer, :bt_component_class_sink_handle
  typedef :pointer, :bt_component_class_source_handle
  typedef :pointer, :bt_component_descriptor_set_handle
  typedef :pointer, :bt_component_filter_handle
  typedef :pointer, :bt_component_sink_handle
  typedef :pointer, :bt_component_source_handle
  typedef :pointer, :bt_connection_handle
  typedef :pointer, :bt_error_handle
  typedef :pointer, :bt_error_cause_handle
  typedef :pointer, :bt_event_handle
  typedef :pointer, :bt_event_class_handle
  typedef :pointer, :bt_event_header_field_handle
  typedef :pointer, :bt_field_handle
  typedef :pointer, :bt_field_class_handle
  typedef :pointer, :bt_field_class_enumeration_mapping_handle
  typedef :pointer, :bt_field_class_enumeration_signed_mapping_handle
  typedef :pointer, :bt_field_class_enumeration_unsigned_mapping_handle
  typedef :pointer, :bt_field_class_structure_member_handle
  typedef :pointer, :bt_field_class_variant_option_handle
  typedef :pointer, :bt_field_class_variant_with_selector_field_integer_signed_option_handle
  typedef :pointer, :bt_field_class_variant_with_selector_field_integer_unsigned_option_handle
  typedef :pointer, :bt_field_path_handle
  typedef :pointer, :bt_field_path_item_handle
  typedef :pointer, :bt_graph_handle
  typedef :pointer, :bt_integer_range_set_handle
  typedef :pointer, :bt_integer_range_set_signed_handle
  typedef :pointer, :bt_integer_range_set_unsigned_handle
  typedef :pointer, :bt_integer_range_signed_handle
  typedef :pointer, :bt_integer_range_unsigned_handle
  typedef :pointer, :bt_interrupter_handle
  typedef :pointer, :bt_message_handle
  typedef :pointer, :bt_message_iterator_handle
  typedef :pointer, :bt_message_iterator_class_handle
  typedef :pointer, :bt_object_handle
  typedef :pointer, :bt_packet_handle
  typedef :pointer, :bt_plugin_handle
  typedef :pointer, :bt_plugin_set_handle
  typedef :pointer, :bt_plugin_so_shared_lib_handle_handle
  typedef :pointer, :bt_port_handle
  typedef :pointer, :bt_port_input_handle
  typedef :pointer, :bt_port_output_handle
  typedef :pointer, :bt_port_output_message_iterator_handle
  typedef :pointer, :bt_private_query_executor_handle
  typedef :pointer, :bt_query_executor_handle
  typedef :pointer, :bt_self_component_handle
  typedef :pointer, :bt_self_component_class_handle
  typedef :pointer, :bt_self_component_class_filter_handle
  typedef :pointer, :bt_self_component_class_sink_handle
  typedef :pointer, :bt_self_component_class_source_handle
  typedef :pointer, :bt_self_component_filter_handle
  typedef :pointer, :bt_self_component_filter_configuration_handle
  typedef :pointer, :bt_self_component_port_handle
  typedef :pointer, :bt_self_component_port_input_handle
  typedef :pointer, :bt_message_iterator_handle
  typedef :pointer, :bt_self_component_port_output_handle
  typedef :pointer, :bt_self_component_sink_handle
  typedef :pointer, :bt_self_component_sink_configuration_handle
  typedef :pointer, :bt_self_component_source_handle
  typedef :pointer, :bt_self_component_source_configuration_handle
  typedef :pointer, :bt_self_message_iterator_handle
  typedef :pointer, :bt_self_message_iterator_configuration_handle
  typedef :pointer, :bt_self_plugin_handle
  typedef :pointer, :bt_stream_handle
  typedef :pointer, :bt_stream_class_handle
  typedef :pointer, :bt_trace_handle
  typedef :pointer, :bt_trace_class_handle
  typedef :pointer, :bt_value_handle

  typedef :int, :bt_bool
  typedef :uint64, :bt_listner_id
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

  class BTRefCountedObject < BTObject
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
    [ :BT_PROPERTY_AVAILABILITY_AVAILABLE, 1,
      :BT_PROPERTY_AVAILABILITY_NOT_AVAILABLE, 0 ]

  typedef :pointer, :bt_message_array_const

  BT_TRUE = 1
  BT_FALSE = 0
end
