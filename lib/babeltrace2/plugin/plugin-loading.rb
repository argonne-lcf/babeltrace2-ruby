module Babeltrace2

  BT_PLUGIN_FIND_STATUS_OK = BT_FUNC_STATUS_OK
  BT_PLUGIN_FIND_STATUS_NOT_FOUND = BT_FUNC_STATUS_NOT_FOUND
  BT_PLUGIN_FIND_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_PLUGIN_FIND_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTPluginFindStatus = enum :bt_plugin_find_status,
    [ :BT_PLUGIN_FIND_STATUS_OK,
       BT_PLUGIN_FIND_STATUS_OK,
      :BT_PLUGIN_FIND_STATUS_NOT_FOUND,
       BT_PLUGIN_FIND_STATUS_NOT_FOUND,
      :BT_PLUGIN_FIND_STATUS_MEMORY_ERROR,
       BT_PLUGIN_FIND_STATUS_MEMORY_ERROR,
      :BT_PLUGIN_FIND_STATUS_ERROR,
       BT_PLUGIN_FIND_STATUS_ERROR ]

  attach_function :bt_plugin_find,
                  [ :string, :bt_bool, :bt_bool, :bt_bool, :bt_bool, :bt_bool, :pointer ],
                  :bt_plugin_find_status

  BT_PLUGIN_FIND_ALL_STATUS_OK = BT_FUNC_STATUS_OK
  BT_PLUGIN_FIND_ALL_STATUS_NOT_FOUND = BT_FUNC_STATUS_NOT_FOUND
  BT_PLUGIN_FIND_ALL_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_PLUGIN_FIND_ALL_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTPluginFindAllStatus = enum :bt_plugin_find_all_status,
    [ :BT_PLUGIN_FIND_ALL_STATUS_OK,
       BT_PLUGIN_FIND_ALL_STATUS_OK,
      :BT_PLUGIN_FIND_ALL_STATUS_NOT_FOUND,
       BT_PLUGIN_FIND_ALL_STATUS_NOT_FOUND,
      :BT_PLUGIN_FIND_ALL_STATUS_MEMORY_ERROR,
       BT_PLUGIN_FIND_ALL_STATUS_MEMORY_ERROR,
      :BT_PLUGIN_FIND_ALL_STATUS_ERROR,
       BT_PLUGIN_FIND_ALL_STATUS_ERROR ]

  attach_function :bt_plugin_find_all,
                  [ :bt_bool, :bt_bool, :bt_bool, :bt_bool, :bt_bool, :pointer ],
                  :bt_plugin_find_all_status

  BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_OK = BT_FUNC_STATUS_OK
  BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_NOT_FOUND = BT_FUNC_STATUS_NOT_FOUND
  BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTPluginFindAllFromFileStatus = enum :bt_plugin_find_all_from_file_status,
    [ :BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_OK,
       BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_OK,
      :BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_NOT_FOUND,
       BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_NOT_FOUND,
      :BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_MEMORY_ERROR,
       BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_MEMORY_ERROR,
      :BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_ERROR,
       BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_ERROR ]

  attach_function :bt_plugin_find_all_from_file,
                  [ :string, :bt_bool, :pointer ],
                  :bt_plugin_find_all_from_file_status

  BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_OK = BT_FUNC_STATUS_OK
  BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_NOT_FOUND = BT_FUNC_STATUS_NOT_FOUND
  BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTPluginFindAllFromDirStatus = enum :bt_plugin_find_all_from_dir_status,
    [ :BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_OK,
       BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_OK,
      :BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_NOT_FOUND,
       BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_NOT_FOUND,
      :BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_MEMORY_ERROR,
       BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_MEMORY_ERROR,
      :BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_ERROR,
       BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_ERROR ]

  attach_function :bt_plugin_find_all_from_dir,
                  [ :string, :bt_bool, :bt_bool, :pointer ],
                  :bt_plugin_find_all_from_dir_status

  BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_OK = BT_FUNC_STATUS_OK
  BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_NOT_FOUND = BT_FUNC_STATUS_NOT_FOUND
  BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_MEMORY_ERROR = BT_FUNC_STATUS_MEMORY_ERROR
  BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_ERROR = BT_FUNC_STATUS_ERROR
  BTPluginFindAllFromStaticStatus = enum :bt_plugin_find_all_from_static_status,
    [ :BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_OK,
       BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_OK,
      :BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_NOT_FOUND,
       BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_NOT_FOUND,
      :BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_MEMORY_ERROR,
       BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_MEMORY_ERROR,
      :BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_ERROR,
       BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_ERROR ]

  attach_function :bt_plugin_find_all_from_static,
                  [ :bt_bool, :pointer ],
                  :bt_plugin_find_all_from_static_status

  attach_function :bt_plugin_get_name,
                  [ :bt_plugin_handle ],
                  :string

  attach_function :bt_plugin_get_description,
                  [ :bt_plugin_handle ],
                  :string

  attach_function :bt_plugin_get_author,
                  [ :bt_plugin_handle ],
                  :string

  attach_function :bt_plugin_get_license,
                  [ :bt_plugin_handle ],
                  :string

  attach_function :bt_plugin_get_path,
                  [ :bt_plugin_handle ],
                  :string

  attach_function :bt_plugin_get_version,
                  [ :bt_plugin_handle, :pointer, :pointer, :pointer, :pointer ],
                  :bt_property_availability

  attach_function :bt_plugin_get_source_component_class_count,
                  [ :bt_plugin_handle ],
                  :uint64

  attach_function :bt_plugin_get_filter_component_class_count,
                  [ :bt_plugin_handle ],
                  :uint64

  attach_function :bt_plugin_get_sink_component_class_count,
                  [ :bt_plugin_handle ],
                  :uint64

  attach_function :bt_plugin_borrow_source_component_class_by_index_const,
                  [ :bt_plugin_handle, :uint64 ],
                  :bt_component_class_source_handle

  attach_function :bt_plugin_borrow_filter_component_class_by_index_const,
                  [ :bt_plugin_handle, :uint64 ],
                  :bt_component_class_filter_handle

  attach_function :bt_plugin_borrow_sink_component_class_by_index_const,
                  [ :bt_plugin_handle, :uint64 ],
                  :bt_component_class_sink_handle

  attach_function :bt_plugin_borrow_source_component_class_by_name_const,
                  [ :bt_plugin_handle, :string ],
                  :bt_component_class_source_handle

  attach_function :bt_plugin_borrow_filter_component_class_by_name_const,
                  [ :bt_plugin_handle, :string ],
                  :bt_component_class_filter_handle

  attach_function :bt_plugin_borrow_sink_component_class_by_name_const,
                  [ :bt_plugin_handle, :string ],
                  :bt_component_class_sink_handle

  attach_function :bt_plugin_get_ref,
                  [ :bt_plugin_handle ],
                  :void

  attach_function :bt_plugin_put_ref,
                  [ :bt_plugin_handle ],
                  :void

  class BTPlugin < BTSharedObject
    FindStatus = BTPluginFindStatus
    FindAllStatus = BTPluginFindAllStatus
    FindAllFromFileStatus = BTPluginFindAllFromFileStatus
    FindAllFromDirStatus = BTPluginFindAllFromDirStatus
    FindAllFromStaticStatus = BTPluginFindAllFromStaticStatus
    @get_ref = :bt_plugin_get_ref
    @put_ref = :bt_plugin_put_ref

    def self.find(name,
                  find_in_std_env_var: true,
                  find_in_user_dir: true,
                  find_in_sys_dir: true,
                  find_in_static: false,
                  fail_on_load_error: true)
      ptr = FFI::MemoryPointer.new(:pointer)
      res = Babeltrace2.bt_plugin_find(
              name,
              find_in_std_env_var ? BT_TRUE : BT_FALSE,
              find_in_user_dir ? BT_TRUE : BT_FALSE,
              find_in_sys_dir ? BT_TRUE : BT_FALSE,
              find_in_static ? BT_TRUE : BT_FALSE,
              fail_on_load_error ? BT_TRUE : BT_FALSE,
              ptr)
      return nil if res == :BT_PLUGIN_FIND_STATUS_NOT_FOUND
      raise Babeltrace2.process_error(res) if res != :BT_PLUGIN_FIND_STATUS_OK
      handle = BTPluginHandle.new(ptr.read_pointer)
      BTPlugin.new(handle, retain: false)
    end

    def self.find_all(find_in_std_env_var: true,
                      find_in_user_dir: true,
                      find_in_sys_dir: true,
                      find_in_static: false,
                      fail_on_load_error: true)
      ptr = FFI::MemoryPointer.new(:pointer)
      res = Babeltrace2.bt_plugin_find_all(
              find_in_std_env_var ? BT_TRUE : BT_FALSE,
              find_in_user_dir ? BT_TRUE : BT_FALSE,
              find_in_sys_dir ? BT_TRUE : BT_FALSE,
              find_in_static ? BT_TRUE : BT_FALSE,
              fail_on_load_error ? BT_TRUE : BT_FALSE,
              ptr)
      return [] if res == :BT_PLUGIN_FIND_ALL_STATUS_NOT_FOUND
      raise Babeltrace2.process_error(res) if res != :BT_PLUGIN_FIND_ALL_STATUS_OK
      handle = BTPluginSetHandle.new(ptr.read_pointer)
      BTPluginSet.new(handle).plugins
    end

    def self.find_all_from_file(path, fail_on_load_error: true)
      ptr = FFI::MemoryPointer.new(:pointer)
      res = Babeltrace2.bt_plugin_find_all_from_file(
              path,
              fail_on_load_error ? BT_TRUE : BT_FALSE,
              ptr)
      return [] if res == :BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_NOT_FOUND
      raise Babeltrace2.process_error(res) if res != :BT_PLUGIN_FIND_ALL_FROM_FILE_STATUS_OK
      handle = BTPluginSetHandle.new(ptr.read_pointer)
      BTPluginSet.new(handle).plugins
    end

    def self.find_all_from_dir(path, recurse: false, fail_on_load_error: true)
      ptr = FFI::MemoryPointer.new(:pointer)
      res = Babeltrace2.bt_plugin_find_all_from_dir(
              path,
              recurse ? BT_TRUE : BT_FALSE,
              fail_on_load_error ? BT_TRUE : BT_FALSE,
              ptr)
      return [] if res == :BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_NOT_FOUND
      raise Babeltrace2.process_error(res) if res != :BT_PLUGIN_FIND_ALL_FROM_DIR_STATUS_OK
      handle = BTPluginSetHandle.new(ptr.read_pointer)
      BTPluginSet.new(handle).plugins
    end

    def self.find_all_from_static(recurse: false, fail_on_load_error: true)
      ptr = FFI::MemoryPointer.new(:pointer)
      res = Babeltrace2.bt_plugin_find_all_from_static(
              path,
              recurse ? BT_TRUE : BT_FALSE,
              fail_on_load_error ? BT_TRUE : BT_FALSE,
              ptr)
      return [] if res == :BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_NOT_FOUND
      raise Babeltrace2.process_error(res) if res != :BT_PLUGIN_FIND_ALL_FROM_STATIC_STATUS_OK
      handle = BTPluginSetHandle.new(ptr.read_pointer)
      BTPluginSet.new(handle).plugins
    end

    def get_name
      Babeltrace2.bt_plugin_get_name(@handle)
    end
    alias name get_name

    def get_description
      Babeltrace2.bt_plugin_get_description(@handle)
    end
    alias description get_description

    def get_author
      Babeltrace2.bt_plugin_get_author(@handle)
    end
    alias author get_author

    def get_license
      Babeltrace2.bt_plugin_get_license(@handle)
    end
    alias license get_license

    def get_path
      Babeltrace2.bt_plugin_get_path(@handle)
    end
    alias path get_path

    def get_version
      major = FFI::MemoryPointer.new(:uint)
      minor = FFI::MemoryPointer.new(:uint)
      patch = FFI::MemoryPointer.new(:uint)
      extra = FFI::MemoryPointer.new(:pointer)
      res = Babeltrace2.bt_plugin_get_version(@handle, major, minor, patch, extra)
      if res == :BT_PROPERTY_AVAILABILITY_AVAILABLE
        extra = extra.read_pointer
        BTVersion::Number.new(major.read_uint, minor.read_uint, patch.read_uint,
                              extra.null? ? nil : extra.read_string)
      else
        nil
      end
    end
    alias version get_version

    def get_source_component_class_count
      Babeltrace2.bt_plugin_get_source_component_class_count(@handle)
    end
    alias source_component_class_count get_source_component_class_count

    def get_filter_component_class_count
      Babeltrace2.bt_plugin_get_filter_component_class_count(@handle)
    end
    alias filter_component_class_count get_filter_component_class_count

    def get_sink_component_class_count
      Babeltrace2.bt_plugin_get_sink_component_class_count(@handle)
    end
    alias sink_component_class_count get_sink_component_class_count

    def get_source_component_class_by_index(index)
      return nil if index >= get_source_component_class_count
      handle = Babeltrace2.bt_plugin_borrow_source_component_class_by_index_const(
                 @handle, index)
      BTComponentClassSource.new(handle, retain: true, auto_release: true)
    end

    def get_source_component_class_by_name(name)
      handle = Babeltrace2.bt_plugin_borrow_source_component_class_by_name_const(
                 @handle, name)
      return nil if handle.null?
      BTComponentClassSource.new(handle, retain: true, auto_release: true)
    end

    def get_source_component_class(source_component_class)
      case source_component_class
      when String
        get_source_component_class_by_name(source_component_class)
      when Integer
        get_source_component_class_by_index(source_component_class)
      else
        raise TypeError, "wrong type for source component class query"
      end
    end

    def source_component_classes
      source_component_class_count.times.collect { |index|
        handle = Babeltrace2.bt_plugin_borrow_source_component_class_by_index_const(
                   @handle, index)
        BTComponentClassSource.new(handle, retain: true, auto_release: true)
      }
    end

    def get_filter_component_class_by_index(index)
      return nil if index >= get_filter_component_class_count
      handle = Babeltrace2.bt_plugin_borrow_filter_component_class_by_index_const(
                 @handle, index)
      BTComponentClassFilter.new(handle, retain: true, auto_release: true)
    end

    def get_filter_component_class_by_name(name)
      handle = Babeltrace2.bt_plugin_borrow_filter_component_class_by_name_const(
                 @handle, name)
      return nil if handle.null?
      BTComponentClassFilter.new(handle, retain: true, auto_release: true)
    end

    def get_filter_component_class(filter_component_class)
      case filter_component_class
      when String
        get_filter_component_class_by_name(filter_component_class)
      when Integer
        get_filter_component_class_by_index(filter_component_class)
      else
        raise TypeError, "wrong type for filter component class query"
      end
    end

    def filter_component_classes
      filter_component_class_count.times.collect { |index|
        handle = Babeltrace2.bt_plugin_borrow_filter_component_class_by_index_const(
                   @handle, index)
        BTComponentClassFilter.new(handle, retain: true, auto_release: true)
      }
    end

    def get_sink_component_class_by_index(index)
      return nil if index >= get_sink_component_class_count
      handle = Babeltrace2.bt_plugin_borrow_sink_component_class_by_index_const(
                 @handle, index)
      BTComponentClassSink.new(handle, retain: true, auto_release: true)
    end

    def get_sink_component_class_by_name(name)
      handle = Babeltrace2.bt_plugin_borrow_sink_component_class_by_name_const(
                 @handle, name)
      return nil if handle.null?
      BTComponentClassSink.new(handle, retain: true, auto_release: true)
    end

    def get_sink_component_class(sink_component_class)
      case sink_component_class
      when String
        get_sink_component_class_by_name(sink_component_class)
      when Integer
        get_sink_component_class_by_index(sink_component_class)
      else
        raise TypeError, "wrong type for sink component class query"
      end
    end

    def sink_component_classes
      sink_component_class_count.times.collect { |index|
        handle = Babeltrace2.bt_plugin_borrow_sink_component_class_by_index_const(
                   @handle, index)
        BTComponentClassSink.new(handle, retain: true, auto_release: true)
      }
    end
  end

  attach_function :bt_plugin_set_get_plugin_count,
                  [ :bt_plugin_set_handle ],
                  :uint64

  attach_function :bt_plugin_set_borrow_plugin_by_index_const,
                  [ :bt_plugin_set_handle, :uint64 ],
                  :bt_plugin_handle

  attach_function :bt_plugin_set_get_ref,
                  [ :bt_plugin_set_handle ],
                  :void

  attach_function :bt_plugin_set_put_ref,
                  [ :bt_plugin_set_handle ],
                  :void

  class BTPlugin
    class Set < BTSharedObject
      @get_ref = :bt_plugin_set_get_ref
      @put_ref = :bt_plugin_set_put_ref

      def get_plugin_count
        Babeltrace2.bt_plugin_set_get_plugin_count(@handle)
      end
      alias plugin_count get_plugin_count
      alias size get_plugin_count

      def get_plugin_by_index(index)
        return nil if index >= get_plugin_count
        handle = Babeltrace2.bt_plugin_set_borrow_plugin_by_index_const(@handle, index)
        BTPlugin.new(handle, retain: true, auto_release: true)
      end

      def plugins
        get_plugin_count.times.collect { |index|
          handle = Babeltrace2.bt_plugin_set_borrow_plugin_by_index_const(@handle, index)
          BTPlugin.new(handle, retain: true, auto_release: true)
        }
      end
    end
  end
  BTPluginSet = BTPlugin::Set
end
