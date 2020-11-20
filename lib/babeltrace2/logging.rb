module Babeltrace2
  BTLoggingLevel = enum :bt_logging_level,
    [ :BT_LOGGING_LEVEL_TRACE, BT_LOGGING_LEVEL_TRACE,
      :BT_LOGGING_LEVEL_DEBUG, BT_LOGGING_LEVEL_DEBUG,
      :BT_LOGGING_LEVEL_INFO, BT_LOGGING_LEVEL_INFO,
      :BT_LOGGING_LEVEL_WARNING, BT_LOGGING_LEVEL_WARNING,
      :BT_LOGGING_LEVEL_ERROR, BT_LOGGING_LEVEL_ERROR,
      :BT_LOGGING_LEVEL_FATAL, BT_LOGGING_LEVEL_FATAL,
      :BT_LOGGING_LEVEL_NONE, BT_LOGGING_LEVEL_NONE ]

  attach_function :bt_logging_set_global_level,
                  [:bt_logging_level],
                  :void

  attach_function :bt_logging_get_global_level,
                  [],
                  :bt_logging_level

  attach_function :bt_logging_get_minimal_level,
                  [],
                  :bt_logging_level

  module BTLogging
    class << self
      def set_global_level(logging_level)
        Babeltrace2.bt_logging_set_global_level(logging_level)
        self
      end

      def global_level=(logging_level)
        set_global_level(logging_level)
        logging_level
      end

      def get_global_level
        Babeltrace2.bt_logging_get_global_level
      end
      alias global_level get_global_level

      def get_minimal_level
        Babeltrace2.bt_logging_get_minimal_level
      end
      alias minimal_level get_minimal_level
    end
  end
end
