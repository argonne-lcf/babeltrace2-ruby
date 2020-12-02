require 'digest'

module Babeltrace2
  class UserPlugin
    attr_reader :name
    attr_reader :author
    attr_reader :description
    attr_reader :license
    attr_accessor :path
    attr_reader :major
    attr_reader :minor
    attr_reader :patch
    attr_reader :version_extra

    def initialize(name:, author: nil, description: nil, license: nil, path: nil,
                   major: 0, minor: 0, patch: 0, version_extra: nil)
      @name = name
      @author = author
      @description = description
      @license = license
      @path = path
      @major = major.to_i
      @minor = minor.to_i
      @patch = patch.to_i
      @version_extra = version_extra
      @component_classes = []
      @user_component_classes = []
    end

    def user_component_classes
      @user_component_classes
    end

    alias get_name name
    alias get_description description
    alias get_author author
    alias get_license license
    alias get_path path

    def get_version
      BTVersion::Number.new(major, minor, patch, extra)
    end
    alias version get_version

    def get_component_classes
      @component_classes
    end
    alias component_classes get_component_classes

    def get_component_class_addresses
      get_component_classes.collect { |c|
        c.handle.to_ptr.to_i
      }
    end
    alias component_class_addresses get_component_class_addresses

    def get_source_component_classes
      @component_classes.select { |c| c.source? }
    end
    alias source_component_classes get_source_component_classes

    def get_source_component_class_count
      get_source_component_classes.count
    end
    alias source_component_class_count get_source_component_class_count

    def get_filter_component_classes
      @component_classes.select { |c| c.filter? }
    end
    alias filter_component_classes get_filter_component_classes

    def get_filter_component_class_count
      get_filter_component_classes.count
    end
    alias filter_component_class_count get_filter_component_class_count

    def get_sink_component_classes
      @component_classes.select { |c| c.sink? }
    end
    alias sink_component_classes get_sink_component_classes

    def get_sink_component_class_count
      get_sink_component_classes.count
    end
    alias sink_component_class_count get_sink_component_class_count

    def get_source_component_class_by_index(index)
      get_source_component_classes[index]
    end

    def get_filter_component_class_by_index(index)
      get_filter_component_classes[index]
    end

    def get_sink_component_class_by_index(index)
      get_sink_component_classes[index]
    end

    def get_source_component_class_by_name(name)
      get_source_component_classes.find { |c| c.name == name }
    end

    def get_filter_component_class_by_name(name)
      get_filter_component_classes.find { |c| c.name == name }
    end

    def get_sink_component_class_by_name(name)
      get_sink_component_classes.find { |c| c.name == name }
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

    def register_component_class(component)
      raise "component with same name and type already exist" if @component_classes.find { |c| c.type == component.type && c.name == component.name}
      if component.kind_of?(Class) && component < UserComponentClass
        component = component.new
        @user_component_classes.push component
        component = component.bt_component_class
      end
      @component_classes.push component
      self
    end
    alias register_component register_component_class
    alias register register_component_class
    alias push register_component_class
  end

  module GetMethod
    private
    def get_method(name, arity)
      return nil unless self.class.method_defined?(name)
      method = self.method(name)
      raise "'#{name}' method must take #{arity} argument#{arity > 1 ? "s" : ""}" unless method.arity == arity
      method
    end
  end

  class UserMessageIterator
    include GetMethod
    attr_reader :bt_message_iterator

    def initialize
      next_method = get_method(:next, 2)
      raise "'next' method must be defined" unless next_method
      finalize_method = get_method(:finalize, 1)
      initialize_method = get_method(:init, 3)
      seek_beginning_method = get_method(:seek_beginning, 1)
      can_seek_beginning_method = get_method(:can_seek_beginning, 1)
      seek_ns_from_origin_method = get_method(:seek_ns_from_origin, 2)
      can_seek_ns_from_origin_method = get_method(:can_seek_ns_from_origin, 2)
      @bt_message_iterator = BTMessageIteratorClass.new(next_method: next_method)
      @bt_message_iterator.finalize_method = finalize_method if finalize_method
      @bt_message_iterator.initialize_method = initialize_method if initialize_method
      if seek_beginning_method
        @bt_message_iterator.set_seek_beginning_methods(seek_beginning_method, can_seek_method: can_seek_beginning_method)
      end
      if seek_ns_from_origin_method
        @bt_message_iterator.set_seek_ns_from_origin_methods(seek_ns_from_origin_method, can_seek_method: can_seek_ns_from_origin_method)
      end
    end
  end

  class UserComponentClass
    include GetMethod
    attr_reader :bt_component_class
    class << self
      def get_name
        @name ||= name.split("::").last
      end
      attr_accessor :description
      attr_accessor :help
    end
  end

  class UserSource < UserComponentClass
    class << self
      attr_accessor :message_iterator_class
      def type
        :BT_COMPONENT_CLASS_TYPE_SOURCE
      end
    end
    attr_reader :user_message_iterator_class
    def initialize
      message_iterator_class = self.class.message_iterator_class
      raise "'message_iterator_class' sould be defined" unless message_iterator_class
      if message_iterator_class.kind_of?(Class) && message_iterator_class < UserMessageIterator
        message_iterator_class = message_iterator_class.new
        @user_message_iterator_class = message_iterator_class
        message_iterator_class = message_iterator_class.bt_message_iterator
      end
      raise "'message_iterator_class' sould be an instance of UserMessageIterator or BTMessageIteratorClass" unless message_iterator_class.kind_of?(BTMessageIteratorClass)
      finalize_method = get_method(:finalize, 1)
      get_supported_mip_versions_method = get_method(:get_supported_mip_versions, 5)
      initialize_method = get_method(:init, 4)
      query_method = get_method(:query, 5)
      output_port_connected_method = get_method(:output_port_connected, 3)
      name = self.class.get_name
      description = self.class.description
      help = self.class.help
      @bt_component_class = BTComponentClassSource.new(
         name: name,
         message_iterator_class: message_iterator_class)
      @bt_component_class.description = description if description
      @bt_component_class.help = help if help
      @bt_component_class.finalize_method = finalize_method if finalize_method
      @bt_component_class.initialize_method = initialize_method if initialize_method
      @bt_component_class.get_supported_mip_versions_method = get_supported_mip_versions_method if get_supported_mip_versions_method
      @bt_component_class.query_method = query_method if query_method
      @bt_component_class.output_port_connected_method = output_port_connected_method if output_port_connected_method
    end
  end

  class UserFilter < UserComponentClass
    class << self
      attr_accessor :message_iterator_class
      def type
        :BT_COMPONENT_CLASS_TYPE_FILTER
      end
    end
    attr_reader :user_message_iterator_class
    def initialize
      message_iterator_class = self.class.message_iterator_class
      raise "'message_iterator_class' sould be defined" unless message_iterator_class
      if message_iterator_class.kind_of?(Class) && message_iterator_class < UserMessageIterator
        message_iterator_class = message_iterator_class.new
        @user_message_iterator_class = message_iterator_class
        message_iterator_class = message_iterator_class.bt_message_iterator
      end
      finalize_method = get_method(:finalize, 1)
      get_supported_mip_versions_method = get_method(:get_supported_mip_versions, 5)
      initialize_method = get_method(:init, 4)
      query_method = get_method(:query, 5)
      input_port_connected_method = get_method(:input_port_connected, 3)
      output_port_connected_method = get_method(:output_port_connected, 3)
      name = self.class.get_name
      description = self.class.description
      help = self.class.help
      @bt_component_class = BTComponentClassFilter.new(
         name: name,
         message_iterator_class: message_iterator_class)
      @bt_component_class.description = description if description
      @bt_component_class.help = help if help
      @bt_component_class.finalize_method = finalize_method if finalize_method
      @bt_component_class.initialize_method = initialize_method if initialize_method
      @bt_component_class.get_supported_mip_versions_method = get_supported_mip_versions_method if get_supported_mip_versions_method
      @bt_component_class.query_method = query_method if query_method
      @bt_component_class.input_port_connected_method = input_port_connected_method if input_port_connected_method
      @bt_component_class.output_port_connected_method = output_port_connected_method if output_port_connected_method
    end
  end

  class UserSink < UserComponentClass
    class << self
      def type
        :BT_COMPONENT_CLASS_TYPE_SINK
      end
    end
    def initialize
      consume_method = get_method(:consume, 1)
      raise "'consum' method must be defined" unless consume_method
      finalize_method = get_method(:finalize, 1)
      get_supported_mip_versions_method = get_method(:get_supported_mip_versions, 5)
      initialize_method = get_method(:init, 4)
      query_method = get_method(:query, 5)
      graph_is_configured_method = get_method(:graph_is_configured, 1)
      input_port_connected_method = get_method(:input_port_connected, 3)
      name = self.class.get_name
      description = self.class.description
      help = self.class.help
      @bt_component_class = BTComponentClassSink.new(name: name, consume_method: consume_method)
      @bt_component_class.description = description if description
      @bt_component_class.help = help if help
      @bt_component_class.finalize_method = finalize_method if finalize_method
      @bt_component_class.initialize_method = initialize_method if initialize_method
      @bt_component_class.get_supported_mip_versions_method = get_supported_mip_versions_method if get_supported_mip_versions_method
      @bt_component_class.query_method = query_method if query_method
      @bt_component_class.graph_is_configured_method = graph_is_configured_method if graph_is_configured_method
      @bt_component_class.input_port_connected_method = input_port_connected_method if input_port_connected_method
    end
  end

  @@native_plugins = {}

  @@user_plugins = []

  def self.register_user_plugin(plugin)
    @@user_plugins.push(plugin)
  end

  def self.load_plugin_file(path)
    return [] unless File.exist?(path)
    hash = Digest::SHA256.file(path)
    return @@native_plugins[hash] if @@native_plugins.include?(hash)
    @@user_plugins = []
    str = ""
    str << "module Mod#{hash}; class << self; def register_user_plugin(plugin); Babeltrace2.register_user_plugin(plugin); end; alias register_plugin register_user_plugin; alias register register_user_plugin; end; "
    str << File.read(path) << "; end"
    eval(str, nil, path)
    @@user_plugins.each { |p|
      p.path = path unless p.path
    }
    @@native_plugins[hash] = @@user_plugins
  end
end
