module Babeltrace2

  attach_function :bt_trace_create,
                  [ :bt_trace_class_handle ],
                  :bt_trace_handle

  attach_function :bt_trace_borrow_class,
                  [ :bt_trace_handle ],
                  :bt_trace_class_handle

  attach_function :bt_trace_borrow_class_const,
                  [ :bt_trace_handle ],
                  :bt_trace_class_handle

  attach_function :bt_trace_get_stream_count,
                  [ :bt_trace_handle ],
                  :uint64

  attach_function :bt_trace_borrow_stream_by_index,
                  [ :bt_trace_handle, :uint64 ],
                  :bt_stream_handle

  attach_function :bt_trace_borrow_stream_by_index_const,
                  [ :bt_trace_handle, :uint64 ],
                  :bt_stream_handle

  attach_function :bt_trace_borrow_stream_by_id,
                  [ :bt_trace_handle, :uint64 ],
                  :bt_stream_handle

  attach_function :bt_trace_borrow_stream_by_id_const,
                  [ :bt_trace_handle, :uint64 ],
                  :bt_stream_handle

  attach_function :bt_trace_get_name,
                  [ :bt_trace_handle ],
                  :string

  BT_TRACE_SET_NAME_STATUS_OK = BT_FUNC_STATUS_OK
  BT_TRACE_SET_NAME_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTTraceSetNameStatus = enum :bt_trace_set_name_status,
    [ :BT_TRACE_SET_NAME_STATUS_OK,
       BT_TRACE_SET_NAME_STATUS_OK,
      :BT_TRACE_SET_NAME_STATUS_MEMORY_ERROR,
       BT_TRACE_SET_NAME_STATUS_MEMORY_ERROR ]

  attach_function :bt_trace_set_name,
                  [ :bt_trace_handle, :string ],
                  :bt_trace_set_name_status

  attach_function :bt_trace_set_uuid,
                  [ :bt_trace_handle, :bt_uuid ],
                  :void

  attach_function :bt_trace_get_uuid,
                  [ :bt_trace_handle ],
                  :bt_uuid

  BT_TRACE_SET_ENVIRONMENT_ENTRY_STATUS_OK = BT_FUNC_STATUS_OK
  BT_TRACE_SET_ENVIRONMENT_ENTRY_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTTraceSetEnvironmentEntryStatus = enum :bt_trace_set_environment_entry_status,
    [ :BT_TRACE_SET_ENVIRONMENT_ENTRY_STATUS_OK,
       BT_TRACE_SET_ENVIRONMENT_ENTRY_STATUS_OK,
      :BT_TRACE_SET_ENVIRONMENT_ENTRY_STATUS_MEMORY_ERROR,
       BT_TRACE_SET_ENVIRONMENT_ENTRY_STATUS_MEMORY_ERROR ]

  attach_function :bt_trace_set_environment_entry_integer,
                  [ :bt_trace_handle, :string, :int64 ],
                  :bt_trace_set_environment_entry_status

  attach_function :bt_trace_set_environment_entry_string,
                  [ :bt_trace_handle, :string, :string ],
                  :bt_trace_set_environment_entry_status

  attach_function :bt_trace_get_environment_entry_count,
                  [ :bt_trace_handle ],
                  :uint64

  attach_function :bt_trace_borrow_environment_entry_by_index_const,
                  [ :bt_trace_handle, :uint64, :pointer, :pointer ],
                  :void

  attach_function :bt_trace_borrow_environment_entry_value_by_name_const,
                  [ :bt_trace_handle, :string ],
                  :bt_value_handle

  attach_function :bt_trace_set_user_attributes,
                  [ :bt_trace_handle, :bt_value_map_handle ],
                  :void

  attach_function :bt_trace_borrow_user_attributes,
                  [ :bt_trace_handle ],
                  :bt_value_map_handle

  attach_function :bt_trace_borrow_user_attributes_const,
                  [ :bt_trace_handle ],
                  :bt_value_map_handle

  callback :bt_trace_destruction_listener_func,
           [ :bt_trace_handle, :pointer],
           :void

  def self._wrap_trace_destruction_listener_func(method)
    method_wrapper = lambda { |trace_class, user_data|
      begin
        method.call(BTTrace.new(trace_class), user_data)
      rescue => e
        puts e
      end
    }
    method_wrapper
  end

  BT_TRACE_ADD_LISTENER_STATUS_OK = BT_FUNC_STATUS_OK
  BT_TRACE_ADD_LISTENER_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTTraceAddListenerStatus = enum :bt_trace_add_listener_status,
    [ :BT_TRACE_ADD_LISTENER_STATUS_OK,
       BT_TRACE_ADD_LISTENER_STATUS_OK,
      :BT_TRACE_ADD_LISTENER_STATUS_MEMORY_ERROR,
       BT_TRACE_ADD_LISTENER_STATUS_MEMORY_ERROR ]

  attach_function :bt_trace_add_destruction_listener,
                  [ :bt_trace_handle, :bt_trace_destruction_listener_func,
                    :pointer, :bt_listener_id ],
                  :bt_trace_add_listener_status

  BT_TRACE_REMOVE_LISTENER_STATUS_OK = BT_FUNC_STATUS_OK
  BT_TRACE_REMOVE_LISTENER_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTTraceRemoveListenerStatus = enum :bt_trace_remove_listener_status,
    [ :BT_TRACE_REMOVE_LISTENER_STATUS_OK,
       BT_TRACE_REMOVE_LISTENER_STATUS_OK,
      :BT_TRACE_REMOVE_LISTENER_STATUS_MEMORY_ERROR,
       BT_TRACE_REMOVE_LISTENER_STATUS_MEMORY_ERROR ]

  attach_function :bt_trace_remove_destruction_listener,
                  [ :bt_trace_handle, :bt_listener_id ],
                  :bt_trace_remove_listener_status

  attach_function :bt_trace_get_ref,
                  [ :bt_trace_handle ],
                  :void

  attach_function :bt_trace_put_ref,
                  [ :bt_trace_handle ],
                  :void

  class BTTrace < BTSharedObject
    SetNameStatus = BTTraceSetNameStatus
    SetEnvironmentEntryStatus = BTTraceSetEnvironmentEntryStatus
    AddListenerStatus = BTTraceAddListenerStatus
    RemoveListenerStatus = BTTraceRemoveListenerStatus
    @get_ref = :bt_trace_class_get_ref
    @put_ref = :bt_trace_class_put_ref

    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil)
      if(handle)
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_trace_create(trace_class)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def get_class
      BTTraceClass.new(
        Babeltrace2.bt_trace_borrow_class(@handle))
    end

    def get_stream_count
      Babeltrace2.bt_trace_get_stream_count(@handle)
    end

    def get_stream_by_index(index)
      return nil if index >= get_stream_count
      BTStream.new(
        Babeltrace2.bt_trace_borrow_stream_by_index(@handle, index))
    end

    def get_stream_by_id(id)
      return nil if id >= get_stream_count
      BTStream.new(
        Babeltrace2.bt_trace_borrow_stream_by_id(@handle, id))
    end

    def set_name(name)
      res = Babeltrace2.bt_trace_set_name(@handle, name)
      raise Babeltrace2.process_error(res) if res != :BT_TRACE_SET_NAME_STATUS_OK
      self
    end

    def name=(name)
      set_name(name)
      name
    end

    def get_name
      Babeltrace2.bt_trace_get_name(@handle)
    end
    alias name get_name

    def set_uuid(uuid)
      Babeltrace2.bt_trace_set_uuid(@handle, uuid)
      self
    end

    def uuid=(uuid)
      set_uuid(uuid)
      uuid
    end

    def get_uuid
      uuid = Babeltrace2.bt_trace_get_uuid(@handle)
      return nil if uuid.null?
      uuid
    end
    alias uuid get_uuid

    def set_environment_entry_integer(name, value)
      res = Babeltrace2.bt_trace_set_environment_entry_integer(@handle, name, value)
      raise Babeltrace2.process_error(res) if res != :BT_TRACE_SET_ENVIRONMENT_ENTRY_STATUS_OK
      self
    end

    def set_environment_entry_string(name, value)
      res = Babeltrace2.bt_trace_set_environment_entry_string(@handle, name, value)
      raise Babeltrace2.process_error(res) if res != :BT_TRACE_SET_ENVIRONMENT_ENTRY_STATUS_OK
      self
    end

    def get_environment_entry_count
      Babeltrace2.bt_trace_get_environment_entry_count(@handle)
    end
    alias environment_entry_count get_environment_entry_count

    def get_environement_entry_by_index(index)
      return nil if index >= get_environment_entry_count
      ptr1 = FFI::MemoryPointer::new(:pointer)
      ptr2 = FFI::MemoryPointer::new(:pointer)
      Babeltrace2.bt_trace_borrow_environment_entry_by_index_const(
        @handle, index, ptr1, ptr2)
      name = ptr1.read_pointer.read_string
      value = BTValue.from_handle(BTValueHandle.new(ptr2.read_pointer))
      return [name, value]
    end

    def get_environment_entry_value_by_name(name)
      handle = Babeltrace2.bt_trace_borrow_environment_entry_value_by_name_const(
                 @handle, name)
      return nil if handle.null?
      BTValue.from_handle(handle)
    end

    def get_environment
      get_environment_entry_count.times.collect { |index|
        get_environement_entry_by_index(index)
      }.to_h
    end
    alias environment get_environment

    def set_environement(hash)
      hash.each { |k, v|
        case v
        when String
          set_environment_entry_string(k, v)
        when Integer
          set_environment_entry_integer(k, v)
        else
          raise "invalid value type"
        end
      }
      self
    end

    def environment=(hash)
      set_environement(hash)
      hash
    end

    def set_user_attributes(user_attributes)
      Babeltrace2.bt_trace_set_user_attributes(@handle, BTValue.from_value(user_attributes))
      self
    end

    def user_attributes=(user_attributes)
      set_user_attributes(user_attributes)
      user_attributes
    end

    def get_user_attributes
      BTValueMap.new(Babeltrace2.bt_trace_get_user_attributes(@handle))
    end
    alias user_attributes get_user_attributes

    def add_destruction_listener(user_func, user_data: nil)
      user_func = Babeltrace2._wrap_trace_destruction_listener_func(user_func)
      id = @handle.to_i
      ptr = FFI::MemoryPointer.new(:uint64)
      res = Babeltrace2.bt_trace_add_destruction_listener(@handle, user_func, ptr)
      raise Babeltrace2.process_error(res) if res != :BT_TRACE_ADD_LISTENER_STATUS_OK
      listener_id = ptr.read_uint64
      h = @@callbacks[id][:destruction_listener_funcs]
      if h.nil?
        h = {}
        @@callbacks[id][:destruction_listener_funcs] = h
      end
      h[listener_id] = user_func
      listener_id
    end

    def remove_destruction_listener(listener_id)
      res = Babeltrace2.bt_trace_remove_destruction_listener(@handle, listener_id)
      raise Babeltrace2.process_error(res) if res != :BT_TRACE_REMOVE_LISTENER_STATUS_OK
      @@callbacks[@handle.to_i][:destruction_listener_funcs].delete(listener_id)
      self
    end
  end
end
