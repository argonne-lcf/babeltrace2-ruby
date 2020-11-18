module Babeltrace2
  attach_function :bt_packet_create,
                  [ :bt_stream_handle ],
                  :bt_packet_handle

  attach_function :bt_packet_borrow_stream,
                  [ :bt_packet_handle ],
                  :bt_stream_handle

  attach_function :bt_packet_borrow_stream_const,
                  [ :bt_packet_handle ],
                  :bt_stream_handle

  attach_function :bt_packet_borrow_context_field,
                  [ :bt_packet_handle ],
                  :bt_field_handle

  attach_function :bt_packet_borrow_context_field_const,
                  [ :bt_packet_handle ],
                  :bt_field_handle

  attach_function :bt_packet_get_ref,
                  [ :bt_packet_handle ],
                  :void

  attach_function :bt_packet_put_ref,
                  [ :bt_packet_handle ],
                  :void

  class BTPacket < BTSharedObject
    @get_ref = :bt_packet_get_ref
    @put_ref = :bt_packet_put_ref

    def initialize(handle = nil, retain: true, auto_release: true,
                   stream: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_packet_create(stream)
        raise Babeltrace2.process_error if handle.null?
        super(handle)
      end
    end

    def get_stream
      BTStream.new(Babeltrace2.bt_packet_borrow_stream(@handle))
    end
    alias stream get_stream

    def get_context_field
      handle = Babeltrace2.bt_packet_borrow_context_field(@handle)
      return nil if handle.null?
      BTField.from_handle(handle)
    end
    alias context_field get_context_field
  end
end
