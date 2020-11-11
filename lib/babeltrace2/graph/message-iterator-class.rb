module Babeltrace2
  BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_ERROR = BT_FUNC_STATUS_ERROR

  BTMessageIteratorClassCanSeekBeginningMethodStatus =
    enum :bt_message_iterator_class_can_seek_beginning_method_status,
    [ :BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_OK,
       BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_OK,
      :BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_AGAIN,
       BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_AGAIN,
      :BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_ERROR ]

  callback :bt_message_iterator_class_can_seek_beginning_method,
           [ :bt_self_message_iterator_handle,
             :pointer ],
           :bt_message_iterator_class_can_seek_beginning_method_status

  def self._wrap_message_iterator_class_can_seek_beginning_method(handle, method)
    id = handle.to_i
    method_wrapper = lambda { |self_message_iterator, can_seek_beginning|
      res, csb = method.call(BTSelfMessageIterator.new(self_message_iterator, retain: true))
      if res == :BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_OK
        can_seek_beginning.write_int(csb ? BT_TRUE : BT_FALSE)
      end
      res
    }
    @@callbacks[id][:can_seek_beginning_method] = method_wrapper
    method_wrapper
  end

  BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorClassCanSeekNSFromOriginMethodStatus =
    enum :bt_message_iterator_class_can_seek_ns_from_origin_method_status,
    [ :BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_OK,
       BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_OK,
      :BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_AGAIN,
       BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_AGAIN,
      :BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_ERROR ]

  callback :bt_message_iterator_class_can_seek_ns_from_origin_method,
           [ :bt_self_message_iterator_handle,
             :int64, :pointer ],
           :bt_message_iterator_class_can_seek_ns_from_origin_method_status

  def self._wrap_message_iterator_class_can_seek_ns_from_origin_method(handle, method)
    id = handle.to_i
    method_wrapper = lambda { |self_message_iterator, ns_from_origin, can_seek_beginning|
      res, csb = method.call(BTSelfMessageIterator.new(self_message_iterator, retain: true), ns_from_origin)
      if res == :BT_MESSAGE_ITERATOR_CLASS_CAN_SEEK_BEGINNING_METHOD_STATUS_OK
        can_seek_beginning.write_int(csb ? BT_TRUE : BT_FALSE)
      end
      res
    }
    @@callbacks[id][:can_seek_ns_from_origin_method] = method_wrapper
    method_wrapper
  end

  callback :bt_message_iterator_class_finalize_method,
           [ :bt_self_message_iterator_handle ],
           :void

  def self._wrap_message_iterator_class_finalize_method(handle, method)
    id = handle.to_i
    method_wrapper = lambda { |self_message_iterator|
      method.call(BTSelfMessageIterator.new(self_message_iterator, retain: true))
    }
    @@callbacks[id][:finalize_method] = method_wrapper
    method_wrapper
  end

  BT_MESSAGE_ITERATOR_CLASS_INITIALIZE_METHOD_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_CLASS_INITIALIZE_METHOD_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_CLASS_INITIALIZE_METHOD_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorClassInitializeMethodStatus =
    enum :bt_message_iterator_class_initialize_method_status,
    [ :BT_MESSAGE_ITERATOR_CLASS_INITIALIZE_METHOD_STATUS_OK,
       BT_MESSAGE_ITERATOR_CLASS_INITIALIZE_METHOD_STATUS_OK,
      :BT_MESSAGE_ITERATOR_CLASS_INITIALIZE_METHOD_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_INITIALIZE_METHOD_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_CLASS_INITIALIZE_METHOD_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_INITIALIZE_METHOD_STATUS_ERROR ]

  callback :bt_message_iterator_class_initialize_method,
           [ :bt_self_message_iterator_handle,
             :bt_self_message_iterator_configuration_handle,
             :bt_self_component_port_output_handle ],
           :bt_message_iterator_class_initialize_method_status

  def self._wrap_message_iterator_class_initialize_method(handle, method)
    id = handle.to_i
    method_wrapper = lambda { |self_message_iterator, configuration, port|
      method.call(BTSelfMessageIterator.new(self_message_iterator, retain: true),
                  BTSelfMessageIteratorConfiguration.new(configuration),
                  BTSelfComponentPortOutput.new(port))
    }
    @@callbacks[id][:initialize_method] = method_wrapper
    method_wrapper
  end

  BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_END = BT_FUNC_STATUS_END
  BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorClassNextMethodStatus =
    enum :bt_message_iterator_class_next_method_status,
    [ :BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_OK,
       BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_OK,
      :BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_END,
       BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_END,
      :BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_AGAIN,
       BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_AGAIN,
      :BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_ERROR ]

  callback :bt_message_iterator_class_next_method,
           [ :bt_self_message_iterator_handle,
             :bt_message_array_const,
             :uint64, :pointer ],
           :pointer

  def self._wrap_message_iterator_class_next_method(method)
    lambda { |self_message_iterator, messages, capacity, count|
      res, mess, cnt = method.call(BTSelfMessageIterator.new(self_message_iterator, retain: true),
                                   capacity)
      if res == :BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_OK
        if mess.size < capacity
          mess.each { |m| bt_message_get_ref(m) }
          messages.write_array_of_pointer(mess.collect(&:to_ptr))
          count.write_uint64(cnt)
        else
          res = :BT_MESSAGE_ITERATOR_CLASS_NEXT_METHOD_STATUS_ERROR
        end
      end
      res
    }
  end

  BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorClassSeekBeginningMethodStatus =
    enum :bt_message_iterator_class_seek_beginning_method_status,
    [ :BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_OK,
       BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_OK,
      :BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_AGAIN,
       BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_AGAIN,
      :BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_SEEK_BEGINNING_METHOD_STATUS_ERROR ]

  callback :bt_message_iterator_class_seek_beginning_method,
           [ :bt_self_message_iterator_handle ],
           :bt_message_iterator_class_seek_beginning_method_status

  def self._wrap_message_iterator_class_seek_beginning_method(handle, method)
    id = handle.to_i
    method_wrapper = lambda { |self_message_iterator|
      method.call(BTSelfMessageIterator.new(self_message_iterator, retain: true))
    }
    @@callbacks[id][:seek_beginning_method] = method_wrapper
    method_wrapper
  end

  BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorClassSeekNSFromOriginMethodStatus =
    enum :bt_message_iterator_class_seek_ns_from_origin_method_status,
    [ :BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_OK,
       BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_OK,
      :BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_AGAIN,
       BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_AGAIN,
      :BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_CLASS_SEEK_NS_FROM_ORIGIN_METHOD_STATUS_ERROR ]

  callback :bt_message_iterator_class_seek_ns_from_origin_method,
           [ :bt_self_message_iterator_handle,
             :int64 ],
           :bt_message_iterator_class_seek_ns_from_origin_method_status

  def self._wrap_message_iterator_class_seek_ns_from_origin_method(handle, method)
    id = handle.to_i
    method_wrapper = lambda { |self_message_iterator, ns_from_origin|
      method.call(BTSelfMessageIterator.new(self_message_iterator, retain: true), ns_from_origin)
    }
    @@callbacks[id][:seek_ns_from_origin_method] = method_wrapper
    method_wrapper
  end

  attach_function :bt_message_iterator_class_create,
                  [ :bt_message_iterator_class_next_method ],
                  :bt_message_iterator_class_handle

  BT_MESSAGE_ITERATOR_CLASS_SET_METHOD_STATUS_OK = BT_FUNC_STATUS_OK
  BTMessageIteratorClassSetMethodStatus =
    enum :bt_message_iterator_class_set_method_status,
    [ :BT_MESSAGE_ITERATOR_CLASS_SET_METHOD_STATUS_OK,
       BT_MESSAGE_ITERATOR_CLASS_SET_METHOD_STATUS_OK ]

  attach_function :bt_message_iterator_class_set_finalize_method,
                  [ :bt_message_iterator_class_handle,
                    :bt_message_iterator_class_finalize_method ],
                  :bt_message_iterator_class_set_method_status

  attach_function :bt_message_iterator_class_set_initialize_method,
                  [ :bt_message_iterator_class_handle,
                    :bt_message_iterator_class_initialize_method ],
                  :bt_message_iterator_class_set_method_status

  attach_function :bt_message_iterator_class_set_seek_beginning_methods,
                  [ :bt_message_iterator_class_handle,
                    :bt_message_iterator_class_seek_beginning_method,
                    :bt_message_iterator_class_can_seek_beginning_method ],
                  :bt_message_iterator_class_set_method_status

  attach_function :bt_message_iterator_class_set_seek_ns_from_origin_methods,
                  [ :bt_message_iterator_class_handle,
                    :bt_message_iterator_class_seek_ns_from_origin_method,
                    :bt_message_iterator_class_can_seek_ns_from_origin_method ],
                  :bt_message_iterator_class_set_method_status

  attach_function :bt_message_iterator_class_get_ref,
                  [ :bt_message_iterator_class_handle],
                  :void

  attach_function :bt_message_iterator_class_put_ref,
                  [ :bt_message_iterator_class_handle],
                  :void

  class BTMessageIteratorClass < BTSharedObject
    CanSeekBeginningMethodStatus = BTMessageIteratorClassCanSeekBeginningMethodStatus
    CanSeekNSFromOriginMethodStatus = BTMessageIteratorClassCanSeekNSFromOriginMethodStatus
    InitializeMethodStatus = BTMessageIteratorClassInitializeMethodStatus
    NextMethodStatus = BTMessageIteratorClassNextMethodStatus
    SeekBeginningMethodStatus = BTMessageIteratorClassSeekBeginningMethodStatus
    SeekNSFromOriginMethodStatus = BTMessageIteratorClassSeekNSFromOriginMethodStatus
    SetMethodStatus = BTMessageIteratorClassSetMethodStatus
    @get_ref = :bt_message_iterator_class_get_ref
    @put_ref = :bt_message_iterator_class_put_ref

    def initialize(handle = nil, retain: true, auto_release: true,
                   next_method: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        raise ArgumentError, "invalid value for next_method" unless next_method
        next_method = Babeltrace2._wrap_message_iterator_class_next_method(next_method)
        handle = Babeltrace2.bt_message_iterator_class_create(next_method)
        raise :BT_FUNC_STATUS_MEMORY_ERROR if handle.null?
        Babeltrace2._callbacks[handle.to_i][:next_method] = next_method
        super(handle, retain: false)
      end
    end

    def set_finalize_method(method)
      method = Babeltrace2._wrap_message_iterator_class_finalize_method(@handle, method)
      res = Babeltrace2.bt_message_iterator_class_set_finalize_method(@handle, method)
      raise res if res != :BT_MESSAGE_ITERATOR_CLASS_SET_METHOD_STATUS_OK
      self
    end

    def finalize_method=(method)
      set_finalize_method(method)
      method
    end

    def set_initialize_method(method)
      method = Babeltrace2._wrap_message_iterator_class_initialize_method(@handle, method)
      res = Babeltrace2.bt_message_iterator_class_set_initialize_method(@handle, method)
      raise res if res != :BT_MESSAGE_ITERATOR_CLASS_SET_METHOD_STATUS_OK
      self
    end

    def initialize_method=(method)
      set_initialize_method(method)
      method
    end

    def set_seek_beginning_methods(seek_method, can_seek_method: nil)
      seek_method = Babeltrace2._wrap_message_iterator_class_seek_beginning_method(seek_method)
      can_seek_method = Babeltrace2._wrap_message_iterator_class_can_seek_beginning_method(can_seek_method)
      res = Babeltrace2.bt_message_iterator_class_set_seek_beginning_methods(
        @handle, seek_method, can_seek_method)
      raise res if res != :BT_MESSAGE_ITERATOR_CLASS_SET_METHOD_STATUS_OK
      self
    end

    def seek_beginning_method=(seek_method)
      set_seek_beginning_methods(seek_method)
      seek_method
    end

    def set_seek_ns_from_origin_methods(seek_method, can_seek_method: nil)
      seek_method = Babeltrace2._wrap_message_iterator_class_seek_ns_from_origin_method(seek_method)
      can_seek_method = Babeltrace2._wrap_message_iterator_class_can_seek_ns_from_origin_method(can_seek_method)
      res = Babeltrace2.bt_message_iterator_class_set_seek_ns_from_origin_methods(
        @handle, seek_method, can_seek_method)
      raise res if res != :BT_MESSAGE_ITERATOR_CLASS_SET_METHOD_STATUS_OK
      self
    end

    def seek_ns_from_origin_method=(seek_method)
      set_seek_ns_from_origin_methods(seek_method)
      seek_method
    end
  end
end
