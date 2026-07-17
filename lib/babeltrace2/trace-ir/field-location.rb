module Babeltrace2
  BT_FIELD_LOCATION_SCOPE_PACKET_CONTEXT = 0
  BT_FIELD_LOCATION_SCOPE_EVENT_COMMON_CONTEXT = 1
  BT_FIELD_LOCATION_SCOPE_EVENT_SPECIFIC_CONTEXT = 2
  BT_FIELD_LOCATION_SCOPE_EVENT_PAYLOAD = 3
  BTFieldLocationScope = enum :bt_field_location_scope,
    [ :BT_FIELD_LOCATION_SCOPE_PACKET_CONTEXT,
       BT_FIELD_LOCATION_SCOPE_PACKET_CONTEXT,
      :BT_FIELD_LOCATION_SCOPE_EVENT_COMMON_CONTEXT,
       BT_FIELD_LOCATION_SCOPE_EVENT_COMMON_CONTEXT,
      :BT_FIELD_LOCATION_SCOPE_EVENT_SPECIFIC_CONTEXT,
       BT_FIELD_LOCATION_SCOPE_EVENT_SPECIFIC_CONTEXT,
      :BT_FIELD_LOCATION_SCOPE_EVENT_PAYLOAD,
       BT_FIELD_LOCATION_SCOPE_EVENT_PAYLOAD ]

  attach_function :bt_field_location_create,
                  [ :bt_trace_class_handle, :bt_field_location_scope,
                    :pointer, :uint64 ],
                  :bt_field_location_handle

  attach_function :bt_field_location_get_root_scope,
                  [ :bt_field_location_handle ],
                  :bt_field_location_scope

  attach_function :bt_field_location_get_item_count,
                  [ :bt_field_location_handle ],
                  :uint64

  attach_function :bt_field_location_get_item_by_index,
                  [ :bt_field_location_handle, :uint64 ],
                  :string

  attach_function :bt_field_location_get_ref,
                  [ :bt_field_location_handle ],
                  :void

  attach_function :bt_field_location_put_ref,
                  [ :bt_field_location_handle ],
                  :void

  # A MIP-1 field location: a root scope plus an ordered list of structure member
  # name items identifying a field (e.g. a dynamic array/blob's length field).
  class BTFieldLocation < BTSharedObject
    Scope = BTFieldLocationScope
    @get_ref = :bt_field_location_get_ref
    @put_ref = :bt_field_location_put_ref

    def initialize(handle = nil, retain: true, auto_release: true,
                   trace_class: nil, root_scope: nil, items: nil)
      if handle
        super(handle, retain: retain, auto_release: auto_release)
      else
        items_ptr = FFI::MemoryPointer.new(:pointer, items.length)
        str_ptrs = items.map { |i| FFI::MemoryPointer.from_string(i.to_s) }
        items_ptr.write_array_of_pointer(str_ptrs)
        handle = Babeltrace2.bt_field_location_create(
                   trace_class, root_scope, items_ptr, items.length)
        raise Babeltrace2.process_error if handle.null?
        super(handle, retain: false)
      end
    end

    def get_root_scope
      Babeltrace2.bt_field_location_get_root_scope(@handle)
    end
    alias root_scope get_root_scope

    def get_item_count
      Babeltrace2.bt_field_location_get_item_count(@handle)
    end
    alias item_count get_item_count
    alias size get_item_count

    def get_item_by_index(index)
      index = get_item_count + index if index < 0
      return nil if index >= get_item_count || index < 0
      Babeltrace2.bt_field_location_get_item_by_index(@handle, index)
    end
    alias [] get_item_by_index

    def items
      get_item_count.times.collect { |i| get_item_by_index(i) }
    end

    def to_h
      { root_scope: root_scope, items: items }
    end

    def self.from_h(trace_class, h)
      new(trace_class: trace_class, root_scope: h[:root_scope], items: h[:items])
    end
  end
end
