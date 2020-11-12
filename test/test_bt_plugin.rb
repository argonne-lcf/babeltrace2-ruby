[ '../lib', 'lib' ].each { |d| $:.unshift(d) if File::directory?(d) }
require 'minitest/autorun'
require 'babeltrace2'

class BTPluginTest < Minitest::Test
  def setup
    @ctf_plugin = BT2::BTPlugin.find("ctf")
    @utils_plugin = BT2::BTPlugin.find("utils")
    @text_plugin = BT2::BTPlugin.find("text")
  end

  def test_find_all
    plugins = BT2::BTPlugin.find_all
    assert(plugins.size > 1)
  end

  def test_find
    assert(@ctf_plugin)
  end

  def test_name
    assert_equal("ctf", @ctf_plugin.name)
  end

  def test_description
    assert_equal("CTF input and output", @ctf_plugin.description)
  end

  def test_author
    assert_equal("EfficiOS <https://www.efficios.com/>", @ctf_plugin.author)
  end

  def test_license
    assert_equal("MIT", @ctf_plugin.license)
  end

  def test_path
    assert(File.exist?(@ctf_plugin.path))
  end

  def test_version
    assert_nil(@ctf_plugin.version)
  end

  def test_source_component_classes
    assert_equal(0, @utils_plugin.source_component_classes.size)
    assert_equal(2, @ctf_plugin.source_component_classes.size)
    @ctf_plugin.source_component_classes.each { |c|
      assert_instance_of(BT2::BTComponentClassSource, c)
    }
  end

  def test_get_source_component_class_by_name
    @ctf_plugin.source_component_classes.each { |c|
      c2 = @ctf_plugin.get_source_component_class_by_name(c.name)
      assert_instance_of(BT2::BTComponentClassSource, c2)
      assert_equal(c.handle, c2.handle)
    }
    assert_nil(@ctf_plugin.get_source_component_class_by_name("foo"))
  end

  def test_get_source_component_class_by_index
    @ctf_plugin.source_component_classes.each_with_index { |c, index|
      c2 = @ctf_plugin.get_source_component_class_by_index(index)
      assert_instance_of(BT2::BTComponentClassSource, c2)
      assert_equal(c.handle, c2.handle)
    }
    assert_nil(@ctf_plugin.get_source_component_class_by_index(@ctf_plugin.get_source_component_class_count))
  end

  def test_filter_component_classes
    assert_equal([], @ctf_plugin.filter_component_classes)
    assert_equal(2, @utils_plugin.filter_component_classes.size)
    @utils_plugin.filter_component_classes.each { |c|
      assert_instance_of(BT2::BTComponentClassFilter, c)
    }
  end

  def test_get_filter_component_class_by_name
    @utils_plugin.filter_component_classes.each { |c|
      c2 = @utils_plugin.get_filter_component_class_by_name(c.name)
      assert_instance_of(BT2::BTComponentClassFilter, c2)
      assert_equal(c.handle, c2.handle)
    }
    assert_nil(@utils_plugin.get_filter_component_class_by_name("foo"))
  end

  def test_get_filter_component_class_by_index
    @utils_plugin.filter_component_classes.each_with_index { |c, index|
      c2 = @utils_plugin.get_filter_component_class_by_index(index)
      assert_instance_of(BT2::BTComponentClassFilter, c2)
      assert_equal(c.handle, c2.handle)
    }
    assert_nil(@utils_plugin.get_filter_component_class_by_index(@utils_plugin.get_filter_component_class_count))
  end

  def test_sink_component_classes
    assert_equal(2, @text_plugin.sink_component_classes.size)
    @text_plugin.sink_component_classes.each { |c|
      assert_instance_of(BT2::BTComponentClassSink, c)
    }
  end

  def test_get_sink_component_class_by_name
    @text_plugin.sink_component_classes.each { |c|
      c2 = @text_plugin.get_sink_component_class_by_name(c.name)
      assert_instance_of(BT2::BTComponentClassSink, c2)
      assert_equal(c.handle, c2.handle)
    }
    assert_nil(@text_plugin.get_sink_component_class_by_name("foo"))
  end

  def test_get_sink_component_class_by_index
    @text_plugin.sink_component_classes.each_with_index { |c, index|
      c2 = @text_plugin.get_sink_component_class_by_index(index)
      assert_instance_of(BT2::BTComponentClassSink, c2)
      assert_equal(c.handle, c2.handle)
    }
    assert_nil(@text_plugin.get_sink_component_class_by_index(@text_plugin.get_sink_component_class_count))
  end

end
