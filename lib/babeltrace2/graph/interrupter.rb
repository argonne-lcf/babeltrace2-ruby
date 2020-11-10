module Babeltrace2

  attach_function :bt_interrupter_create,
                  [],
                  :bt_interrupter_handle

  attach_function :bt_interrupter_set,
                  [ :bt_interrupter_handle ],
                  :void

  attach_function :bt_interrupter_reset,
                  [ :bt_interrupter_handle ],
                  :void

  attach_function :bt_interrupter_is_set,
                  [ :bt_interrupter_handle ],
                  :bt_bool

  attach_function :bt_interrupter_get_ref,
                  [ :bt_interrupter_handle ],
                  :void

  attach_function :bt_interrupter_put_ref,
                  [ :bt_interrupter_handle ],
                  :void

  class BTInterrupter < BTSharedObject
    @get_ref = :bt_interrupter_get_ref
    @put_ref = :bt_interrupter_put_ref

    def initialize(handle = nil, retain: true, auto_release: true)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        handle = Babeltrace2.bt_interrupter_create()
        raise :BT_FUNC_STATUS_MEMORY_ERROR if handle.null?
        super(handle)
      end
    end

    def set
      Babeltrace2.bt_interrupter_set(@handle)
    end

    def reset
      Babeltrace2.bt_interrupter_reset(@handle)
    end

    def is_set
      Babeltrace2.bt_interrupter_is_set(@handle) == BT_FALSE ? false : true
    end
    alias set? is_set
  end

end
