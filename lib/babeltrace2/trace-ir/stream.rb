module Babeltrace2

  attach_function :bt_stream_create,
                  [ :bt_stream_class_handle, :bt_trace_handle ],
                  :bt_stream_handle

  attach_function :bt_stream_create_with_id,
                  [ :bt_stream_class_handle, :bt_trace_handle, :uint64 ],
                  :bt_stream_handle

  attach_function :bt_stream_borrow_class,
                  [ :bt_stream_class_handle ],
                  :bt_stream_class_handle

  attach_function :bt_stream_borrow_class_const,
                  [ :bt_stream_class_handle ],
                  :bt_stream_class_handle

  attach_function :bt_stream_borrow_trace,
                  [ :bt_stream_class_handle ],
                  :bt_trace_handle

  attach_function :bt_stream_borrow_trace_const,
                  [ :bt_stream_class_handle ],
                  :bt_trace_handle

  attach_function :bt_stream_get_id,
                  [ :bt_stream_class_handle ],
                  :uint64

  BT_STREAM_SET_NAME_STATUS_OK = BT_FUNC_STATUS_OK
  BT_STREAM_SET_NAME_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTStreamSetNameStatus =
    enum :bt_stream_set_name_status,
    [ :BT_STREAM_SET_NAME_STATUS_OK,
       BT_STREAM_SET_NAME_STATUS_OK,
      :BT_STREAM_SET_NAME_STATUS_MEMORY_ERROR,
       BT_STREAM_SET_NAME_STATUS_MEMORY_ERROR ]

  attach_function :bt_stream_set_name,
                  [ :bt_stream_handle, :string ],
                  :bt_stream_set_name_status

  attach_function :bt_stream_get_name,
                  [ :bt_stream_handle ],
                  :string

  attach_function :bt_stream_set_user_attributes,
                  [ :bt_stream_handle, :bt_value_map_handle ],
                  :void

  attach_function :bt_stream_borrow_user_attributes,
                  [ :bt_stream_handle ],
                  :bt_value_map_handle

  attach_function :bt_stream_borrow_user_attributes_const,
                  [ :bt_stream_handle ],
                  :bt_value_map_handle

  attach_function :bt_stream_get_ref,
                  [ :bt_stream_handle ],
                  :void

  attach_function :bt_stream_put_ref,
                  [ :bt_stream_handle ],
                  :void

  class BTStream < BTSharedObject
    SetNameStatus = BTStreamSetNameStatus
    @get_ref = :bt_stream_get_ref
    @put_ref = :bt_stream_put_ref

    def initialize(handle = nil, retain: true, auto_release: true,
                   stream_class: nil, trace: nil, id: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = if id
            Babeltrace2.bt_stream_create_with_id(stream_class, trace, id)
          else
            Babeltrace2.bt_stream_create(stream_class, trace)
          end
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def get_class
      BTStreamClass.new(Babeltrace2.bt_stream_borrow_class(@handle), retain: true)
    end

    def get_trace
      BTTrace.new(Babeltrace2.bt_stream_borrow_trace(@handle), retain: true)
    end
    alias trace get_trace

    def get_id
      Babeltrace2.bt_stream_get_id(@handle)
    end
    alias id get_id

    def set_name(name)
      res = Babeltrace2.bt_stream_set_name(@handle, name)
      raise Babeltrace2.process_error(res) if res != :BT_STREAM_SET_NAME_STATUS_OK
      self
    end

    def name=(name)
      set_name(name)
      name
    end

    def get_name
      Babeltrace2.bt_stream_get_name(@handle)
    end
    alias name get_name

    def set_user_attributes(user_attributes)
      Babeltrace2.bt_stream_set_user_attributes(@handle, BTValue.from_value(user_attributes))
      self
    end

    def user_attributes=(user_attributes)
      set_user_attributes(user_attributes)
      user_attributes
    end

    def get_user_attributes
      BTValueMap.new(Babeltrace2.bt_stream_borrow_user_attributes(@handle), retain: true)
    end
    alias user_attributes get_user_attributes
  end
end
