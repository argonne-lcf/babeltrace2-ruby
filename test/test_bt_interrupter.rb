[ '../lib', 'lib' ].each { |d| $:.unshift(d) if File::directory?(d) }
require 'minitest/autorun'
require 'babeltrace2'

class BTInterrupterTest < Minitest::Test
  def test_set
    interrupter = BT2::BTInterrupter.new
    refute(interrupter.set?)
    interrupter.set!
    assert(interrupter.set?)
    interrupter.set!
    assert(interrupter.set?)
    interrupter.reset!
    refute(interrupter.set?)
    interrupter.reset!
    refute(interrupter.set?)
  end
end
