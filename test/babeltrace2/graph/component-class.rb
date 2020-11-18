class BTComponentClassTest < Minitest::Test
  def setup
    @ctf_fs = BT2::BTPlugin.find("ctf").get_source_component_class_by_name("fs")
    @utils_muxer = BT2::BTPlugin.find("utils").get_filter_component_class_by_name("muxer")
    @text_pretty = BT2::BTPlugin.find("text").get_sink_component_class_by_name("pretty")
  end

  def test_name
    assert_equal("fs", @ctf_fs.name)
  end

  def test_description
    assert_equal("Read CTF traces from the file system.", @ctf_fs.description)
  end

  def test_help
    assert_match(/See the babeltrace2-source\.ctf\.fs\(\d\) manual page\./, @ctf_fs.help)
  end

  def test_type
    assert_equal(:BT_COMPONENT_CLASS_TYPE_SOURCE, @ctf_fs.type)
    assert(@ctf_fs.source?)
    refute(@ctf_fs.filter?)
    refute(@ctf_fs.sink?)
    assert_equal(:BT_COMPONENT_CLASS_TYPE_FILTER, @utils_muxer.type)
    assert(@utils_muxer.filter?)
    assert_equal(:BT_COMPONENT_CLASS_TYPE_SINK, @text_pretty.type)
    assert(@text_pretty.sink?)
  end
end
