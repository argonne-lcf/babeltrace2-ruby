module Babeltrace2
  BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorCreateFromMessageIteratorStatus =
    enum :bt_message_iterator_create_from_message_iterator_status,
    [ :BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_OK,
       BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_OK,
      :BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_ERROR ]

  attach_function :bt_message_iterator_create_from_message_iterator,
                  [ :bt_self_message_iterator_handle,
                    :bt_self_component_port_input_handle,
                    :pointer ],
                  :bt_message_iterator_create_from_message_iterator_status

  BT_MESSAGE_ITERATOR_CREATE_FROM_SINK_COMPONENT_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_CREATE_FROM_SINK_COMPONENT_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_CREATE_FROM_SINK_COMPONENT_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorCreateFromSinkComponentStatus =
    enum :bt_message_iterator_create_from_sink_component_status,
    [ :BT_MESSAGE_ITERATOR_CREATE_FROM_SINK_COMPONENT_STATUS_OK,
       BT_MESSAGE_ITERATOR_CREATE_FROM_SINK_COMPONENT_STATUS_OK,
      :BT_MESSAGE_ITERATOR_CREATE_FROM_SINK_COMPONENT_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_CREATE_FROM_SINK_COMPONENT_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_ERROR ]

  attach_function :bt_message_iterator_create_from_sink_component,
                  [ :bt_self_component_sink_handle,
                    :bt_self_component_port_input_handle,
                    :pointer ],
                  :bt_message_iterator_create_from_sink_component_status

  attach_function :bt_message_iterator_borrow_component,
                  [ :bt_message_iterator_handle ],
                  :bt_component_handle

  BT_MESSAGE_ITERATOR_NEXT_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_NEXT_STATUS_END = BT_FUNC_STATUS_END
  BT_MESSAGE_ITERATOR_NEXT_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_MESSAGE_ITERATOR_NEXT_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_NEXT_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorNextStatus = enum :bt_message_iterator_next_status,
    [ :BT_MESSAGE_ITERATOR_NEXT_STATUS_OK,
       BT_MESSAGE_ITERATOR_NEXT_STATUS_OK,
      :BT_MESSAGE_ITERATOR_NEXT_STATUS_END,
       BT_MESSAGE_ITERATOR_NEXT_STATUS_END,
      :BT_MESSAGE_ITERATOR_NEXT_STATUS_AGAIN,
       BT_MESSAGE_ITERATOR_NEXT_STATUS_AGAIN,
      :BT_MESSAGE_ITERATOR_NEXT_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_NEXT_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_NEXT_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_NEXT_STATUS_ERROR ]

  attach_function :bt_message_iterator_next,
                  [ :bt_message_iterator_handle,
                    :pointer, :pointer ],
                  :bt_message_iterator_next_status

  BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorCanSeekBeginningStatus =
    enum :bt_message_iterator_can_seek_beginning_status,
    [ :BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_OK,
       BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_OK,
      :BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_AGAIN,
       BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_AGAIN,
      :BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_ERROR ]

  attach_function :bt_message_iterator_can_seek_beginning,
                  [ :bt_message_iterator_handle,
                    :pointer ],
                  :bt_message_iterator_can_seek_beginning_status

  BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorSeekBeginningStatus =
    enum :bt_message_iterator_seek_beginning_status,
    [ :BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_OK,
       BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_OK,
      :BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_AGAIN,
       BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_AGAIN,
      :BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_ERROR ]

  attach_function :bt_message_iterator_seek_beginning,
                  [ :bt_message_iterator_handle ],
                  :bt_message_iterator_seek_beginning_status

  BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorCanSeekNSFromOriginStatus =
    enum :bt_message_iterator_can_seek_ns_from_origin_status,
    [ :BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_OK,
       BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_OK,
      :BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_AGAIN,
       BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_AGAIN,
      :BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_ERROR ]

  attach_function :bt_message_iterator_can_seek_ns_from_origin,
                  [ :bt_message_iterator_handle,
                    :int64, :bool ],
                  :bt_message_iterator_can_seek_ns_from_origin_status

  BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_OK = BT_FUNC_STATUS_OK
  BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_AGAIN = BT_FUNC_STATUS_AGAIN
  BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTMessageIteratorSeekNSFromOriginStatus =
    enum :bt_message_iterator_seek_ns_from_origin_status,
    [ :BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_OK,
       BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_OK,
      :BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_AGAIN,
       BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_AGAIN,
      :BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_MEMORY_ERROR,
       BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_MEMORY_ERROR,
      :BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_ERROR,
       BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_ERROR ]

  attach_function :bt_message_iterator_seek_ns_from_origin,
                  [ :bt_message_iterator_handle,
                    :int64 ],
                  :bt_message_iterator_seek_ns_from_origin_status

  attach_function :bt_message_iterator_can_seek_forward,
                  [ :bt_message_iterator_handle ],
                  :bt_bool

  attach_function :bt_message_iterator_get_ref,
                  [ :bt_message_iterator_handle ],
                  :void

  attach_function :bt_message_iterator_put_ref,
                  [ :bt_message_iterator_handle ],
                  :void

  class BTMessageIterator < BTSharedObject
    CreateFromMessageIteratorStatus = BTMessageIteratorCreateFromMessageIteratorStatus
    CreateFromSinkComponentStatus = BTMessageIteratorCreateFromSinkComponentStatus
    NextStatus = BTMessageIteratorNextStatus
    CanSeekBeginningStatus = BTMessageIteratorCanSeekBeginningStatus
    SeekBeginningStatus = BTMessageIteratorSeekBeginningStatus
    CanSeekNSFromOriginStatus = BTMessageIteratorCanSeekNSFromOriginStatus
    @get_ref = :bt_message_iterator_get_ref
    @put_ref = :bt_message_iterator_put_ref

    def self.create_from_message_iterator(self_message_iterator, port)
      ptr = FFI::MemoryPointer::new(:pointer)
      res = Babeltrace2.bt_message_iterator_create_from_message_iterator(self_message_iterator, port, ptr)
      raise res if res != :BT_MESSAGE_ITERATOR_CREATE_FROM_MESSAGE_ITERATOR_STATUS_OK
      BTMessageIterator.new(ptr.read_pointer, retain: true, auto_release: true)
    end

    def create_message_iterator(port)
      BTMessageIterator.create_from_message_iterator(self, port)
    end

    def self.create_from_sink_component(self_component_sink, port)
      ptr = FFI::MemoryPointer::new(:pointer)
      res = Babeltrace2.bt_message_iterator_create_from_sink_component(self_component_sink, port, ptr)
      raise res if res != :BT_MESSAGE_ITERATOR_CREATE_FROM_SINK_COMPONENT_STATUS_OK
      BTMessageIterator.new(ptr.read_pointer, retain: true, auto_release: true)
    end

    def get_component
      handle = Babeltrace2.bt_message_iterator_borrow_component(@handle)
      BTComponent.from_handle(handle)
    end
    alias component get_component

    def next_messages
      ptr_messages = FFI::MemoryPointer::new(:pointer)
      ptr_count = FFI::MemoryPointer::new(:uint64)
      while ((res = Babeltrace2.bt_message_iterator_next(@handle, ptr_messages, ptr_count)) == :BT_MESSAGE_ITERATOR_NEXT_STATUS_AGAIN)
        sleep(0.1)
      end
      case res
      when :BT_MESSAGE_ITERATOR_NEXT_STATUS_OK
        count = ptr_count.read_uint64
        messages = ptr_messages.read_pointer
        return messages.read_array_of_pointer(count).collect { |h|
          BTMessages.from_handle(h, retain: false, auto_release: true)
        }
      when :BT_MESSAGE_ITERATOR_NEXT_STATUS_END
        raise StopIteration
      else
        raise res
      end
    end

    def can_seek_beginning
      ptr = FFI::MemoryPointer::new(:bt_bool)
      while ((res = Babeltrace2.bt_message_iterator_can_seek_beginning(@handle, ptr)) == :BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_AGAIN)
        sleep(0.1)
      end
      case res
      when :BT_MESSAGE_ITERATOR_CAN_SEEK_BEGINNING_STATUS_OK
        return ptr.read_int == BT_FALSE ? false : true
      else
        raise res
      end
    end
    alias can_seek_beginning? can_seek_beginning

    def seek_beginning
      raise "invalid operation" unless can_seek_beginning?
      while ((res = Babeltrace2.bt_message_iterator_seek_beginning(@handle)) == :BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_AGAIN)
        sleep(0.1)
      end
      case res
      when :BT_MESSAGE_ITERATOR_SEEK_BEGINNING_STATUS_OK
        return self
      else
        raise res
      end
    end

    def can_seek_ns_from_origin(ns)
      ptr = FFI::MemoryPointer::new(:bt_bool)
      while ((res = Babeltrace2.bt_message_iterator_can_seek_ns_from_origin(@handle, ns, ptr)) == :BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_AGAIN)
        sleep(0.1)
      end
      case res
      when :BT_MESSAGE_ITERATOR_CAN_SEEK_NS_FROM_ORIGIN_STATUS_OK
        return ptr.read_int == BT_FALSE ? false : true
      else
        raise res
      end
    end
    alias can_seek_ns_from_origin? can_seek_ns_from_origin

    def seek_ns_from_origin(ns)
      raise "invalid operation" unless can_seek_ns_from_origin(ns)
      while ((res = Babeltrace2.bt_message_iterator_seek_ns_from_origin@handle, ns) == :BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_AGAIN)
        sleep(0.1)
      end
      case res
      when :BT_MESSAGE_ITERATOR_SEEK_NS_FROM_ORIGIN_STATUS_OK
        return self
      else
        raise res
      end
    end

    def can_seek_forward
      Babeltrace2.bt_message_iterator_can_seek_forward(@handle) == BT_FALSE ? false : true
    end
    alias can_seek_forward? can_seek_forward
  end
end
