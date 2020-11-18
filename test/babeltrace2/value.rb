class BTValueTest < Minitest::Test
  def test_null
    n = BT2::BTValueNull.instance
    assert_equal(:BT_VALUE_TYPE_NULL, n.type)
    assert_nil(n.value)
    assert_instance_of(BT2::BTValueNull, n)
    assert_equal(n, BT2::BTValue.from_value(nil))
    assert_equal(n, n.copy)
    assert_equal(n, BT2::BTValue.from_handle(n.handle))
  end

  def test_bool
    b1 = BT2::BTValueBool.new
    b2 = BT2::BTValueBool.new(value: true)
    assert_equal(:BT_VALUE_TYPE_BOOL, b1.type)
    assert_equal(:BT_VALUE_TYPE_BOOL, b2.type)
    assert_instance_of(BT2::BTValueBool, b1)
    assert_instance_of(BT2::BTValueBool, b2)
    b1.value = false
    refute_equal(b1, b2)
    assert_equal(false, b1.value)
    assert_equal(true, b2.value)
    assert_equal(b1, b1.copy)
    assert_equal(false, BT2::BTValue.from_value(false).value)
    assert_equal(true, BT2::BTValue.from_value(true).value)
    assert_equal(false, BT2::BTValue.from_handle(b1.handle).value)
    assert_equal(true, BT2::BTValue.from_handle(b2.handle).value)
  end

  def test_integer_unsigned
    v1 = rand(100000) + 1
    v2 = v1 + rand(100000) + 1
    i1 = BT2::BTValueIntegerUnsigned.new
    i2 = BT2::BTValueIntegerUnsigned.new(value: v2)
    assert_equal(:BT_VALUE_TYPE_UNSIGNED_INTEGER, i1.type)
    assert_equal(:BT_VALUE_TYPE_UNSIGNED_INTEGER, i2.type)
    assert_instance_of(BT2::BTValueIntegerUnsigned, i1)
    assert_instance_of(BT2::BTValueIntegerUnsigned, i2)
    i1.value = v1
    refute_equal(i1, i2)
    assert_equal(v1, i1.value)
    assert_equal(v2, i2.value)
    assert_equal(i2, i2.copy)
    refute_equal(i2.handle, i2.copy.handle)
    assert_equal(v2, BT2::BTValue.from_value(v2).value)
    assert_equal(v2, BT2::BTValue.from_handle(i2.handle).value)
  end

  def test_integer_signed
    v1 = - rand(100000) - 1
    v2 = v1 - rand(100000) - 1
    i1 = BT2::BTValueIntegerSigned.new
    i2 = BT2::BTValueIntegerSigned.new(value: v2)
    assert_equal(:BT_VALUE_TYPE_SIGNED_INTEGER, i1.type)
    assert_equal(:BT_VALUE_TYPE_SIGNED_INTEGER, i2.type)
    assert_instance_of(BT2::BTValueIntegerSigned, i1)
    assert_instance_of(BT2::BTValueIntegerSigned, i2)
    i1.value = v1
    refute_equal(i1, i2)
    assert_equal(v1, i1.value)
    assert_equal(v2, i2.value)
    assert_equal(i2, i2.copy)
    refute_equal(i2.handle, i2.copy.handle)
    assert_equal(v2, BT2::BTValue.from_value(v2).value)
    assert_equal(v2, BT2::BTValue.from_handle(i2.handle).value)
  end

  def test_real
    v1 = rand
    v2 = v1 + rand + 1.0
    r1 = BT2::BTValueReal.new
    r2 = BT2::BTValueReal.new(value: v2)
    assert_equal(:BT_VALUE_TYPE_REAL, r1.type)
    assert_equal(:BT_VALUE_TYPE_REAL, r2.type)
    assert_instance_of(BT2::BTValueReal, r1)
    assert_instance_of(BT2::BTValueReal, r2)
    r1.value = v1
    refute_equal(r1, r2)
    assert_equal(v1, r1.value)
    assert_equal(v2, r2.value)
    assert_equal(r2, r2.copy)
    refute_equal(r2.handle, r2.copy.handle)
    assert_equal(v2, BT2::BTValue.from_value(v2).value)
    assert_equal(v2, BT2::BTValue.from_handle(r2.handle).value)
  end

  def test_string
    v1 = "foo"
    v2 = "bar"
    s1 = BT2::BTValueString.new
    s2 = BT2::BTValueString.new(value: v2)
    assert_equal(:BT_VALUE_TYPE_STRING, s1.type)
    assert_equal(:BT_VALUE_TYPE_STRING, s2.type)
    assert_instance_of(BT2::BTValueString, s1)
    assert_instance_of(BT2::BTValueString, s2)
    s1.value = v1
    refute_equal(s1, s2)
    assert_equal(v1, s1.value)
    assert_equal(v2, s2.value)
    assert_equal(s2, s2.copy)
    refute_equal(s2.handle, s2.copy.handle)
    assert_equal(v2, BT2::BTValue.from_value(v2).value)
    assert_equal(v2, BT2::BTValue.from_handle(s2.handle).value)
  end

  def test_array
    v = [ 1 , 2.0, "foo", nil, true, false, [ 5 ], {"bar" => 1} ]
    a = BT2::BTValueArray::new
    assert_equal(:BT_VALUE_TYPE_ARRAY, a.type)
    assert_instance_of(BT2::BTValueArray, a)
    assert_equal([], a.value)
    v.each { |e|
      a.push(e)
    }
    assert_equal(v, a.value)
    v.each_with_index { |e, i|
      e.nil? ? assert_nil(a[i].value) : assert_equal(e, a[i].value)
    }
    assert_raises(IndexError) { a[v.length] }
    assert_raises(IndexError) { a[-1] }
    a[2] = 0
    assert_equal(0, a[2].value)
    a[2] = "foo"
    assert_equal(a, a.copy)
    refute_equal(a.handle, a.copy.handle)
    assert_equal(v, BT2::BTValue.from_value(v).value)
    assert_equal(v, BT2::BTValue.from_handle(a.handle).value)
  end

  def test_map
    v = {
      "a" => 1,
      "b" => 2.0,
      "c" => "foo",
      :d => nil,
      "e" => true,
      "f" => false,
      "g" => [ 5 ],
      "h" => {:bar => 1} }
    a = BT2::BTValueMap::new
    assert_equal(:BT_VALUE_TYPE_MAP, a.type)
    assert_instance_of(BT2::BTValueMap, a)
    assert_equal({}, a.value)
    v.each { |key, val|
      a[key] = val
    }
    assert_equal(v, a.value)
    v.each { |key, val|
      val.nil? ? assert_nil(a[key].value) : assert_equal(val, a[key].value)
    }
    assert_nil(a["d"])
    a[:d] = 0
    assert_equal(0, a[:d].value)
    a[:d] = nil
    assert_equal(a, a.copy)
    refute_equal(a.handle, a.copy.handle)
    assert_equal(v, BT2::BTValue.from_value(v).value)
    assert_equal(v, BT2::BTValue.from_handle(a.handle).value)
  end
end
