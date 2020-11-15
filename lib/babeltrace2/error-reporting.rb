module Babeltrace2

  BTErrorCauseActorType = enum :bt_error_cause_actor_type,
    [ :BT_ERROR_CAUSE_ACTOR_TYPE_UNKNOWN, 1 << 0,
      :BT_ERROR_CAUSE_ACTOR_TYPE_COMPONENT, 1 << 1,
      :BT_ERROR_CAUSE_ACTOR_TYPE_COMPONENT_CLASS, 1 << 2,
      :BT_ERROR_CAUSE_ACTOR_TYPE_MESSAGE_ITERATOR, 1 << 3]

  class BTError < BTObject
  end

  attach_function :bt_error_cause_get_actor_type,
                  [:bt_error_cause_handle],
                  :bt_error_cause_actor_type
  attach_function :bt_error_cause_get_message,
                  [:bt_error_cause_handle],
                  :string
  attach_function :bt_error_cause_get_module_name,
                  [:bt_error_cause_handle],
                  :string
  attach_function :bt_error_cause_get_file_name,
                  [:bt_error_cause_handle],
                  :string
  attach_function :bt_error_cause_get_line_number,
                  [:bt_error_cause_handle],
                  :uint64_t

  class BTError
    class Cause < BTObject
      ActorType = BTErrorCauseActorType

      def self.from_handle(handle)
        case Babeltrace2.bt_error_cause_get_actor_type(handle)
        when :BT_ERROR_CAUSE_ACTOR_TYPE_UNKNOWN
          Cause
        when :BT_ERROR_CAUSE_ACTOR_TYPE_COMPONENT
          ComponentActor
        when :BT_ERROR_CAUSE_ACTOR_TYPE_COMPONENT_CLASS
          ComponentClassActor
        when :BT_ERROR_CAUSE_ACTOR_TYPE_MESSAGE_ITERATOR
          MessageIteratorActor
        else
          raise Error.new("Unknown error cause actor type")
        end.new(handle)
      end

      def get_actor_type
        Babeltrace2.bt_error_cause_get_actor_type(@handle)
      end
      alias actor_type get_actor_type

      def get_message
        Babeltrace2.bt_error_cause_get_message(@handle)
      end
      alias message get_message

      def get_module_name
        Babeltrace2.bt_error_cause_get_module_name(@handle)
      end
      alias module_name get_module_name

      def get_file_name
        Babeltrace2.bt_error_cause_get_file_name(@handle)
      end
      alias file_name get_file_name

      def get_line_number
        Babeltrace2.bt_error_cause_get_line_number(@handle)
      end
      alias line_number get_line_number
    end
  end
  BTErrorCause = BTError::Cause

  attach_function :bt_error_cause_component_actor_get_component_name,
                  [:bt_error_cause_handle],
                  :string
  attach_function :bt_error_cause_component_actor_get_component_class_type,
                  [:bt_error_cause_handle],
                  :bt_component_class_type
  attach_function :bt_error_cause_component_actor_get_component_class_name,
                  [:bt_error_cause_handle],
                  :string
  attach_function :bt_error_cause_component_actor_get_plugin_name,
                  [:bt_error_cause_handle],
                  :string

  class BTError::Cause
    class ComponentActor < BTError::Cause
      def get_component_name
        Babeltrace2.bt_error_cause_component_actor_get_component_name(@handle)
      end
      alias component_name get_component_name

      def get_component_class_type
        Babeltrace2.bt_error_cause_component_actor_get_component_class_type(@handle)
      end
      alias component_class_type get_component_class_type

      def get_component_class_name
        Babeltrace2.bt_error_cause_component_actor_get_component_class_name(@handle)
      end
      alias component_class_name get_component_class_name

      def get_component_plugin_name
        Babeltrace2.bt_error_cause_component_actor_get_component_plugin_name(@handle)
      end
      alias component_plugin_name get_component_plugin_name
    end
  end
  BTErrorCauseComponentActor = BTError::Cause::ComponentActor

  attach_function :bt_error_cause_message_iterator_actor_get_component_output_port_name,
                  [:bt_error_cause_handle],
                  :string
  attach_function :bt_error_cause_message_iterator_actor_get_component_name,
                  [:bt_error_cause_handle],
                  :string
  attach_function :bt_error_cause_message_iterator_actor_get_component_class_type,
                  [:bt_error_cause_handle],
                  :bt_component_class_type
  attach_function :bt_error_cause_message_iterator_actor_get_component_class_name,
                  [:bt_error_cause_handle],
                  :string
  attach_function :bt_error_cause_message_iterator_actor_get_plugin_name,
                  [:bt_error_cause_handle],
                  :string

  class BTError::Cause
    class MessageIteratorActor < BTError::Cause
      def get_component_output_port_name
        Babeltrace2.bt_error_cause_message_iterator_actor_get_component_output_port_name(@handle)
      end
      alias component_output_port_name get_component_output_port_name

      def get_component_name
        Babeltrace2.bt_error_cause_message_iterator_actor_get_component_name(@handle)
      end
      alias component_name get_component_name

      def get_component_class_type
        Babeltrace2.bt_error_cause_message_iterator_actor_get_component_class_type(@handle)
      end
      alias component_class_type get_component_class_type

      def get_component_class_name
        Babeltrace2.bt_error_cause_message_iterator_actor_get_component_class_name(@handle)
      end
      alias component_class_name get_component_class_name

      def get_plugin_name
        Babeltrace2.bt_error_cause_message_iterator_actor_get_plugin_name(@handle)
      end
      alias plugin_name get_plugin_name
    end
  end
  BTErrorCauseMessageIteratorActor = BTError::Cause::MessageIteratorActor

  attach_function :bt_error_cause_component_class_actor_get_component_class_type,
                  [:bt_error_cause_handle],
                  :bt_component_class_type
  attach_function :bt_error_cause_component_class_actor_get_component_class_name,
                  [:bt_error_cause_handle],
                  :string
  attach_function :bt_error_cause_component_class_actor_get_plugin_name,
                  [:bt_error_cause_handle],
                  :string

  class BTError::Cause
    class ComponentClassActor < BTError::Cause
      def get_component_class_type
        Babeltrace2.bt_error_cause_component_class_actor_get_component_class_type(@hanlde)
      end
      alias component_class_type get_component_class_type

      def get_component_class_name
        Babeltrace2.bt_error_cause_component_class_actor_get_component_class_name(@handle)
      end
      alias get_component_class_name get_component_class_name

      def get_plugin_name
        Babeltrace2.bt_error_cause_component_class_actor_get_plugin_name(@handle)
      end
      alias plugin_name get_plugin_name
    end
  end
  BTErrorCauseComponentClassActor = BTError::Cause::ComponentClassActor

  BTCurrentThreadErrorAppendCauseStatus = enum :bt_current_thread_error_append_cause_status,
    [ :BT_CURRENT_THREAD_ERROR_APPEND_CAUSE_STATUS_OK, BT_FUNC_STATUS_OK,
      :BT_CURRENT_THREAD_ERROR_APPEND_CAUSE_STATUS_MEMORY_ERROR, BT_FUNC_STATUS_MEMORY_ERROR ]

  attach_function :bt_current_thread_take_error,
                  [],
                  :bt_error_handle
  attach_function :bt_current_thread_move_error,
                  [:bt_error_handle],
                  :void
  attach_function :bt_current_thread_clear_error,
                  [],
                  :void
  attach_function :bt_current_thread_error_append_cause_from_component,
                  [:bt_self_component_handle, :string, :uint64, :string, :varargs],
                  :bt_current_thread_error_append_cause_status
  attach_function :bt_current_thread_error_append_cause_from_message_iterator,
                  [:bt_self_message_iterator_handle, :string, :uint64, :string, :varargs],
                  :bt_current_thread_error_append_cause_status
  attach_function :bt_current_thread_error_append_cause_from_component_class,
                  [:bt_self_component_class_handle, :string, :uint64, :string, :varargs],
                  :bt_current_thread_error_append_cause_status
  attach_function :bt_current_thread_error_append_cause_from_unknown,
                  [:string, :string, :uint64, :string, :varargs],
                  :bt_current_thread_error_append_cause_status

  module BTCurrentThread
    ErrorAppendCauseStatus = BTCurrentThreadErrorAppendCauseStatus
    def self.take_error
      handle = Babeltrace2.bt_current_thread_take_error
      return nil if handle.null?
      BTError.new(handle)
    end

    def self.clear_error
      Babeltrace2.bt_current_thread_clear_error
    end

    def self.move_error(error)
      raise Error.new("Error already released") unless error.handle
      Babeltrace2.bt_current_thread_move_error(error.handle)
      error.instance_variable_set(:@handle, nil)
    end

    module Error
      AppendCauseStatus = BTCurrentThreadErrorAppendCauseStatus
      def self.append_cause_from_component(self_component, message_format, *args,
                                           file_name: nil, line_number: nil)
        loc = caller_locations.first
        file_name = loc.path unless file_name
        line_number = loc.lineno unless line_number
        res = Babeltrace2.bt_current_thread_error_append_cause_from_component(
          self_component, file_name, line_number, message_format, *args)
        raise res.to_s if res != :BT_CURRENT_THREAD_ERROR_APPEND_CAUSE_STATUS_OK
        self
      end

      def self.append_cause_from_message_iterator(self_message_iterator, message_format,
                                                  *args, file_name: nil, line_number: nil)
        loc = caller_locations.first
        file_name = loc.path unless file_name
        line_number = loc.lineno unless line_number
        res = Babeltrace2.bt_current_thread_error_append_cause_from_message_iterator(
          self_message_iterator, file_name, line_number, message_format, *args)
        raise res.to_s if res != :BT_CURRENT_THREAD_ERROR_APPEND_CAUSE_STATUS_OK
        self
      end

      def self.append_cause_from_component_class(self_component_class, message_format,
                                                 *args, file_name: nil, line_number: nil)
        loc = caller_locations.first
        file_name = loc.path unless file_name
        line_number = loc.lineno unless line_number
        res = Babeltrace2.bt_current_thread_error_append_cause_from_component_class(
          self_component_class, file_name, line_number, message_format, *args)
        raise res.to_s if res != :BT_CURRENT_THREAD_ERROR_APPEND_CAUSE_STATUS_OK
        self
      end

      def self.append_cause_from_unknown(module_name, message_format, *args,
                                         file_name: nil, line_number: nil)
        loc = caller_locations.first
        file_name = loc.path unless file_name
        line_number = loc.lineno unless line_number
        res = Babeltrace2.bt_current_thread_error_append_cause_from_unknown(
          module_name, file_name, line_number, message_format, *args)
        raise res.to_s if res != :BT_CURRENT_THREAD_ERROR_APPEND_CAUSE_STATUS_OK
        self
      end
    end
  end

  attach_function :bt_error_get_cause_count,
                  [:bt_error_handle],
                  :uint64
  attach_function :bt_error_borrow_cause_by_index,
                  [:bt_error_handle, :uint64],
                  :bt_error_cause_handle
  attach_function :bt_error_release,
                  [:bt_error_handle],
                  :void

  class BTError
    def get_cause_count
      raise Error.new("Error already released") unless @handle
      Babeltrace2.bt_error_get_cause_count(@handle)
    end
    alias cause_count get_cause_count

    def get_cause_by_index(indx)
      return nil unless indx < get_cause_count
      ref = Babeltrace2.bt_error_borrow_cause_by_index(@handle, indx)
      Cause.new(ref)
    end

    def causes
      get_cause_count.times.collect { |i|
        ref = Babeltrace2.bt_error_borrow_cause_by_index(@handle, i)
        Cause.new(ref)
      }
    end

    def release
      raise Error.new("Error already released") unless @handle
      Babeltrace2.bt_error_release(@handle)
      @handle = nil
    end

    def to_s
      str = ""
      causes.each { |c|
        str << c.actor_type.to_s << ": "
        str << c.message
        str << "\n"
      }
      str
    end
  end

  def self.process_error(code = :BT_FUNC_STATUS_MEMORY_ERROR)
    err = BTCurrentThread.take_error
    str = err.to_s
    err.release
    Error.new(str)
  end
end
