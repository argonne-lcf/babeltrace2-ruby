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
      return nil if index >= get_stream_class_count
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
      h = BT2._callbacks[id][:destruction_listener_funcs]
      if h.nil?
        h = {}
        BT2._callbacks[id][:destruction_listener_funcs] = h
      end
      h[listener_id] = [user_func, user_data]
      listener_id
    end

    def remove_destruction_listener(listener_id)
      res = Babeltrace2.bt_trace_class_remove_destruction_listener(@handle, listener_id)
      raise Babeltrace2.process_error(res) if res != :BT_TRACE_CLASS_REMOVE_LISTENER_STATUS_OK
      BT2._callbacks[@handle.to_i][:destruction_listener_funcs].delete(listener_id)
      self
    end
  end
end
