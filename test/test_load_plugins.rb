[ '../lib', 'lib' ].each { |d| $:.unshift(d) if File::directory?(d) }
require 'minitest/autorun'
require 'babeltrace2'

class BTPluginTest < Minitest::Test
  def setup
    @cft_plugin = BT2::BTPlugin.find("ctf")
    @utils_plugin = BT2::BTPlugin.find("utils")
    @text_plugin = BT2::BTPlugin.find("text")
  end

  def test_find_all
    plugins = BT2::BTPlugin.find_all
    assert(plugins.size > 1)
  end

  def test_find
    assert(@cft_plugin)
  end

  def test_name
    assert_equal("ctf", @cft_plugin.name)
  end

  def test_description
    assert_equal("CTF input and output", @cft_plugin.description)
  end

  def test_author
    assert_equal("EfficiOS <https://www.efficios.com/>", @cft_plugin.author)
  end

  def test_license
    assert_equal("MIT", @cft_plugin.license)
  end

  def test_path
    assert(File.exist?(@cft_plugin.path))
  end

  def test_version
    assert_nil(@cft_plugin.version)
  end

  def test_source_component_classes
    assert_equal(0, @utils_plugin.source_component_classes.size)
    assert_equal(2, @cft_plugin.source_component_classes.size)
  end

  def test_get_source_component_class_by_name
    @cft_plugin.source_component_classes.each { |c|
      assert_equal(c.handle, @cft_plugin.get_source_component_class_by_name(c.name).handle)
    }
    assert_nil(@cft_plugin.get_source_component_class_by_name("foo"))
  end

  def test_get_source_component_class_by_index
    @cft_plugin.source_component_classes.each_with_index { |c, index|
      assert_equal(c.handle, @cft_plugin.get_source_component_class_by_index(index).handle)
    }
    assert_nil(@cft_plugin.get_source_component_class_by_index(@cft_plugin.get_source_component_class_count))
  end

  def test_filter_component_classes
    assert_equal([], @cft_plugin.filter_component_classes)
    assert_equal(2, @utils_plugin.filter_component_classes.size)
  end

  def test_get_filter_component_class_by_name
    @utils_plugin.filter_component_classes.each { |c|
      assert_equal(c.handle, @utils_plugin.get_filter_component_class_by_name(c.name).handle)
    }
    assert_nil(@utils_plugin.get_filter_component_class_by_name("foo"))
  end

  def test_get_filter_component_class_by_index
    @utils_plugin.filter_component_classes.each_with_index { |c, index|
      assert_equal(c.handle, @utils_plugin.get_filter_component_class_by_index(index).handle)
    }
    assert_nil(@utils_plugin.get_filter_component_class_by_index(@utils_plugin.get_filter_component_class_count))
  end

  def test_sink_component_classes
    assert_equal(2, @text_plugin.sink_component_classes.size)
  end

  def test_get_sink_component_class_by_name
    @text_plugin.sink_component_classes.each { |c|
      assert_equal(c.handle, @text_plugin.get_sink_component_class_by_name(c.name).handle)
    }
    assert_nil(@text_plugin.get_sink_component_class_by_name("foo"))
  end

  def test_get_sink_component_class_by_index
    @text_plugin.sink_component_classes.each_with_index { |c, index|
      assert_equal(c.handle, @text_plugin.get_sink_component_class_by_index(index).handle)
    }
    assert_nil(@text_plugin.get_sink_component_class_by_index(@text_plugin.get_sink_component_class_count))
  end

end
