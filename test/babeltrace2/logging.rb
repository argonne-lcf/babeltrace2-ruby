class BTLoggingTest < Minitest::Test
  def test_logging
    lvl = BT2::BTLogging.global_level
    BT2::BTLogging.global_level = :BT_LOGGING_LEVEL_NONE
    assert_equal(:BT_LOGGING_LEVEL_NONE, BT2::BTLogging.global_level)
    BT2::BTLogging.global_level = BT2::BTLogging.minimal_level
    assert_equal(BT2::BTLogging.minimal_level, BT2::BTLogging.global_level)
    BT2::BTLogging.global_level = lvl
    assert_equal(lvl, BT2::BTLogging.global_level)
  end
end
