[ '../lib', 'lib' ].each { |d| $:.unshift(d) if File::directory?(d) }
require 'minitest/autorun'
require 'babeltrace2'

class BTIntegerRangeSetTest < Minitest::Test
  def test_unsigned
    res = [1..1, 2..5, 7..8, 11..14]
    range_set = BT2::BTIntegerRangeSetUnsigned.new
    assert_equal(0, range_set.size)
    range_set.push(1, 2..5, [7,8], 11...15)
    assert_equal(4, range_set.size)
    assert_equal(res, range_set.value)
    range_set2 = BT2::BTIntegerRangeSetUnsigned.new
    range_set2.push(1, 2..5, [7,8])
    refute_equal(range_set, range_set2)
    range_set2.push(11...15)
    assert_equal(range_set, range_set2)
    range_set3 = BT2::BTIntegerRangeSetUnsigned.from_value(res)
    assert_equal(range_set, range_set3)
  end

  def test_signed
    res = [-1..-1, 2..5, 7..8, 11..14]
    range_set = BT2::BTIntegerRangeSetSigned.new
    assert_equal(0, range_set.size)
    range_set.push(-1, 2..5, [7,8], 11...15)
    assert_equal(4, range_set.size)
    assert_equal(res, range_set.value)
    range_set2 = BT2::BTIntegerRangeSetSigned.new
    range_set2.push(-1, 2..5, [7,8])
    refute_equal(range_set, range_set2)
    range_set2.push(11...15)
    assert_equal(range_set, range_set2)
    range_set3 = BT2::BTIntegerRangeSetSigned.from_value(res)
    assert_equal(range_set, range_set3)
  end
end

