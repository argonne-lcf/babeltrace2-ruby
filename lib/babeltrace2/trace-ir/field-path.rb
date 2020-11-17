module Babeltrace2
  BT_FIELD_PATH_SCOPE_PACKET_CONTEXT = 0
  BT_FIELD_PATH_SCOPE_EVENT_COMMON_CONTEXT = 1
  BT_FIELD_PATH_SCOPE_EVENT_SPECIFIC_CONTEXT = 2
  BT_FIELD_PATH_SCOPE_EVENT_PAYLOAD = 3
  BTFieldPathScope = enum :bt_field_path_scope,
    [ :BT_FIELD_PATH_SCOPE_PACKET_CONTEXT,
       BT_FIELD_PATH_SCOPE_PACKET_CONTEXT,
      :BT_FIELD_PATH_SCOPE_EVENT_COMMON_CONTEXT,
       BT_FIELD_PATH_SCOPE_EVENT_COMMON_CONTEXT,
      :BT_FIELD_PATH_SCOPE_EVENT_SPECIFIC_CONTEXT,
       BT_FIELD_PATH_SCOPE_EVENT_SPECIFIC_CONTEXT,
      :BT_FIELD_PATH_SCOPE_EVENT_PAYLOAD,
       BT_FIELD_PATH_SCOPE_EVENT_PAYLOAD ]

  attach_function :bt_field_path_get_root_scope,
                  [ :bt_field_path_handle ],
                  :bt_field_path_scope

  attach_function :bt_field_path_get_item_count,
                  [ :bt_field_path_handle ],
                  :uint64

  attach_function :bt_field_path_borrow_item_by_index_const,
                  [ :bt_field_path_handle, :uint64 ],
                  :bt_field_path_item_handle

  attach_function :bt_field_path_get_ref,
                  [ :bt_field_path_handle ],
                  :void

  attach_function :bt_field_path_put_ref,
                  [ :bt_field_path_handle ],
                  :void

  class BTFieldPath < BTSharedObject
    Scope = BTFieldPathScope
    @get_ref = :bt_field_path_get_ref
    @put_ref = :bt_field_path_put_ref
    def initialize(handle, retain: true, auto_release: true)
      super(handle, retain: retain, auto_release: auto_release)
    end

    def get_root_scope
      Babeltrace2.bt_field_path_get_root_scope(@handle)
    end
    alias root_scope get_root_scope

    def get_item_count
      Babeltrace2.bt_field_path_get_item_count(@handle)
    end
    alias item_count get_item_count
    alias size get_item_count

    def get_item_by_index(index)
      return nil if index >= get_item_count
      BTFieldPathItem.new(Babeltrace2.bt_field_path_borrow_item_by_index_const(@handle))
    end
    alias [] get_item_by_index

    def each
      if block_given?
        get_item_count.times { |i|
          yield get_item_by_index(i)
        }
      else
        to_enum(:each)
      end
    end
  end

  BT_FIELD_PATH_ITEM_TYPE_INDEX = 1 << 0
  BT_FIELD_PATH_ITEM_TYPE_CURRENT_ARRAY_ELEMENT = 1 << 1
  BT_FIELD_PATH_ITEM_TYPE_CURRENT_OPTION_CONTENT = 1 << 2
  BTFieldPathItemType = enum :bt_field_path_item_type,
    [ :BT_FIELD_PATH_ITEM_TYPE_INDEX,
       BT_FIELD_PATH_ITEM_TYPE_INDEX,
      :BT_FIELD_PATH_ITEM_TYPE_CURRENT_ARRAY_ELEMENT,
       BT_FIELD_PATH_ITEM_TYPE_CURRENT_ARRAY_ELEMENT,
      :BT_FIELD_PATH_ITEM_TYPE_CURRENT_OPTION_CONTENT,
       BT_FIELD_PATH_ITEM_TYPE_CURRENT_OPTION_CONTENT ]

  attach_function :bt_field_path_item_get_type,
                  [ :bt_field_path_item_handle ],
                  :bt_field_path_item_type

  attach_function :bt_field_path_item_index_get_index,
                  [ :bt_field_path_item_handle ],
                  :uint64

  class BTFieldPath::Item < BTObject
    Type = BTFieldPathItemType

    def get_type
      Babeltrace2.bt_field_path_item_get_type(@handle)
    end
    alias type get_type

    def get_index
      Babeltrace2.bt_field_path_item_index_get_index(@handle)
    end
  end
  BTFieldPathItem = BTFieldPath::Item
end
