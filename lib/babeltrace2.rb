require 'ffi'

module Babeltrace2
  extend FFI::Library
  ffi_lib "babeltrace2"
end

require_relative 'babeltrace2/func-status'
require_relative 'babeltrace2/logging-defs'
require_relative 'babeltrace2/logging'
require_relative 'babeltrace2/types'
require_relative 'babeltrace2/integer-range-set'
require_relative 'babeltrace2/value'
require_relative 'babeltrace2/version'
require_relative 'babeltrace2/graph/port'
require_relative 'babeltrace2/graph/connection'
require_relative 'babeltrace2/graph/component-class'
require_relative 'babeltrace2/graph/component'
require_relative 'babeltrace2/graph/self-component'
require_relative 'babeltrace2/graph/self-component-port'
require_relative 'babeltrace2/error-reporting'
require_relative 'babeltrace2/util'
require_relative 'babeltrace2/graph/component-class-dev'
require_relative 'babeltrace2/graph/self-component-class'
require_relative 'babeltrace2/graph/graph'
require_relative 'babeltrace2/graph/message-iterator'
require_relative 'babeltrace2/graph/message'
require_relative 'babeltrace2/graph/component-descriptor-set'
require_relative 'babeltrace2/graph/interrupter'
require_relative 'babeltrace2/graph/query-executor'
require_relative 'babeltrace2/graph/private-query-executor'

BT2 = Babeltrace2
