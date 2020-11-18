[ '../lib', 'lib' ].each { |d| $:.unshift(d) if File::directory?(d) }
require 'minitest/autorun'
require 'babeltrace2'

class BTVersionTest <Minitest::Test
  def test_number
    v = BT2::BTVersion.number
    assert_match(/\d+\.\d+\.\d+/, v.to_s)
    BT2::BTVersion.development_stage
    BT2::BTVersion.vcs_revision_description
    BT2::BTVersion.name
    BT2::BTVersion.name_description
    BT2::BTVersion.extra_name
    BT2::BTVersion.extra_description
    BT2::BTVersion.extra_patch_names
  end
end
