module Babeltrace2
  attach_function :bt_event_class_create,
                  [ :bt_stream_class_handle ],
                  :bt_event_class_handle

  attach_function :bt_event_class_create_with_id,
                  [ :bt_stream_class_handle, :uint64 ],
                  :bt_event_class_handle

  attach_function :bt_event_class_borrow_stream_class,
                  [ :bt_event_class_handle ],
                  :bt_stream_class_handle

  attach_function :bt_event_class_get_id,
                  [ :bt_event_class_handle ],
                  :uint64

  BT_EVENT_CLASS_SET_NAME_STATUS_OK = BT_FUNC_STATUS_OK
  BT_EVENT_CLASS_SET_NAME_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTEventClassSetNameStatus = enum :bt_event_class_set_name_status,
    [ :BT_EVENT_CLASS_SET_NAME_STATUS_OK,
       BT_EVENT_CLASS_SET_NAME_STATUS_OK,
      :BT_EVENT_CLASS_SET_NAME_STATUS_MEMORY_ERROR,
       BT_EVENT_CLASS_SET_NAME_STATUS_MEMORY_ERROR ]

  attach_function :bt_event_class_set_name,
                  [ :bt_event_class_handle, :string ],
                  :bt_event_class_set_name_status

  attach_function :bt_event_class_get_name,
                  [ :bt_event_class_handle ],
                  :string

  BT_EVENT_CLASS_LOG_LEVEL_EMERGENCY = 0
  BT_EVENT_CLASS_LOG_LEVEL_ALERT = 1
  BT_EVENT_CLASS_LOG_LEVEL_CRITICAL = 2
  BT_EVENT_CLASS_LOG_LEVEL_ERROR = 3
  BT_EVENT_CLASS_LOG_LEVEL_WARNING = 4
  BT_EVENT_CLASS_LOG_LEVEL_NOTICE = 5
  BT_EVENT_CLASS_LOG_LEVEL_INFO = 6
  BT_EVENT_CLASS_LOG_LEVEL_DEBUG_SYSTEM = 7
  BT_EVENT_CLASS_LOG_LEVEL_DEBUG_PROGRAM = 8
  BT_EVENT_CLASS_LOG_LEVEL_DEBUG_PROCESS = 9
  BT_EVENT_CLASS_LOG_LEVEL_DEBUG_MODULE = 10
  BT_EVENT_CLASS_LOG_LEVEL_DEBUG_UNIT = 11
  BT_EVENT_CLASS_LOG_LEVEL_DEBUG_FUNCTION = 12
  BT_EVENT_CLASS_LOG_LEVEL_DEBUG_LINE = 13
  BT_EVENT_CLASS_LOG_LEVEL_DEBUG = 14
  BTEventClassLogLevel = enum :bt_event_class_log_level,
    [ :BT_EVENT_CLASS_LOG_LEVEL_EMERGENCY,
       BT_EVENT_CLASS_LOG_LEVEL_EMERGENCY,
      :BT_EVENT_CLASS_LOG_LEVEL_ALERT,
       BT_EVENT_CLASS_LOG_LEVEL_ALERT,
      :BT_EVENT_CLASS_LOG_LEVEL_CRITICAL,
       BT_EVENT_CLASS_LOG_LEVEL_CRITICAL,
      :BT_EVENT_CLASS_LOG_LEVEL_ERROR,
       BT_EVENT_CLASS_LOG_LEVEL_ERROR,
      :BT_EVENT_CLASS_LOG_LEVEL_WARNING,
       BT_EVENT_CLASS_LOG_LEVEL_WARNING,
      :BT_EVENT_CLASS_LOG_LEVEL_NOTICE,
       BT_EVENT_CLASS_LOG_LEVEL_NOTICE,
      :BT_EVENT_CLASS_LOG_LEVEL_INFO,
       BT_EVENT_CLASS_LOG_LEVEL_INFO,
      :BT_EVENT_CLASS_LOG_LEVEL_DEBUG_SYSTEM,
       BT_EVENT_CLASS_LOG_LEVEL_DEBUG_SYSTEM,
      :BT_EVENT_CLASS_LOG_LEVEL_DEBUG_PROGRAM,
       BT_EVENT_CLASS_LOG_LEVEL_DEBUG_PROGRAM,
      :BT_EVENT_CLASS_LOG_LEVEL_DEBUG_PROCESS,
       BT_EVENT_CLASS_LOG_LEVEL_DEBUG_PROCESS,
      :BT_EVENT_CLASS_LOG_LEVEL_DEBUG_MODULE,
       BT_EVENT_CLASS_LOG_LEVEL_DEBUG_MODULE,
      :BT_EVENT_CLASS_LOG_LEVEL_DEBUG_UNIT,
       BT_EVENT_CLASS_LOG_LEVEL_DEBUG_UNIT,
      :BT_EVENT_CLASS_LOG_LEVEL_DEBUG_FUNCTION,
       BT_EVENT_CLASS_LOG_LEVEL_DEBUG_FUNCTION,
      :BT_EVENT_CLASS_LOG_LEVEL_DEBUG_LINE,
       BT_EVENT_CLASS_LOG_LEVEL_DEBUG_LINE,
      :BT_EVENT_CLASS_LOG_LEVEL_DEBUG,
       BT_EVENT_CLASS_LOG_LEVEL_DEBUG ]

  attach_function :bt_event_class_set_log_level,
                  [ :bt_event_class_handle, :bt_event_class_log_level ],
                  :void

  attach_function :bt_event_class_get_log_level,
                  [ :bt_event_class_handle, :pointer ],
                  :bt_property_availability

  BT_EVENT_CLASS_SET_EMF_URI_STATUS_OK = BT_FUNC_STATUS_OK
  BT_EVENT_CLASS_SET_EMF_URI_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTEventClassSetEmfUriStatus = enum :bt_event_class_set_emf_uri_status,
    [ :BT_EVENT_CLASS_SET_EMF_URI_STATUS_OK,
       BT_EVENT_CLASS_SET_EMF_URI_STATUS_OK,
      :BT_EVENT_CLASS_SET_EMF_URI_STATUS_MEMORY_ERROR,
       BT_EVENT_CLASS_SET_EMF_URI_STATUS_MEMORY_ERROR ]

  attach_function :bt_event_class_set_emf_uri,
                  [ :bt_event_class_handle, :string ],
                  :bt_event_class_set_emf_uri_status

  attach_function :bt_event_class_get_emf_uri,
                  [ :bt_event_class_handle ],
                  :string

  BT_EVENT_CLASS_SET_FIELD_CLASS_STATUS_OK = BT_FUNC_STATUS_OK
  BT_EVENT_CLASS_SET_FIELD_CLASS_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BTEventClassSetFieldClassStatus = enum :bt_event_class_set_field_class_status,
    [ :BT_EVENT_CLASS_SET_FIELD_CLASS_STATUS_OK,
       BT_EVENT_CLASS_SET_FIELD_CLASS_STATUS_OK,
      :BT_EVENT_CLASS_SET_FIELD_CLASS_STATUS_MEMORY_ERROR,
       BT_EVENT_CLASS_SET_FIELD_CLASS_STATUS_MEMORY_ERROR ]

  attach_function :bt_event_class_set_payload_field_class,
                  [ :bt_event_class_handle, :bt_field_class_handle ],
                  :bt_event_class_set_field_class_status

  attach_function :bt_event_class_borrow_payload_field_class,
                  [ :bt_event_class_handle ],
                  :bt_field_class_handle

  attach_function :bt_event_class_borrow_payload_field_class_const,
                  [ :bt_event_class_handle ],
                  :bt_field_class_handle

  attach_function :bt_event_class_set_specific_context_field_class,
                  [ :bt_event_class_handle, :bt_field_class_handle ],
                  :bt_event_class_set_field_class_status

  attach_function :bt_event_class_borrow_specific_context_field_class,
                  [ :bt_event_class_handle ],
                  :bt_field_class_handle

  attach_function :bt_event_class_borrow_specific_context_field_class_const,
                  [ :bt_event_class_handle ],
                  :bt_field_class_handle

  attach_function :bt_event_class_set_user_attributes,
                  [ :bt_event_class_handle, :bt_value_map_handle ],
                  :void

  attach_function :bt_event_class_borrow_user_attributes,
                  [ :bt_event_class_handle ],
                  :bt_value_map_handle

  attach_function :bt_event_class_borrow_user_attributes_const,
                  [ :bt_event_class_handle ],
                  :bt_value_map_handle

  attach_function :bt_event_class_get_ref,
                  [ :bt_event_class_handle ],
                  :void

  attach_function :bt_event_class_put_ref,
                  [ :bt_event_class_handle ],
                  :void

  class BTEventClass < BTSharedObject
    SetNameStatus = BTEventClassSetNameStatus
    LogLevel = BTEventClassLogLevel
    SetEmfUriStatus = BTEventClassSetEmfUriStatus
    SetFieldClassStatus = BTEventClassSetFieldClassStatus
    @get_ref = :bt_event_class_get_ref
    @put_ref = :bt_event_class_put_ref

    def initialize(handle = nil, retain: true, auto_release: true,
                   stream_class: nil, id: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = if id
            Babeltrace2.bt_event_class_create_with_id(stream_class, id)
          else
            Babeltrace2.bt_event_class_create(stream_class)
          end
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def get_stream_class
      handle = Babeltrace2.bt_event_class_borrow_stream_class(@handle)
      BTStreamClass.new(handle, retain: true)
    end
    alias stream_class get_stream_class

    def get_id
      Babeltrace2.bt_event_class_get_id(@handle)
    end
    alias id get_id

    def set_name(name)
      res = Babeltrace2.bt_event_class_set_name(@handle, name)
      raise Babeltrace2.process_error(res) if res != :BT_EVENT_CLASS_SET_NAME_STATUS_OK
      self
    end

    def name=(name)
      res = Babeltrace2.bt_event_class_set_name(@handle, name)
      raise Babeltrace2.process_error(res) if res != :BT_EVENT_CLASS_SET_NAME_STATUS_OK
      name
    end

    def get_name
      Babeltrace2.bt_event_class_get_name(@handle)
    end
    alias name get_name

    def set_log_level(log_level)
      Babeltrace2.bt_event_class_set_log_level(@handle, log_level)
      self
    end

    def log_level=(log_level)
      Babeltrace2.bt_event_class_set_log_level(@handle, log_level)
      log_level
    end

    def get_log_level
      ptr = MemoryPointer::new(:int)
      res = Babeltrace2.bt_event_class_get_log_level(@handle, ptr)
      return nil if res == :BT_PROPERTY_AVAILABILITY_NOT_AVAILABLE
      BTEventClassLogLevel.from_native(ptr.read_int, nil)
    end
    alias log_level get_log_level

    def set_emf_uri(emf_uri)
      res = Babeltrace2.bt_event_class_set_emf_uri(@handle, emf_uri)
      raise Babeltrace2.process_error(res) if res != :BT_EVENT_CLASS_SET_EMF_URI_STATUS_OK
      self
    end

    def emf_uri=(emf_uri)
      res = Babeltrace2.bt_event_class_set_emf_uri(@handle, emf_uri)
      raise Babeltrace2.process_error(res) if res != :BT_EVENT_CLASS_SET_EMF_URI_STATUS_OK
      emf_uri
    end

    def get_emf_uri
      Babeltrace2.bt_event_class_get_emf_uri
    end
    alias emf_uri get_emf_uri

    def set_payload_field_class(field_class)
      res = Babeltrace2.bt_event_class_set_payload_field_class(@handle, field_class)
      raise Babeltrace2.process_error(res) if res != :BT_EVENT_CLASS_SET_FIELD_CLASS_STATUS_OK
      self
    end

    def payload_field_class=(field_class)
      res = Babeltrace2.bt_event_class_set_payload_field_class(@handle, field_class)
      raise Babeltrace2.process_error(res) if res != :BT_EVENT_CLASS_SET_FIELD_CLASS_STATUS_OK
      field_class
    end

    def get_payload_field_class
      handle = Babeltrace2.bt_event_class_borrow_payload_field_class(@handle)
      return nil if handle.null?
      BTFieldClass.from_handle(handle)
    end
    alias payload_field_class get_payload_field_class

    def set_specific_context_field_class(field_class)
      res = Babeltrace2.bt_event_class_set_specific_context_field_class(@handle, field_class)
      raise Babeltrace2.process_error(res) if res != :BT_EVENT_CLASS_SET_FIELD_CLASS_STATUS_OK
      self
    end

    def specific_context_field_class=(field_class)
      res = Babeltrace2.bt_event_class_set_specific_context_field_class(@handle, field_class)
      raise Babeltrace2.process_error(res) if res != :BT_EVENT_CLASS_SET_FIELD_CLASS_STATUS_OK
      field_class
    end

    def get_specific_context_field_class
      handle = Babeltrace2.bt_event_class_borrow_specific_context_field_class(@handle)
      return nil if handle.null?
      BTFieldClass.from_handle(handle)
    end
    alias specific_context_field_class get_specific_context_field_class

    def set_user_attributes(user_attributes)
      Babeltrace2.bt_event_class_set_user_attributes(@handle, BTValue.from_value(user_attributes))
      self
    end

    def user_attributes=(user_attributes)
      Babeltrace2.bt_event_class_set_user_attributes(@handle, BTValue.from_value(user_attributes))
      user_attributes
    end

    def get_user_attributes
      BTValueMap.new(Babeltrace2.bt_event_class_borrow_user_attributes(@handle), retain: true)
    end
    alias user_attributes get_user_attributes
  end
end
