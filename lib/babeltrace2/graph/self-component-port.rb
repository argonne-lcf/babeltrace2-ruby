module Babeltrace2

  attach_function :bt_self_component_port_borrow_component,
                  [ :bt_self_component_port_handle ],
                  :bt_self_component_handle

  attach_function :bt_self_component_port_get_data,
                  [ :bt_self_component_port_handle ],
                  :pointer

  module BTSelfComponent
    module Port
      def get_component
        handle = Babeltrace2.bt_self_component_port_borrow_component(@handle)
        BTSelfComponent.from_handle(handle)
      end
      alias component get_component

      def get_data
        Babeltrace2.bt_self_component_port_get_data(@handle)
      end
      alias data get_data
    end
  end

  class BTSelfComponent::Port::Input < BTPort::Input
    include BTSelfComponent::Port
  end
  BTSelfComponentPortInput = BTSelfComponent::Port::Input

  class BTSelfComponent::Port::Output < BTPort::Output
    include BTSelfComponent::Port
  end
  BTSelfComponentPortOutput = BTSelfComponent::Port::Output
end
