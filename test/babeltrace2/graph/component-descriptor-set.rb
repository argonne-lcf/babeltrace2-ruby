class BTComponentDescriptorSetTest < Minitest::Test
  def setup
    @ctf_fs = BT2::BTPlugin.find("ctf").get_source_component_class_by_name("fs")
    @utils_muxer = BT2::BTPlugin.find("utils").get_filter_component_class_by_name("muxer")
    @text_pretty = BT2::BTPlugin.find("text").get_sink_component_class_by_name("pretty")
  end

  def test_descriptor_set
    set = BT2::BTComponentDescriptorSet.new
    set.add_descriptor(@ctf_fs, params: {"inputs" => [TRACE_LOCATION]})
    set.add_descriptor(@utils_muxer)
    set.add_descriptor(@text_pretty)
    assert_equal(0, set.get_greatest_operative_mip_version)
  end
end
