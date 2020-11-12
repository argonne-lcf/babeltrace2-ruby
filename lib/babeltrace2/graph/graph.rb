module Babeltrace2

  attach_function :bt_graph_get_ref,
                  [:bt_graph_handle],
                  :void
  attach_function :bt_graph_put_ref,
                  [:bt_graph_handle],
                  :void
  attach_function :bt_graph_create,
                  [:uint64],
                  :bt_graph_handle

  BTGraphAddComponentStatus = enum :bt_graph_add_component_status,
    [ :BT_GRAPH_ADD_COMPONENT_STATUS_OK, BT_FUNC_STATUS_OK,
      :BT_GRAPH_ADD_COMPONENT_STATUS_MEMORY_ERROR, BT_FUNC_STATUS_MEMORY_ERROR,
      :BT_GRAPH_ADD_COMPONENT_STATUS_ERROR, BT_FUNC_STATUS_ERROR ]

  attach_function :bt_graph_add_source_component,
                  [ :bt_graph_handle,
                    :bt_component_class_source_handle,
                    :string, :bt_value_handle, :bt_logging_level,
                    :pointer ],
                  :bt_graph_add_component_status

  attach_function :bt_graph_add_source_component_with_initialize_method_data,
                  [ :bt_graph_handle,
                    :bt_component_class_source_handle,
                    :string, :bt_value_handle, :pointer,
                    :bt_logging_level, :pointer ],
                  :bt_graph_add_component_status

  attach_function :bt_graph_add_filter_component,
                  [ :bt_graph_handle,
                    :bt_component_class_filter_handle,
                    :string, :bt_value_handle, :bt_logging_level,
                    :pointer ],
                  :bt_graph_add_component_status

  attach_function :bt_graph_add_filter_component_with_initialize_method_data,
                  [ :bt_graph_handle,
                    :bt_component_class_filter_handle,
                    :string, :bt_value_handle, :pointer,
                    :bt_logging_level, :pointer ],
                  :bt_graph_add_component_status

  attach_function :bt_graph_add_sink_component,
                  [ :bt_graph_handle,
                    :bt_component_class_sink_handle,
                    :string, :bt_value_handle, :bt_logging_level,
                    :pointer ],
                  :bt_graph_add_component_status

  attach_function :bt_graph_add_sink_component_with_initialize_method_data,
                  [ :bt_graph_handle,
                    :bt_component_class_sink_handle,
                    :string, :bt_value_handle, :pointer,
                    :bt_logging_level, :pointer ],
                  :bt_graph_add_component_status

  BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_OK = BT_FUNC_STATUS_OK
  BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTGraphSimpleSinkComponentInitializeFuncStatus =
    enum :bt_graph_simple_sink_component_initialize_func_status,
    [ :BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_OK,
       BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_OK,
      :BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_MEMORY_ERROR,
       BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_MEMORY_ERROR,
      :BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_ERROR,
       BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_ERROR ]

  callback :bt_graph_simple_sink_component_initialize_func,
           [ :bt_message_iterator_handle, :pointer ],
           :bt_graph_simple_sink_component_initialize_func_status

  class BTGraph < BTSharedObject
    SimpleSinkComponentInitializeFuncStatus = BTGraphSimpleSinkComponentInitializeFuncStatus
    @get_ref = :bt_graph_get_ref
    @put_ref = :bt_graph_put_ref

    def initialize(handle = nil, mip_version: 0)
      if handle
        super(handle, retain: true)
      else
        handle = Babeltrace2.bt_graph_create(mip_version)
        raise :BT_FUNC_STATUS_MEMORY_ERROR if handle.null?
        super(handle)
      end
    end

    def add_source_component(component_class, name, params: {},
                             logging_level: :BT_LOGGING_LEVEL_NONE,
                             initialize_method_data: nil)
      ptr = FFI::MemoryPointer::new(:pointer)
      res = if initialize_method_data
          Babeltrace2.bt_graph_add_source_component_with_initialize_method_data(
            @handle, component_class, name, BTValue.from_value(params),
            initialize_method_data, ptr)
        else
          Babeltrace2.bt_graph_add_source_component(
            @handle, component_class, name, BTValue.from_value(params), ptr)
        end
      raise res if res != :BT_GRAPH_ADD_COMPONENT_STATUS_OK
      BTComponentSource.new(ptr.read_pointer, retain: true, auto_release: true)
    end

    def add_filter_component(component_class, name, params: {},
                             logging_level: :BT_LOGGING_LEVEL_NONE,
                             initialize_method_data: nil)
      ptr = FFI::MemoryPointer::new(:pointer)
      res = if initialize_method_data
          Babeltrace2.bt_graph_add_filter_component_with_initialize_method_data(
            @handle, component_class, name, BTValue.from_value(params),
            initialize_method_data, ptr)
        else
          Babeltrace2.bt_graph_add_filter_component(
            @handle, component_class, name, BTValue.from_value(params), ptr)
        end
      raise res if res != :BT_GRAPH_ADD_COMPONENT_STATUS_OK
      BTComponentFilter.new(ptr.read_pointer, retain: true, auto_release: true)
    end

    def add_sink_component(component_class, name, params: {},
                           logging_level: :BT_LOGGING_LEVEL_NONE,
                           initialize_method_data: nil)
      ptr = FFI::MemoryPointer::new(:pointer)
      res = if initialize_method_data
          Babeltrace2.bt_graph_add_sink_component_with_initialize_method_data(
            @handle, component_class, name, BTValue.from_value(params),
            initialize_method_data, ptr)
        else
          Babeltrace2.bt_graph_add_sink_component(
            @handle, component_class, name, BTValue.from_value(params), ptr)
        end
      raise res if res != :BT_GRAPH_ADD_COMPONENT_STATUS_OK
      BTComponentSink.new(ptr.read_pointer, retain: true, auto_release: true)
    end

    def add_component(component_class, name, params: {},
                      logging_level: :BT_LOGGING_LEVEL_NONE,
                      initialize_method_data: nil)
      case component_class.type
      when :BT_COMPONENT_CLASS_SOURCE
        add_source_component(component_class, name, params: params,
                             logging_level: logging_level,
                             initialize_method_data: initialize_method_data)
      when :BT_COMPONENT_CLASS_FILTER
        add_filter_component(component_class, name, params: params,
                             logging_level: logging_level,
                             initialize_method_data: initialize_method_data)
      when :BT_COMPONENT_CLASS_SINK
        add_sink_component(component_class, name, params: params,
                           logging_level: logging_level,
                           initialize_method_data: initialize_method_data)
      else
        raise "invalid component type"
      end
    end

  end 
end

