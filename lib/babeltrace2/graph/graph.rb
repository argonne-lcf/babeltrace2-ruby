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
                    :string, :bt_value_map_handle, :bt_logging_level,
                    :pointer ],
                  :bt_graph_add_component_status

  attach_function :bt_graph_add_source_component_with_initialize_method_data,
                  [ :bt_graph_handle,
                    :bt_component_class_source_handle,
                    :string, :bt_value_map_handle, :pointer,
                    :bt_logging_level, :pointer ],
                  :bt_graph_add_component_status

  attach_function :bt_graph_add_filter_component,
                  [ :bt_graph_handle,
                    :bt_component_class_filter_handle,
                    :string, :bt_value_map_handle, :bt_logging_level,
                    :pointer ],
                  :bt_graph_add_component_status

  attach_function :bt_graph_add_filter_component_with_initialize_method_data,
                  [ :bt_graph_handle,
                    :bt_component_class_filter_handle,
                    :string, :bt_value_map_handle, :pointer,
                    :bt_logging_level, :pointer ],
                  :bt_graph_add_component_status

  attach_function :bt_graph_add_sink_component,
                  [ :bt_graph_handle,
                    :bt_component_class_sink_handle,
                    :string, :bt_value_map_handle, :bt_logging_level,
                    :pointer ],
                  :bt_graph_add_component_status

  attach_function :bt_graph_add_sink_component_with_initialize_method_data,
                  [ :bt_graph_handle,
                    :bt_component_class_sink_handle,
                    :string, :bt_value_map_handle, :pointer,
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

  def self._wrap_graph_simple_sink_component_initialize_func(method)
    lambda { |message_iterator, user_data|
      begin
        method.call(BTMessageIterator.new(message_iterator,
                      retain: false, auto_release: false), user_data)
        :BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_OK
      rescue Exception => e
        Babeltrace2.stack_ruby_error(e, source: message_iterator)
        :BT_GRAPH_SIMPLE_SINK_COMPONENT_INITIALIZE_FUNC_STATUS_ERROR
      end
    }
  end

  BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_OK = BT_FUNC_STATUS_OK
  BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_END = BT_FUNC_STATUS_END
  BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTGraphSimpleSinkComponentConsumeFuncStatus =
    enum :bt_graph_simple_sink_component_consume_func_status,
    [ :BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_OK,
       BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_OK,
      :BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_END,
       BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_END,
      :BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_AGAIN,
       BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_AGAIN,
      :BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_MEMORY_ERROR,
       BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_MEMORY_ERROR,
      :BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_ERROR,
       BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_ERROR ]

  callback :bt_graph_simple_sink_component_consume_func,
           [ :bt_message_iterator_handle, :pointer ],
           :bt_graph_simple_sink_component_consume_func_status

  def self._wrap_graph_simple_sink_component_consume_func(method)
    lambda { |message_iterator, user_data|
      begin
        method.call(BTMessageIterator.new(message_iterator,
                      retain: false, auto_release: false), user_data)
        :BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_OK
      rescue StopIteration
        :BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_END
      rescue Exception => e
        Babeltrace2.stack_ruby_error(e, source: message_iterator)
        :BT_GRAPH_SIMPLE_SINK_COMPONENT_CONSUME_FUNC_STATUS_ERROR
      end
    }
  end

  callback :bt_graph_simple_sink_component_finalize_func,
           [ :pointer ],
           :void

  attach_function :bt_graph_add_simple_sink_component,
                  [ :bt_graph_handle, :string,
                  :bt_graph_simple_sink_component_initialize_func,
                  :bt_graph_simple_sink_component_consume_func,
                  :bt_graph_simple_sink_component_finalize_func,
                  :pointer, :pointer ],
                  :bt_graph_add_component_status

  BT_GRAPH_CONNECT_PORTS_STATUS_OK = BT_FUNC_STATUS_OK
  BT_GRAPH_CONNECT_PORTS_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_GRAPH_CONNECT_PORTS_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTGraphConnectPortsStatus =
    enum :bt_graph_connect_ports_status,
    [ :BT_GRAPH_CONNECT_PORTS_STATUS_OK,
       BT_GRAPH_CONNECT_PORTS_STATUS_OK,
      :BT_GRAPH_CONNECT_PORTS_STATUS_MEMORY_ERROR,
       BT_GRAPH_CONNECT_PORTS_STATUS_MEMORY_ERROR,
      :BT_GRAPH_CONNECT_PORTS_STATUS_ERROR,
       BT_GRAPH_CONNECT_PORTS_STATUS_ERROR ]

  attach_function :bt_graph_connect_ports,
                  [ :bt_graph_handle,
                    :bt_port_output_handle,
                    :bt_port_input_handle,
                    :pointer ],
                  :bt_graph_connect_ports_status

  BT_GRAPH_RUN_STATUS_OK = BT_FUNC_STATUS_OK
  BT_GRAPH_RUN_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_GRAPH_RUN_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_GRAPH_RUN_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTGraphRunStatus = enum :bt_graph_run_status,
    [ :BT_GRAPH_RUN_STATUS_OK,
       BT_GRAPH_RUN_STATUS_OK,
      :BT_GRAPH_RUN_STATUS_AGAIN,
       BT_GRAPH_RUN_STATUS_AGAIN,
      :BT_GRAPH_RUN_STATUS_MEMORY_ERROR,
       BT_GRAPH_RUN_STATUS_MEMORY_ERROR,
      :BT_GRAPH_RUN_STATUS_ERROR,
       BT_GRAPH_RUN_STATUS_ERROR ]

  attach_function :bt_graph_run,
                  [ :bt_graph_handle ],
                  :bt_graph_run_status

  BT_GRAPH_RUN_ONCE_STATUS_OK = BT_FUNC_STATUS_OK
  BT_GRAPH_RUN_ONCE_STATUS_END = BT_FUNC_STATUS_END
  BT_GRAPH_RUN_ONCE_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_GRAPH_RUN_ONCE_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_GRAPH_RUN_ONCE_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTGraphRunOnceStatus = enum :bt_graph_run_once_status,
    [ :BT_GRAPH_RUN_ONCE_STATUS_OK,
       BT_GRAPH_RUN_ONCE_STATUS_OK,
      :BT_GRAPH_RUN_ONCE_STATUS_END,
       BT_GRAPH_RUN_ONCE_STATUS_END,
      :BT_GRAPH_RUN_ONCE_STATUS_AGAIN,
       BT_GRAPH_RUN_ONCE_STATUS_AGAIN,
      :BT_GRAPH_RUN_ONCE_STATUS_MEMORY_ERROR,
       BT_GRAPH_RUN_ONCE_STATUS_MEMORY_ERROR,
      :BT_GRAPH_RUN_ONCE_STATUS_ERROR,
       BT_GRAPH_RUN_ONCE_STATUS_ERROR ]

  attach_function :bt_graph_run_once,
                  [ :bt_graph_handle ],
                  :bt_graph_run_once_status

  BT_GRAPH_ADD_INTERRUPTER_STATUS_OK = BT_FUNC_STATUS_OK
  BT_GRAPH_ADD_INTERRUPTER_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTGraphAddInterrupterStatus = enum :bt_graph_add_interrupter_status,
    [ :BT_GRAPH_ADD_INTERRUPTER_STATUS_OK,
       BT_GRAPH_ADD_INTERRUPTER_STATUS_OK,
      :BT_GRAPH_ADD_INTERRUPTER_STATUS_MEMORY_ERROR,
       BT_GRAPH_ADD_INTERRUPTER_STATUS_MEMORY_ERROR ]

  attach_function :bt_graph_add_interrupter,
                  [ :bt_graph_handle, :bt_interrupter_handle ],
                  :bt_graph_add_interrupter_status

  attach_function :bt_graph_borrow_default_interrupter,
                  [ :bt_graph_handle ],
                  :bt_interrupter_handle

  BT_GRAPH_ADD_LISTENER_STATUS_OK = BT_FUNC_STATUS_OK
  BT_GRAPH_ADD_LISTENER_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTGraphAddListenerStatus = enum :bt_graph_add_listener_status,
    [ :BT_GRAPH_ADD_LISTENER_STATUS_OK,
       BT_GRAPH_ADD_LISTENER_STATUS_OK,
      :BT_GRAPH_ADD_LISTENER_STATUS_MEMORY_ERROR,
       BT_GRAPH_ADD_LISTENER_STATUS_MEMORY_ERROR ]

  BT_GRAPH_LISTENER_FUNC_STATUS_OK = BT_FUNC_STATUS_OK
  BT_GRAPH_LISTENER_FUNC_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_GRAPH_LISTENER_FUNC_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTGraphListenerFuncStatus = enum :bt_graph_listener_func_status,
    [ :BT_GRAPH_LISTENER_FUNC_STATUS_OK,
       BT_GRAPH_LISTENER_FUNC_STATUS_OK,
      :BT_GRAPH_LISTENER_FUNC_STATUS_MEMORY_ERROR,
       BT_GRAPH_LISTENER_FUNC_STATUS_MEMORY_ERROR,
      :BT_GRAPH_LISTENER_FUNC_STATUS_ERROR,
       BT_GRAPH_LISTENER_FUNC_STATUS_ERROR ]

  callback :bt_graph_filter_component_input_port_added_listener_func,
           [ :bt_component_filter_handle, :bt_port_input_handle,
             :pointer ],
           :bt_graph_listener_func_status

  def self._wrap_graph_component_port_added_listener_func(
             component_class, port_class, category, handle, method)
    id = handle.to_i
    method_wrapper = lambda { |component, port, user_data|
      begin
        method.call(component_class.new(component, retain: false, auto_release: false),
                    port_class.new(port, retain: false, auto_release: false),
                    user_data)
        :BT_GRAPH_LISTENER_FUNC_STATUS_OK
      rescue Exception => e
        Babeltrace2.stack_ruby_error(e, source: component)
        :BT_GRAPH_LISTENER_FUNC_STATUS_ERROR
      end
    }
    arr = @@callbacks[id][category]
    if arr.nil?
      arr = []
      @@callbacks[id][category] = arr
    end
    arr.push method_wrapper
    method_wrapper
  end

  def self._wrap_graph_filter_component_input_port_added_listener_func(handle, method)
    _wrap_graph_component_port_added_listener_func(
      BTComponentFilter, BTPortInput, :filter_component_input_port_added_listener_funcs,
      handle, method)
  end

  attach_function :bt_graph_add_filter_component_input_port_added_listener,
                  [ :bt_graph_handle,
                    :bt_graph_filter_component_input_port_added_listener_func,
                    :pointer, :pointer ],
                  :bt_graph_add_listener_status

  callback :bt_graph_sink_component_input_port_added_listener_func,
           [ :bt_component_sink_handle, :bt_port_input_handle,
             :pointer ],
           :bt_graph_listener_func_status

  def self._wrap_graph_sink_component_input_port_added_listener_func(handle, method)
    _wrap_graph_component_port_added_listener_func(
      BTComponentSink, BTPortInput, :sink_component_input_port_added_listener_funcs,
      handle, method)
  end

  attach_function :bt_graph_add_sink_component_input_port_added_listener,
                  [ :bt_graph_handle,
                    :bt_graph_sink_component_input_port_added_listener_func,
                    :pointer, :pointer ],
                  :bt_graph_add_listener_status

  callback :bt_graph_source_component_output_port_added_listener_func,
           [ :bt_component_source_handle, :bt_port_output_handle,
             :pointer ],
           :bt_graph_listener_func_status

  def self._wrap_graph_source_component_output_port_added_listener_func(handle, method)
    _wrap_graph_component_port_added_listener_func(
      BTComponentSource, BTPortOutput, :source_component_output_port_added_listener_funcs,
      handle, method)
  end

  attach_function :bt_graph_add_source_component_output_port_added_listener,
                  [ :bt_graph_handle,
                    :bt_graph_source_component_output_port_added_listener_func,
                    :pointer, :pointer ],
                  :bt_graph_add_listener_status

  callback :bt_graph_filter_component_output_port_added_listener_func,
           [ :bt_component_filter_handle, :bt_port_output_handle,
             :pointer ],
           :bt_graph_listener_func_status

  def self._wrap_graph_filter_component_output_port_added_listener_func(handle, method)
    _wrap_graph_component_port_added_listener_func(
      BTComponentFilter, BTPortOutput, :filter_component_output_port_added_listener_funcs,
      handle, method)
  end

  attach_function :bt_graph_add_filter_component_output_port_added_listener,
                  [ :bt_graph_handle,
                    :bt_graph_filter_component_output_port_added_listener_func,
                    :pointer, :pointer ],
                  :bt_graph_add_listener_status

  class BTGraph < BTSharedObject
    AddComponentStatus = BTGraphAddComponentStatus
    SimpleSinkComponentInitializeFuncStatus = BTGraphSimpleSinkComponentInitializeFuncStatus
    SimpleSinkComponentConsumeFuncStatus = BTGraphSimpleSinkComponentConsumeFuncStatus
    ConnectPortsStatus = BTGraphConnectPortsStatus
    RunStatus = BTGraphRunStatus
    RunOnceStatus = BTGraphRunOnceStatus
    AddInterrupterStatus = BTGraphAddInterrupterStatus
    AddListenerStatus = BTGraphAddListenerStatus
    ListenerFuncStatus = BTGraphListenerFuncStatus
    @get_ref = :bt_graph_get_ref
    @put_ref = :bt_graph_put_ref

    def initialize(handle = nil, retain: true, auto_release: true,
                   mip_version: 0)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_graph_create(mip_version)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def add_source_component(component_class, name, params: {},
                             logging_level: BTLogging.default_level,
                             initialize_method_data: nil)
      ptr = FFI::MemoryPointer.new(:pointer)
      bt_params = BTValue.from_value(params)
      res = if initialize_method_data
          Babeltrace2.bt_graph_add_source_component_with_initialize_method_data(
            @handle, component_class, name, bt_params,
            initialize_method_data, logging_level, ptr)
        else
          Babeltrace2.bt_graph_add_source_component(
            @handle, component_class, name, bt_params,
            logging_level, ptr)
        end
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_ADD_COMPONENT_STATUS_OK
      BTComponentSource.new(BTComponentSourceHandle.new(ptr.read_pointer), retain: true)
    end
    alias add_source add_source_component

    def add_filter_component(component_class, name, params: {},
                             logging_level: BTLogging.default_level,
                             initialize_method_data: nil)
      ptr = FFI::MemoryPointer.new(:pointer)
      bt_params = BTValue.from_value(params)
      res = if initialize_method_data
          Babeltrace2.bt_graph_add_filter_component_with_initialize_method_data(
            @handle, component_class, name, bt_params,
            initialize_method_data, logging_level, ptr)
        else
          Babeltrace2.bt_graph_add_filter_component(
            @handle, component_class, name, bt_params,
            logging_level, ptr)
        end
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_ADD_COMPONENT_STATUS_OK
      BTComponentFilter.new(BTComponentFilterHandle.new(ptr.read_pointer), retain: true)
    end
    alias add_filter add_filter_component

    def add_sink_component(component_class, name, params: {},
                           logging_level: BTLogging.default_level,
                           initialize_method_data: nil)
      ptr = FFI::MemoryPointer.new(:pointer)
      bt_params = BTValue.from_value(params)
      res = if initialize_method_data
          Babeltrace2.bt_graph_add_sink_component_with_initialize_method_data(
            @handle, component_class, name, bt_params,
            initialize_method_data, logging_level, ptr)
        else
          Babeltrace2.bt_graph_add_sink_component(
            @handle, component_class, name, bt_params,
            logging_level, ptr)
        end
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_ADD_COMPONENT_STATUS_OK
      BTComponentSink.new(BTComponentSinkHandle.new(ptr.read_pointer), retain: true)
    end
    alias add_sink add_sink_component

    def add_component(component_class, name, params: {},
                      logging_level: BTLogging.default_level,
                      initialize_method_data: nil)
      case component_class.type
      when :BT_COMPONENT_CLASS_TYPE_SOURCE
        add_source_component(component_class, name, params: params,
                             logging_level: logging_level,
                             initialize_method_data: initialize_method_data)
      when :BT_COMPONENT_CLASS_TYPE_FILTER
        add_filter_component(component_class, name, params: params,
                             logging_level: logging_level,
                             initialize_method_data: initialize_method_data)
      when :BT_COMPONENT_CLASS_TYPE_SINK
        add_sink_component(component_class, name, params: params,
                           logging_level: logging_level,
                           initialize_method_data: initialize_method_data)
      else
        raise "invalid component type"
      end
    end
    alias add add_component

    def add_simple_sink_component(name, consume_func, initialize_func: nil, finalize_func: nil, user_data: nil)
      initialize_func =
        Babeltrace2._wrap_graph_simple_sink_component_initialize_func(initialize_func) if initialize_func
      consume_func =
        Babeltrace2._wrap_graph_simple_sink_component_consume_func(consume_func)
      ptr = FFI::MemoryPointer.new(:pointer)
      res = Babeltrace2.bt_graph_add_simple_sink_component(@handle, name, initialize_func, consume_func, finalize_func, user_data, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_ADD_COMPONENT_STATUS_OK
      handle = BTComponentSinkHandle.new(ptr.read_pointer)
      id = handle.to_i
      Babeltrace2._callbacks[id][:initialize_func] = initialize_func
      Babeltrace2._callbacks[id][:consume_func] = consume_func
      Babeltrace2._callbacks[id][:finalize_func] = finalize_func
      BTComponentSink.new(handle, retain: true)
    end
    alias add_simple_sink add_simple_sink_component

    def connect_ports(upstream_port, downstream_port)
      raise "upstream port already connected" if upstream_port.connected?
      raise "downstream port already connected" if downstream_port.connected?
      ptr = FFI::MemoryPointer.new(:pointer)
      res = Babeltrace2.bt_graph_connect_ports(@handle, upstream_port, downstream_port, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_CONNECT_PORTS_STATUS_OK
      BTConnection.new(BTConnectionHandle.new(ptr.read_pointer), retain: true)
    end

    def run
      while ((res = Babeltrace2.bt_graph_run(@handle)) == :BT_GRAPH_RUN_STATUS_AGAIN)
        sleep BT_SLEEP_TIME
      end
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_RUN_STATUS_OK
      self
    end

    def run_once
      while ((res = Babeltrace2.bt_graph_run_once(@handle)) == :BT_GRAPH_RUN_ONCE_STATUS_AGAIN)
        sleep BT_SLEEP_TIME
      end
      case res
      when :BT_GRAPH_RUN_ONCE_STATUS_OK
        self
      when :BT_GRAPH_RUN_ONCE_STATUS_END
        raise StopIteration
      else
        raise Babeltrace2.process_error(res)
      end
    end

    def add_interrupter(interrupter)
      res = Babeltrace2.bt_graph_add_interrupter(@handle, interrupter)
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_ADD_INTERRUPTER_STATUS_OK
      self
    end

    def get_default_interrupter
      handle = Babeltrace2.bt_graph_borrow_default_interrupter(@handle)
      BTInterrupter.new(handle, retain: true)
    end
    alias default_interrupter get_default_interrupter

    def add_filter_component_input_port_added_listener(user_func, user_data: nil)
      ptr = FFI::MemoryPointer.new(:uint64)
      user_func = Babeltrace2._wrap_graph_filter_component_input_port_added_listener_func(
                    @handle, user_func)
      res = Babeltrace2.bt_graph_add_filter_component_input_port_added_listener(
              @handle, user_func, user_data, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_ADD_LISTENER_STATUS_OK
      ptr.read_uint64
    end

    def add_sink_component_input_port_added_listener(user_func, user_data: nil)
      ptr = FFI::MemoryPointer.new(:uint64)
      user_func = Babeltrace2._wrap_graph_sink_component_input_port_added_listener_func(
                    @handle, user_func)
      res = Babeltrace2.bt_graph_add_sink_component_input_port_added_listener(
              @handle, user_func, user_data, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_ADD_LISTENER_STATUS_OK
      ptr.read_uint64
    end

    def add_source_component_output_port_added_listener(user_func, user_data: nil)
      ptr = FFI::MemoryPointer.new(:uint64)
      user_func = Babeltrace2._wrap_graph_source_component_output_port_added_listener_func(
                    @handle, user_func)
      res = Babeltrace2.bt_graph_add_source_component_output_port_added_listener(
              @handle, user_func, user_data, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_ADD_LISTENER_STATUS_OK
      ptr.read_uint64
    end

    def add_filter_component_output_port_added_listener(user_func, user_data: nil)
      ptr = FFI::MemoryPointer.new(:uint64)
      user_func = Babeltrace2._wrap_graph_filter_component_output_port_added_listener_func(
                    @handle, user_func)
      res = Babeltrace2.bt_graph_add_filter_component_output_port_added_listener(
              @handle, user_func, user_data, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_GRAPH_ADD_LISTENER_STATUS_OK
      ptr.read_uint64
    end
  end
end

