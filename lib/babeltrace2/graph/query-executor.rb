module Babeltrace2

  attach_function :bt_query_executor_create,
                  [ :bt_component_class_handle,
                    :string, :bt_value_handle ],
                  :bt_query_executor_handle

  attach_function :bt_query_executor_create_with_method_data,
                  [ :bt_component_class_handle,
                    :string, :bt_value_handle, :pointer ],
                  :bt_query_executor_handle

  BT_QUERY_EXECUTOR_QUERY_STATUS_OK = BT_FUNC_STATUS_OK
  BT_QUERY_EXECUTOR_QUERY_STATUS_UNKNOWN_OBJECT = BT_FUNC_STATUS_UNKNOWN_OBJECT
  BT_QUERY_EXECUTOR_QUERY_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_QUERY_EXECUTOR_QUERY_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_QUERY_EXECUTOR_QUERY_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTQueryExecutorQueryStatus = enum :bt_query_executor_query_status,
    [ :BT_QUERY_EXECUTOR_QUERY_STATUS_OK,
       BT_QUERY_EXECUTOR_QUERY_STATUS_OK,
      :BT_QUERY_EXECUTOR_QUERY_STATUS_UNKNOWN_OBJECT,
       BT_QUERY_EXECUTOR_QUERY_STATUS_UNKNOWN_OBJECT,
      :BT_QUERY_EXECUTOR_QUERY_STATUS_AGAIN,
       BT_QUERY_EXECUTOR_QUERY_STATUS_AGAIN,
      :BT_QUERY_EXECUTOR_QUERY_STATUS_MEMORY_ERROR,
       BT_QUERY_EXECUTOR_QUERY_STATUS_MEMORY_ERROR,
      :BT_QUERY_EXECUTOR_QUERY_STATUS_ERROR,
       BT_QUERY_EXECUTOR_QUERY_STATUS_ERROR ]

  attach_function :bt_query_executor_query,
                  [ :bt_query_executor_handle,
                    :pointer ],
                  :bt_query_executor_query_status

  BT_QUERY_EXECUTOR_SET_LOGGING_LEVEL_STATUS_OK = BT_FUNC_STATUS_OK
  BTQueryExecutorSetLoggingLevelStatus = enum :bt_query_executor_set_logging_level_status,
    [ :BT_QUERY_EXECUTOR_SET_LOGGING_LEVEL_STATUS_OK,
       BT_QUERY_EXECUTOR_SET_LOGGING_LEVEL_STATUS_OK ]

  attach_function :bt_query_executor_set_logging_level,
                  [ :bt_query_executor_handle,
                    :bt_logging_level ],
                  :bt_query_executor_set_logging_level_status

  attach_function :bt_query_executor_get_logging_level,
                  [ :bt_query_executor_handle ],
                  :bt_logging_level

  BT_QUERY_EXECUTOR_ADD_INTERRUPTER_STATUS_OK = BT_FUNC_STATUS_OK
  BT_QUERY_EXECUTOR_ADD_INTERRUPTER_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTQueryExecutorAddInterrupterStatus = enum :bt_query_executor_add_interrupter_status,
    [ :BT_QUERY_EXECUTOR_ADD_INTERRUPTER_STATUS_OK,
       BT_QUERY_EXECUTOR_ADD_INTERRUPTER_STATUS_OK,
      :BT_QUERY_EXECUTOR_ADD_INTERRUPTER_STATUS_MEMORY_ERROR,
       BT_QUERY_EXECUTOR_ADD_INTERRUPTER_STATUS_MEMORY_ERROR ]

  attach_function :bt_query_executor_add_interrupter,
                  [ :bt_query_executor_handle,
                    :bt_interrupter_handle ],
                  :bt_query_executor_add_interrupter_status

  attach_function :bt_query_executor_borrow_default_interrupter,
                  [ :bt_query_executor_handle ],
                  :bt_interrupter_handle

  attach_function :bt_query_executor_is_interrupted,
                  [ :bt_query_executor_handle ],
                  :bt_bool

  attach_function :bt_query_executor_get_ref,
                  [ :bt_query_executor_handle ],
                  :void

  attach_function :bt_query_executor_put_ref,
                  [ :bt_query_executor_handle ],
                  :void

  class BTQueryExecutor < BTSharedObject
    QueryStatus = BTQueryExecutorQueryStatus
    SetLoggingLevelStatus = BTQueryExecutorSetLoggingLevelStatus
    AddInterrupterStatus = BTQueryExecutorAddInterrupterStatus
    @get_ref = :bt_query_executor_get_ref
    @put_ref = :bt_query_executor_put_ref

    def initialize(handle = nil, retain: true, auto_release: true,
                   component_class: nil, object_name: nil, params: nil, method_data: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_query_executor_create_with_method_data(
                   component_class, object_name, BTValue.from_value(params), method_data)
        raise :BT_FUNC_STATUS_MEMORY_ERROR if handle.null?
        super(handle)
      end
    end

    def query
      ptr = FFI::MemoryPointer::new(:pointer)
      while ((res = Babeltrace2.bt_query_executor_query(@handle, ptr)) == :BT_QUERY_EXECUTOR_QUERY_STATUS_AGAIN)
        raise "interrupted by user" if interrupted?
        sleep BT_SLEEP_TIME
      end
      raise res if res != :BT_QUERY_EXECUTOR_QUERY_STATUS_OK
      BTValue.from_handle(ptr.read_pointer, retain: false)
    end

    def set_logging_level(logging_level)
      res = Babeltrace2.bt_query_executor_set_logging_level(@handle, logging_level)
      raise res if res != :BT_QUERY_EXECUTOR_SET_LOGGING_LEVEL_STATUS_OK
      self
    end

    def logging_level=(logging_level)
      res = Babeltrace2.bt_query_executor_set_logging_level(@handle, logging_level)
      raise res if res != :BT_QUERY_EXECUTOR_SET_LOGGING_LEVEL_STATUS_OK
      return logging_level
    end

    def get_logging_level
      Babeltrace2.bt_query_executor_get_logging_level(@handle)
    end
    alias logging_level get_logging_level

    def add_interrupter(interrupter)
      res = Babeltrace2.bt_query_executor_add_interrupter(@handle, interrupter)
      raise res if res != :BT_QUERY_EXECUTOR_ADD_INTERRUPTER_STATUS_OK
      self
    end

    def get_default_interrupter
      handle = Babeltrace2.bt_query_executor_borrow_default_interrupter(@handle)
      BTInterrupter.new(handle, retain: true)
    end
    alias default_interrupter get_default_interrupter

    def is_interrupted
      Babeltrace2.bt_query_executor_is_interrupted(@handle) == BT_FALSE ? false : true
    end
    alias interrupted? is_interrupted
  end
  
end
