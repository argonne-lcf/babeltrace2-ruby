module Babeltrace2

  attach_function :bt_self_message_iterator_borrow_component,
                  [ :bt_self_message_iterator_handle ],
                  :bt_self_component_handle

  attach_function :bt_self_message_iterator_borrow_port,
                  [ :bt_self_message_iterator_handle ],
                  :bt_self_component_port_output_handle

  attach_function :bt_self_message_iterator_set_data,
                  [ :bt_self_message_iterator_handle, :pointer ],
                  :void

  attach_function :bt_self_message_iterator_get_data,
                  [ :bt_self_message_iterator_handle ],
                  :pointer

  attach_function :bt_self_message_iterator_is_interrupted,
                  [ :bt_self_message_iterator_handle ],
                  :bt_bool

  class BTSelfMessageIterator < BTMessageIterator
    def get_component
      handle = Babeltrace2.bt_self_message_iterator_borrow_component(@handle)
      BTSelfComponent.from_handle(handle)
    end
    alias component get_component

    def get_port
      handle = Babeltrace2.bt_self_message_iterator_borrow_port(@handle)
      BTSelfComponentPortOutput.new(handle, retain: true)
    end
    alias port get_port

    def set_data(user_data)
      Babeltrace2.bt_self_message_iterator_set_data(@handle, user_data)
      self
    end

    def data=(user_data)
      Babeltrace2.bt_self_message_iterator_set_data(@handle, user_data)
      user_data
    end

    def get_data
      Babeltrace2.bt_self_message_iterator_get_data(@handle)
    end
    alias data get_data

    def is_interrupted
      Babeltrace2.bt_self_message_iterator_is_interrupted(@handle) != BT_FALSE
    end
    alias interrupted? is_interrupted
  end

  attach_function :bt_self_message_iterator_configuration_set_can_seek_forward,
                  [ :bt_self_message_iterator_configuration_handle, :bt_bool ],
                  :void

  class BTSelfMessageIterator
    class Configuration < BTObject
      def set_can_seek_forward(can_seek_forward)
        Babeltrace2.bt_self_message_iterator_configuration_set_can_seek_forward(
          @handle, can_seek_forward ? BT_TRUE : BT_FALSE)
        self
      end

      def can_seek_forward=(can_seek_forward)
        Babeltrace2.bt_self_message_iterator_configuration_set_can_seek_forward(
          @handle, can_seek_forward ? BT_TRUE : BT_FALSE)
        can_seek_forward
      end
    end
  end
  BTSelfMessageIteratorConfiguration = BTSelfMessageIterator::Configuration
end
