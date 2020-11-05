module Babeltrace2
  module BTSelfComponent
    module Class
      def self.from_handle(handle, retain: true, auto_release: true)
        case Babeltrace2.bt_component_class_get_type(handle)
        when :BT_COMPONENT_CLASS_TYPE_SOURCE
          BTSelfComponentClassSource
        when :BT_COMPONENT_CLASS_TYPE_FILTER
          BTSelfComponentClassFilter
        when :BT_COMPONENT_CLASS_TYPE_SINK
          BTSelfComponentClassSink
        else
          raise Error.new("Unknown component class type")
        end.new(handle, retain: retain, auto_release: auto_release)
      end
    end
  end
  BTSelfComponentClass = BTSelfComponent::Class

  class BTSelfComponent::Class::Source < BTComponentClassSource
    include BTSelfComponent::Class
  end
  BTSelfComponentClassSource = BTSelfComponent::Class::Source

  class BTSelfComponent::Class::Filter < BTComponentClassFilter
    include BTSelfComponent::Class
  end
  BTSelfComponentClassFilter = BTSelfComponent::Class::Filter

  class BTSelfComponent::Class::Sink < BTComponentClassSink
    include BTSelfComponent::Class
  end
  BTSelfComponentClassSink = BTSelfComponent::Class::Sink
end
