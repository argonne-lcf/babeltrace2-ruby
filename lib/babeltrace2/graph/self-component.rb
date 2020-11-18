module Babeltrace2

  BT_SELF_COMPONENT_ADD_PORT_STATUS_OK = BT_FUNC_STATUS_OK
  BT_SELF_COMPONENT_ADD_PORT_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_SELF_COMPONENT_ADD_PORT_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTSelfComponentAddPortStatus = enum :bt_self_component_add_port_status,
    [ :BT_SELF_COMPONENT_ADD_PORT_STATUS_OK,
       BT_SELF_COMPONENT_ADD_PORT_STATUS_OK,
      :BT_SELF_COMPONENT_ADD_PORT_STATUS_MEMORY_ERROR,
       BT_SELF_COMPONENT_ADD_PORT_STATUS_MEMORY_ERROR,
      :BT_SELF_COMPONENT_ADD_PORT_STATUS_ERROR,
       BT_SELF_COMPONENT_ADD_PORT_STATUS_ERROR ]

  attach_function :bt_self_component_get_data,
                  [ :bt_self_component_handle ],
                  :pointer

  attach_function :bt_self_component_set_data,
                  [ :bt_self_component_handle,
                    :pointer ],
                  :void

  attach_function :bt_self_component_get_graph_mip_version,
                  [ :bt_self_component_handle ],
                  :uint64

  module BTSelfComponent
    AddPortStatus = BTSelfComponentAddPortStatus

    def self.from_handle(handle, retain: true, auto_release: true)
      case Babeltrace2.bt_component_get_class_type(handle)
      when :BT_COMPONENT_CLASS_TYPE_SOURCE
        handle = BTSelfComponentSourceHandle.new(handle)
        BTSelfComponentSource
      when :BT_COMPONENT_CLASS_TYPE_FILTER
        handle = BTSelfComponentFilterHandle.new(handle)
        BTSelfComponentFilter
      when :BT_COMPONENT_CLASS_TYPE_SINK
        handle = BTSelfComponentSinkHandle.new(handle)
        BTSelfComponentSink
      else
        raise Error.new("Unknown component class type")
      end.new(handle, retain: retain, auto_release: auto_release)
    end

    def set_data(user_data)
      Babeltrace2.bt_self_component_set_data(@handle, user_data)
      self
    end

    def data=(user_data)
      set_data(user_data)
      user_data
    end

    def get_data
      Babeltrace2.bt_self_component_get_data(@handle)
    end
    alias data get_data

    def get_graph_mip_version
      Babeltrace2.bt_self_component_get_graph_mip_version(@handle)
    end
    alias graph_mip_version get_graph_mip_version
  end

  attach_function :bt_self_component_source_add_output_port,
                  [ :bt_self_component_source_handle,
                    :string, :pointer,
                    :pointer ],
                  :bt_self_component_add_port_status

  attach_function :bt_self_component_source_borrow_output_port_by_index,
                  [ :bt_self_component_source_handle,
                    :uint64 ],
                  :bt_self_component_port_output_handle

  attach_function :bt_self_component_source_borrow_output_port_by_name,
                  [ :bt_self_component_source_handle,
                    :string ],
                  :bt_self_component_port_output_handle

  class BTSelfComponent::Source < BTComponent::Source
    include BTSelfComponent
    class Configuration < BTObject
    end

    def add_output_port(name, user_data: nil)
      ptr = FFI::MemoryPointer::new(:pointer)
      res = Babeltrace2.bt_self_component_source_add_output_port(@handle, name, user_data, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_SELF_COMPONENT_ADD_PORT_STATUS_OK
      BTSelfComponent::Port::Output.new(BTSelfComponentPortOutputHandle.new(ptr.read_pointer),
                                    retain: true, auto_release: true)
    end

    def get_output_port_by_index(index)
      return nil if index >= get_output_port_count
      handle = Babeltrace2.bt_self_component_source_borrow_output_port_by_index(@handle, index)
      BTSelfComponentPortOutput.new(handle, retain: true, auto_release: true)
    end

    def get_output_port_by_name(index)
      handle = Babeltrace2.bt_self_component_source_borrow_output_port_by_name(@handle, name)
      return nil if handle.null?
      BTSelfComponentPortOutput.new(handle, retain: true, auto_release: true)
    end
  end
  BTSelfComponentSource = BTSelfComponent::Source
  BTSelfComponentSourceConfiguration = BTSelfComponent::Source::Configuration

  attach_function :bt_self_component_filter_add_input_port,
                  [ :bt_self_component_filter_handle,
                    :string, :pointer,
                    :pointer ],
                  :bt_self_component_add_port_status

  attach_function :bt_self_component_filter_add_output_port,
                  [ :bt_self_component_filter_handle,
                    :string, :pointer,
                    :pointer ],
                  :bt_self_component_add_port_status

  attach_function :bt_self_component_filter_borrow_output_port_by_index,
                  [ :bt_self_component_filter_handle,
                    :uint64 ],
                  :bt_self_component_port_output_handle

  attach_function :bt_self_component_filter_borrow_output_port_by_name,
                  [ :bt_self_component_filter_handle,
                    :string ],
                  :bt_self_component_port_output_handle

  attach_function :bt_self_component_filter_borrow_input_port_by_index,
                  [ :bt_self_component_filter_handle,
                    :uint64 ],
                  :bt_self_component_port_input_handle

  attach_function :bt_self_component_filter_borrow_input_port_by_name,
                  [ :bt_self_component_filter_handle,
                    :string ],
                  :bt_self_component_port_input_handle

  class BTSelfComponent::Filter < BTComponent::Filter
    include BTSelfComponent
    class Configuration < BTObject
    end

    def add_output_port(name, user_data: nil)
      ptr = FFI::MemoryPointer::new(:pointer)
      res = Babeltrace2.bt_self_component_filter_add_output_port(@handle, name, user_data, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_SELF_COMPONENT_ADD_PORT_STATUS_OK
      BTSelfComponentPortOutput.new(BTSelfComponentPortOutputHandle.new(ptr.read_pointer),
                                    retain: true, auto_release: true)
    end

    def add_input_port(name, user_data: nil)
      ptr = FFI::MemoryPointer::new(:pointer)
      res = Babeltrace2.bt_self_component_filter_add_input_port(@handle, name, user_data, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_SELF_COMPONENT_ADD_PORT_STATUS_OK
      BTSelfComponentPortInput.new(BTSelfComponentPortInputHandle.new(ptr.read_pointer),
                                   retain: true, auto_release: true)
    end

    def get_output_port_by_index(index)
      return nil if index >= get_output_port_count
      handle = Babeltrace2.bt_self_component_filter_borrow_output_port_by_index(@handle, index)
      BTSelfComponentPortOutput.new(handle, retain: true, auto_release: true)
    end

    def get_output_port_by_name(index)
      handle = Babeltrace2.bt_self_component_filter_borrow_output_port_by_name(@handle, name)
      return nil if handle.null?
      BTSelfComponentPortOutput.new(handle, retain: true, auto_release: true)
    end

    def get_input_port_by_index(index)
      return nil if index >= get_input_port_count
      handle = Babeltrace2.bt_self_component_filter_borrow_input_port_by_index(@handle, index)
      BTSelfComponentPortInput.new(handle, retain: true, auto_release: true)
    end

    def get_input_port_by_name(index)
      handle = Babeltrace2.bt_self_component_filter_borrow_input_port_by_name(@handle, name)
      return nil if handle.null?
      BTSelfComponentPortInput.new(handle, retain: true, auto_release: true)
    end
  end
  BTSelfComponentFilter = BTSelfComponent::Filter
  BTSelfComponentFilterConfiguration = BTSelfComponent::Filter::Configuration

  attach_function :bt_self_component_sink_add_input_port,
                  [ :bt_self_component_sink_handle,
                    :string, :pointer,
                    :pointer ],
                  :bt_self_component_add_port_status

  attach_function :bt_self_component_sink_borrow_input_port_by_index,
                  [ :bt_self_component_sink_handle,
                    :uint64 ],
                  :bt_self_component_port_input_handle

  attach_function :bt_self_component_sink_borrow_input_port_by_name,
                  [ :bt_self_component_sink_handle,
                    :string ],
                  :bt_self_component_port_input_handle

  attach_function :bt_self_component_sink_is_interrupted,
                  [ :bt_self_component_sink_handle ],
                  :bt_bool

  class BTSelfComponent::Sink < BTComponent::Sink
    include BTSelfComponent
    class Configuration < BTObject
    end

    def add_input_port(name, user_data: nil)
      ptr = FFI::MemoryPointer::new(:pointer)
      res = Babeltrace2.bt_self_component_sink_add_input_port(@handle, name, user_data, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_SELF_COMPONENT_ADD_PORT_STATUS_OK
      BTSelfComponentPortInput.new(BTSelfComponentPortInputHandle.new(ptr.read_pointer),
                                   retain: true, auto_release: true)
    end

    def get_input_port_by_index(index)
      return nil if index >= get_input_port_count
      handle = Babeltrace2.bt_self_component_sink_borrow_input_port_by_index(@handle, index)
      BTSelfComponentPortInput.new(handle, retain: true, auto_release: true)
    end

    def get_input_port_by_name(index)
      handle = Babeltrace2.bt_self_component_sink_borrow_input_port_by_name(@handle, name)
      return nil if handle.null?
      BTSelfComponentPortInput.new(handle, retain: true, auto_release: true)
    end

    def is_interrupted
      Babeltrace2.bt_self_component_sink_is_interrupted(@handle) == BT_FALSE ? false : true
    end
    alias interrupted? is_interrupted
  end
  BTSelfComponentSink = BTSelfComponent::Sink
  BTSelfComponentSinkConfiguration = BTSelfComponent::Sink::Configuration

end
