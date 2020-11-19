class BTQueryExecutorTest < Minitest::Test
  def setup
    @ctf_fs = BT2::BTPlugin.find("ctf").get_source_component_class_by_name("fs")
    @utils_muxer = BT2::BTPlugin.find("utils").get_filter_component_class_by_name("muxer")
  end

  def test_query
    params = BT2::BTValue.from_value({"input" => TRACE_PATH, "type" => "directory"})
    query_executor = BT2::BTQueryExecutor.new(
                       component_class: @ctf_fs,
                       object_name: "babeltrace.support-info",
                       params: params)
    assert_equal({"weight"=>0.0},  query_executor.query.value)
    params = BT2::BTValue.from_value({"input" => TRACE_LOCATION, "type" => "directory"})
    query_executor = BT2::BTQueryExecutor.new(
                       component_class: @ctf_fs,
                       object_name: "babeltrace.support-info",
                       params: params)
    assert_equal({"group"=>TRACE_UUID, "weight"=>0.75},
                 query_executor.query.value)
  end

  def test_logging_level
    params = BT2::BTValue.from_value({"foo" => "bar", "type" => "buzz"})
    query_executor = BT2::BTQueryExecutor.new(
      component_class: @ctf_fs,
      object_name: "babeltrace.support-info",
      params: params)
    assert_equal(:BT_LOGGING_LEVEL_NONE, query_executor.logging_level)
    query_executor.logging_level = :BT_LOGGING_LEVEL_DEBUG
    assert_equal(:BT_LOGGING_LEVEL_DEBUG, query_executor.logging_level)
  end

  def test_interrupted
    params = BT2::BTValue.from_value({"foo" => "bar", "type" => "buzz"})
    query_executor = BT2::BTQueryExecutor.new(
      component_class: @ctf_fs,
      object_name: "babeltrace.support-info",
      params: params)
    interrupter = BT2::BTInterrupter.new
    query_executor.add_interrupter(interrupter)
    refute(query_executor.interrupted?)
    interrupter.set!
    assert(query_executor.interrupted?)
    assert_raises "interrupted by user" do query_executor.query end
    interrupter.reset!
    refute(query_executor.interrupted?)
    assert_equal({"weight"=>0.0},  query_executor.query.value)
  end

  def test_default_interrupter
    params = BT2::BTValue.from_value({"foo" => "bar", "type" => "buzz"})
    query_executor = BT2::BTQueryExecutor.new(
      component_class: @ctf_fs,
      object_name: "babeltrace.support-info",
      params: params)
    interrupter = query_executor.default_interrupter
    query_executor.add_interrupter(interrupter)
    refute(query_executor.interrupted?)
    interrupter.set!
    assert_raises "interrupted by user" do query_executor.query end
    assert(query_executor.interrupted?)
    interrupter.reset!
    refute(query_executor.interrupted?)
    assert_equal({"weight"=>0.0},  query_executor.query.value)
  end
end
