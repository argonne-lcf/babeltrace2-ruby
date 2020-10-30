module Babeltrace2

  attach_function :bt_graph_get_ref,
                  [:bt_graph_handle],
                  :void
  attach_function :bt_graph_put_ref,
                  [:bt_graph_handle],
                  :void
  attach_function :bt_graph_create,
                  [:uint64],
                  :bt_graph_handle

  BTGraphAddComponentStatus = enum :bt_graph_add_component_status,
    [ :BT_GRAPH_ADD_COMPONENT_STATUS_OK, BT_FUNC_STATUS_OK,
      :BT_GRAPH_ADD_COMPONENT_STATUS_MEMORY_ERROR, BT_FUNC_STATUS_MEMORY_ERROR,
      :BT_GRAPH_ADD_COMPONENT_STATUS_ERROR, BT_FUNC_STATUS_ERROR ]

  class BTGraph < BTRefCountedObject
    @get_ref = :bt_graph_get_ref
    @put_ref = :bt_graph_put_ref

    def initialize(handle = nil, mip_version: 0)
      if handle
        super(handle, retain: true)
      else
        handle = Babeltrace2.bt_graph_create(mip_version)
        raise :BT_GRAPH_ADD_COMPONENT_STATUS_MEMORY_ERROR if handle.null?
        super(handle)
      end
    end

  end 
end

