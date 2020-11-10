module Babeltrace2

  BT_PORT_TYPE_INPUT = 1 << 0
  BT_PORT_TYPE_OUTPUT = 1 << 1
  BTPortType = enum :bt_port_type,
    [ :BT_PORT_TYPE_INPUT,
       BT_PORT_TYPE_INPUT,
      :BT_PORT_TYPE_OUTPUT,
       BT_PORT_TYPE_OUTPUT ]

  attach_function :bt_port_get_type,
                  [ :bt_port_handle ],
                  :bt_port_type

  attach_function :bt_port_borrow_connection_const,
                  [ :bt_port_handle ],
                  :bt_connection_handle

  attach_function :bt_port_borrow_component_const,
                  [ :bt_port_handle ],
                  :bt_component_handle

  attach_function :bt_port_get_name,
                  [ :bt_port_handle ],
                  :string

  attach_function :bt_port_is_connected,
                  [ :bt_port_handle ],
                  :bt_bool

  attach_function :bt_port_get_ref,
                  [ :bt_port_handle ],
                  :void

  attach_function :bt_port_put_ref,
                  [ :bt_port_handle ],
                  :void

  class BTPort < BTSharedObject
    Type = BTPortType
    @get_ref = :bt_port_get_ref
    @put_ref = :bt_port_put_ref

    def self.from_handle(handle, retain: true, auto_release: true)
      case Babeltrace2.bt_port_get_type(handle)
      when :BT_PORT_TYPE_INPUT
        Input
      when :BT_PORT_TYPE_OUTPUT
        Output
      else
        raise Error.new("Unknown port type")
      end.new(handle, retain: retain, auto_release: auto_release)
    end

    def get_type
      Babeltrace2.bt_port_get_type(@handle)
    end
    alias type get_type

    def is_input
      get_type == :BT_PORT_TYPE_INPUT
    end
    alias input? is_input

    def is_output
      get_type == :BT_PORT_TYPE_OUTPUT
    end
    alias output? is_output

    def get_connection
      handle = Babeltrace2.bt_port_borrow_connection_const(@handle)
      return nil if handle.null?
      BTConnection.new(handle, retain: true, auto_release: true)
    end
    alias connection get_connection

    def get_component
      handle = Babeltrace2.bt_port_borrow_component_const(@handle)
      BTComponent.from_handle(handle)
    end
    alias component get_component

    def get_name
      Babeltrace2.bt_port_get_name(@handle)
    end
    alias name get_name

    def is_connected
      Babeltrace2.bt_port_is_connected(@handle) == BT_FALSE ? false : true
    end
    alias connected? is_connected
  end

  attach_function :bt_port_input_get_ref,
                  [ :bt_port_input_handle ],
                  :void

  attach_function :bt_port_input_put_ref,
                  [ :bt_port_input_handle ],
                  :void

  class BTPort::Input < BTPort
    @get_ref = :bt_port_input_get_ref
    @put_ref = :bt_port_input_put_ref
  end
  BTPortInput = BTPort::Input

  attach_function :bt_port_output_get_ref,
                  [ :bt_port_output_handle ],
                  :void

  attach_function :bt_port_output_put_ref,
                  [ :bt_port_output_handle ],
                  :void

  class BTPort::Output < BTPort
    @get_ref = :bt_port_output_get_ref
    @put_ref = :bt_port_output_put_ref
  end
  BTPortOutput = BTPort::Output

end
