class BTVersionTest <Minitest::Test
  def test_number
    v = BT2::BTVersion.number
    assert_match(/#{BT2::BTVersion.major}\.#{BT2::BTVersion.minor}\.#{BT2::BTVersion.patch}/, v.to_s)
    v = BT2::BTVersion.development_stage
    assert(v.nil? || v.kind_of?(String))
    v = BT2::BTVersion.vcs_revision_description
    assert(v.nil? || v.kind_of?(String))
    v = BT2::BTVersion.name
    assert(v.nil? || v.kind_of?(String))
    v = BT2::BTVersion.name_description
    assert(v.nil? || v.kind_of?(String))
    v = BT2::BTVersion.extra_name
    assert(v.nil? || v.kind_of?(String))
    v = BT2::BTVersion.extra_description
    assert(v.nil? || v.kind_of?(String))
    v = BT2::BTVersion.extra_patch_names
    assert(v.nil? || v.kind_of?(String))
  end
end
