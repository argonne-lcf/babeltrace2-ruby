module Babeltrace2

  attach_function :bt_component_get_class_type,
                  [ :bt_component_handle ],
                  :bt_component_class_type

  attach_function :bt_component_borrow_class_const,
                  [ :bt_component_handle ],
                  :bt_component_class_handle

  attach_function :bt_component_get_name,
                  [ :bt_component_handle ],
                  :string

  attach_function :bt_component_get_logging_level,
                  [ :bt_component_handle ],
                  :bt_logging_level

  attach_function :bt_component_get_ref,
                  [ :bt_component_handle ],
                  :void

  attach_function :bt_component_put_ref,
                  [ :bt_component_handle ],
                  :void

  class BTComponent < BTRefCountedObject
    ClassType = BTComponentClassType
    @get_ref = :bt_component_get_ref
    @put_ref = :bt_component_put_ref

    def self.from_handle(handle, retain: true, auto_release: true)
      case Babeltrace2.bt_component_get_class_type(handle)
      when :BT_COMPONENT_CLASS_TYPE_SOURCE
        Source
      when :BT_COMPONENT_CLASS_TYPE_FILTER
        Filter
      when :BT_COMPONENT_CLASS_TYPE_SINK
        Sink
      else
        raise Error.new("Unknown component class type")
      end.new(handle, retain: retain, auto_release: auto_release)
    end

    def get_class_type
      Babeltrace2.bt_component_get_class_type(@handle)
    end
    alias class_type get_class_type

    def is_source
      get_class_type == :BT_COMPONENT_CLASS_TYPE_SOURCE
    end
    alias source? is_source

    def is_filter
      get_class_type == :BT_COMPONENT_CLASS_TYPE_FILTER
    end
    alias filter? is_filter

    def is_sink
      get_class_type == :BT_COMPONENT_CLASS_TYPE_SINK
    end
    alias sink? is_sink

    def get_class
      handle = Babeltrace2.bt_component_borrow_class_const(@handle)
      BTComponentClass.from_handle(handle)
    end

    def get_name
      Babeltrace2.bt_component_get_name(@handle)
    end
    alias name get_name

    def get_logging_level
      Babeltrace2.bt_component_get_logging_level(@handle)
    end
    alias logging_level get_logging_level
  end

  attach_function :bt_component_source_borrow_class_const,
                  [ :bt_component_source_handle ],
                  :bt_component_class_source_handle

  attach_function :bt_component_source_get_output_port_count,
                  [ :bt_component_source_handle ],
                  :uint64

  attach_function :bt_component_source_borrow_output_port_by_index_const,
                  [ :bt_component_source_handle,
                    :uint64 ],
                  :bt_port_output_handle

  attach_function :bt_component_source_borrow_output_port_by_name_const,
                  [ :bt_component_source_handle,
                    :string ],
                  :bt_port_output_handle

  attach_function :bt_component_source_get_ref,
                  [ :bt_component_source_handle ],
                  :void

  attach_function :bt_component_source_put_ref,
                  [ :bt_component_source_handle ],
                  :void

  class BTComponent::Source < BTComponent
    @get_ref = :bt_component_source_get_ref
    @put_ref = :bt_component_source_put_ref
    def get_class
      handle = Babeltrace2.bt_component_source_borrow_class_const(@handle)
      BTComponentClassSource.new(handle, retain: true, auto_release: true)
    end

    def get_output_port_count
      Babeltrace2.bt_component_source_get_output_port_count(@handle)
    end
    alias output_port_count get_output_port_count

    def get_output_port_by_index(index)
      raise RangeError if index >= get_output_port_count
      handle = Babeltrace2.bt_component_source_borrow_output_port_by_index_const(@handle, index)
      BTPortOutput.new(handle, retain: true, auto_release: true)
    end

    def get_output_port_by_name(name)
      handle = Babeltrace2.bt_component_source_borrow_output_port_by_name_const(@handle, name)
      return nil if handle.null?
      BTPortOutput.new(handle, retain: true, auto_release: true)
    end

    def get_output_port(port)
      case port
      when String
        get_output_port_by_name(port)
      when Integer
        get_output_port_by_name(port)
      else
        raise TypeError, "wrong type for port query"
      end
    end
  end
  BTComponentSource = BTComponent::Source

  attach_function :bt_component_filter_borrow_class_const,
                  [ :bt_component_filter_handle ],
                  :bt_component_class_filter_handle

  attach_function :bt_component_filter_get_input_port_count,
                  [ :bt_component_filter_handle ],
                  :uint64

  attach_function :bt_component_filter_borrow_input_port_by_index_const,
                  [ :bt_component_filter_handle,
                    :uint64 ],
                  :bt_port_input_handle

  attach_function :bt_component_filter_borrow_input_port_by_name_const,
                  [ :bt_component_filter_handle,
                    :string ],
                  :bt_port_input_handle

  attach_function :bt_component_filter_borrow_class_const,
                  [ :bt_component_filter_handle ],
                  :bt_component_class_filter_handle

  attach_function :bt_component_filter_get_output_port_count,
                  [ :bt_component_filter_handle ],
                  :uint64

  attach_function :bt_component_filter_borrow_output_port_by_index_const,
                  [ :bt_component_filter_handle,
                    :uint64 ],
                  :bt_port_output_handle

  attach_function :bt_component_filter_borrow_output_port_by_name_const,
                  [ :bt_component_filter_handle,
                    :string ],
                  :bt_port_output_handle

  attach_function :bt_component_filter_get_ref,
                  [ :bt_component_filter_handle ],
                  :void

  attach_function :bt_component_filter_put_ref,
                  [ :bt_component_filter_handle ],
                  :void

  class BTComponent::Filter < BTComponent
    @get_ref = :bt_component_filter_get_ref
    @put_ref = :bt_component_filter_put_ref
    def get_class
      handle = Babeltrace2.bt_component_filter_borrow_class_const(@handle)
      BTComponentClassFilter.new(handle, retain: true, auto_release: true)
    end

    def get_output_port_count
      Babeltrace2.bt_component_filter_get_output_port_count(@handle)
    end
    alias output_port_count get_output_port_count

    def get_output_port_by_index(index)
      raise RangeError if index >= get_output_port_count
      handle = Babeltrace2.bt_component_filter_borrow_output_port_by_index_const(@handle, index)
      BTPortOutput.new(handle, retain: true, auto_release: true)
    end

    def get_output_port_by_name(name)
      handle = Babeltrace2.bt_component_filter_borrow_output_port_by_name_const(@handle, name)
      return nil if handle.null?
      BTPortOutput.new(handle, retain: true, auto_release: true)
    end

    def get_output_port(port)
      case port
      when String
        get_output_port_by_name(port)
      when Integer
        get_output_port_by_name(port)
      else
        raise TypeError, "wrong type for port query"
      end
    end

    def get_input_port_count
      Babeltrace2.bt_component_filter_get_input_port_count(@handle)
    end
    alias input_port_count get_input_port_count

    def get_input_port_by_index(index)
      raise RangeError if index >= get_input_port_count
      handle = Babeltrace2.bt_component_filter_borrow_input_port_by_index_const(@handle, index)
      BTPortInput.new(handle, retain: true, auto_release: true)
    end

    def get_input_port_by_name(name)
      handle = Babeltrace2.bt_component_filter_borrow_input_port_by_name_const(@handle, name)
      return nil if handle.null?
      BTPortInput.new(handle, retain: true, auto_release: true)
    end

    def get_input_port(port)
      case port
      when String
        get_input_port_by_name(port)
      when Integer
        get_input_port_by_name(port)
      else
        raise TypeError, "wrong type for port query"
      end
    end
  end
  BTComponentFilter = BTComponent::Filter

  attach_function :bt_component_sink_borrow_class_const,
                  [ :bt_component_sink_handle ],
                  :bt_component_class_sink_handle

  attach_function :bt_component_sink_get_input_port_count,
                  [ :bt_component_sink_handle ],
                  :uint64

  attach_function :bt_component_sink_borrow_input_port_by_index_const,
                  [ :bt_component_sink_handle,
                    :uint64 ],
                  :bt_port_input_handle

  attach_function :bt_component_sink_borrow_input_port_by_name_const,
                  [ :bt_component_sink_handle,
                    :string ],
                  :bt_port_input_handle

  attach_function :bt_component_sink_get_ref,
                  [ :bt_component_sink_handle ],
                  :void

  attach_function :bt_component_sink_put_ref,
                  [ :bt_component_sink_handle ],
                  :void

  class BTComponent::Sink < BTComponent
    @get_ref = :bt_component_sink_get_ref
    @put_ref = :bt_component_sink_put_ref
    def get_class
      handle = Babeltrace2.bt_component_sink_borrow_class_const(@handle)
      BTComponentClassSink.new(handle, retain: true, auto_release: true)
    end

    def get_input_port_count
      Babeltrace2.bt_component_sink_get_input_port_count(@handle)
    end
    alias input_port_count get_input_port_count

    def get_input_port_by_index(index)
      raise RangeError if index >= get_input_port_count
      handle = Babeltrace2.bt_component_sink_borrow_input_port_by_index_const(@handle, index)
      BTPortInput.new(handle, retain: true, auto_release: true)
    end

    def get_input_port_by_name(name)
      handle = Babeltrace2.bt_component_sink_borrow_input_port_by_name_const(@handle, name)
      return nil if handle.null?
      BTPortInput.new(handle, retain: true, auto_release: true)
    end

    def get_input_port(port)
      case port
      when String
        get_input_port_by_name(port)
      when Integer
        get_input_port_by_name(port)
      else
        raise TypeError, "wrong type for port query"
      end
    end

    def create_message_iterator(port)
      BTMessageIterator.create_from_sink_component(self, port)
    end
  end
  BTComponentSink = BTComponent::Sink

end
