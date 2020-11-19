module Babeltrace2

  attach_function :bt_connection_borrow_downstream_port_const,
                  [ :bt_connection_handle ],
                  :bt_port_input_handle

  attach_function :bt_connection_borrow_upstream_port_const,
                  [ :bt_connection_handle ],
                  :bt_port_output_handle

  attach_function :bt_connection_get_ref,
                  [ :bt_connection_handle ],
                  :void

  attach_function :bt_connection_put_ref,
                  [ :bt_connection_handle ],
                  :void

  class BTConnection < BTSharedObject
    @get_ref = :bt_connection_get_ref
    @put_ref = :bt_connection_put_ref

    def get_downstream_port
      handle = Babeltrace2.bt_connection_borrow_downstream_port_const(@handle)
      BTPortInput.new(handle, retain: true)
    end
    alias downstream_port get_downstream_port

    def get_upstream_port
      handle = Babeltrace2.bt_connection_borrow_upstream_port_const(@handle)
      BTPortOutput.new(handle, retain: true)
    end
    alias upstream_port get_upstream_port

    def ==(other)
      @handle == other.handle
    end
  end
end
