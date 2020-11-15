module Babeltrace2
  attach_function :bt_event_borrow_class,
                  [ :bt_event_handle ],
                  :bt_event_class_handle

  attach_function :bt_event_borrow_class_const,
                  [ :bt_event_handle ],
                  :bt_event_class_handle

  attach_function :bt_event_borrow_stream,
                  [ :bt_event_handle ],
                  :bt_stream_handle

  attach_function :bt_event_borrow_stream_const,
                  [ :bt_event_handle ],
                  :bt_stream_handle

  attach_function :bt_event_borrow_packet,
                  [ :bt_event_handle ],
                  :bt_packet_handle

  attach_function :bt_event_borrow_packet_const,
                  [ :bt_event_handle ],
                  :bt_packet_handle

  attach_function :bt_event_borrow_payload_field,
                  [ :bt_event_handle ],
                  :bt_field_handle

  attach_function :bt_event_borrow_payload_field_const,
                  [ :bt_event_handle ],
                  :bt_field_handle

  attach_function :bt_event_borrow_specific_context_field,
                  [ :bt_event_handle ],
                  :bt_field_handle

  attach_function :bt_event_borrow_specific_context_field_const,
                  [ :bt_event_handle ],
                  :bt_field_handle

  attach_function :bt_event_borrow_common_context_field,
                  [ :bt_event_handle ],
                  :bt_field_handle

  attach_function :bt_event_borrow_common_context_field_const,
                  [ :bt_event_handle ],
                  :bt_field_handle

  class BTEvent < BTObject
    def get_class
      handle = Babeltrace2.bt_event_borrow_class(@handle)
      BTEventClass.new(handle, retain: true)
    end

    def get_stream
      handle = Babeltrace2.bt_event_borrow_stream(@handle)
      BTStream.new(handle, retain: true)
    end
    alias stream get_stream

    def get_packet
      raise "packet not supported" unless stream.get_class.supports_packets?
      handle = Babeltrace2.bt_event_borrow_packet(@handle)
      BTPacket.new(handle, retain: true)
    end
    alias packet get_packet

    def get_event_borrow_payload_field
      handle = Babeltrace2.bt_event_borrow_payload_field(@handle)
      return nil if handle.null?
      BTField.from_handle(handle)
    end
    alias event_borrow_payload_field get_event_borrow_payload_field

    def get_specific_context_field
      handle = Babeltrace2.bt_event_borrow_specific_context_field(@handle)
      return nil if handle.null?
      BTField.from_handle(handle)
    end
    alias specific_context_field get_specific_context_field

    def get_common_context_field
      handle = Babeltrace2.bt_event_borrow_common_context_field(@handle)
      return nil if handle.null?
      BTField.from_handle(handle)
    end
    alias common_context_field get_common_context_field
  end

end
