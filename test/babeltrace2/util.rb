class BTUtilTest < Minitest::Test

  def test_util
    assert_equal(1000001500,
      BT2::BTUtil.clock_cycles_to_ns_from_origin(50, 100000000, 1, 100))
  end

end
