module Babeltrace2
  BT_COMPONENT_CLASS_TYPE_SOURCE = 1 << 0
  BT_COMPONENT_CLASS_TYPE_FILTER = 1 << 1
  BT_COMPONENT_CLASS_TYPE_SINK = 1 << 2

  BTComponentClassType = enum :bt_component_class_type,
    [ :BT_COMPONENT_CLASS_TYPE_SOURCE, BT_COMPONENT_CLASS_TYPE_SOURCE,
      :BT_COMPONENT_CLASS_TYPE_FILTER, BT_COMPONENT_CLASS_TYPE_FILTER,
      :BT_COMPONENT_CLASS_TYPE_SINK, BT_COMPONENT_CLASS_TYPE_SINK ]

  attach_function :bt_component_class_get_type,
                  [:bt_component_class_handle],
                  :bt_component_class_type
  attach_function :bt_component_class_get_name,
                  [:bt_component_class_handle],
                  :string
  attach_function :bt_component_class_get_description,
                  [:bt_component_class_handle],
                  :string
  attach_function :bt_component_class_get_help,
                  [:bt_component_class_handle],
                  :string
  attach_function :bt_component_class_get_ref,
                  [:bt_component_class_handle],
                  :void
  attach_function :bt_component_class_put_ref,
                  [:bt_component_class_handle],
                  :void

  class BTComponentClass < BTRefCountedObject
    Type = BTComponentClassType
    @get_ref = :bt_component_class_get_ref
    @put_ref = :bt_component_class_put_ref

    def self.from_handle(handle, retain: true, auto_release: true)
      case Babeltrace2.bt_component_class_get_type(handle)
      when :BT_COMPONENT_CLASS_TYPE_SOURCE
        BTComponentClassSource
      when :BT_COMPONENT_CLASS_TYPE_FILTER
        BTComponentClassFilter
      when :BT_COMPONENT_CLASS_TYPE_SINK
        BTComponentClassSink
      else
        raise Error.new("Unknown component class type")
      end.new(handle, retain: retain, auto_release: auto_release)
    end

    def get_type
      Babeltrace2.bt_component_class_get_type(@handle)
    end
    alias type get_type

    def is_source
      get_type == :BT_COMPONENT_CLASS_TYPE_SOURCE
    end
    alias source? is_source

    def is_filter
      get_type == :BT_COMPONENT_CLASS_TYPE_FILTER
    end
    alias filter? is_filter

    def is_sink
      get_type == :BT_COMPONENT_CLASS_TYPE_SINK
    end
    alias sink? is_sink

    def get_name
      Babeltrace2.bt_component_class_get_name(@handle)
    end
    alias name get_name

    def get_description
      Babeltrace2.bt_component_class_get_description(@handle)
    end
    alias description get_description

    def get_help
      Babeltrace2.bt_component_class_get_help(@handle)
    end
    alias help get_help
  end

  attach_function :bt_component_class_source_get_ref,
                  [:bt_component_class_source_handle],
                  :void
  attach_function :bt_component_class_source_put_ref,
                  [:bt_component_class_source_handle],
                  :void

  class BTComponentClass
    class Source < BTComponentClass
      @get_ref = :bt_component_class_source_get_ref
      @put_ref = :bt_component_class_source_put_ref
    end
  end
  BTComponentClassSource = BTComponentClass::Source

  attach_function :bt_component_class_filter_get_ref,
                  [:bt_component_class_filter_handle],
                  :void
  attach_function :bt_component_class_filter_put_ref,
                  [:bt_component_class_filter_handle],
                  :void

  class BTComponentClass
    class Filter < BTComponentClass
      @get_ref = :bt_component_class_filter_get_ref
      @put_ref = :bt_component_class_filter_put_ref
    end
  end
  BTComponentClassFilter = BTComponentClass::Filter

  attach_function :bt_component_class_sink_get_ref,
                  [:bt_component_class_sink_handle],
                  :void
  attach_function :bt_component_class_sink_put_ref,
                  [:bt_component_class_sink_handle],
                  :void

  class BTComponentClass
    class Sink < BTComponentClass
    @get_ref = :bt_component_class_sink_get_ref
    @put_ref = :bt_component_class_sink_put_ref
    end
  end
  BTComponentClassSink = BTComponentClass::Sink
end
