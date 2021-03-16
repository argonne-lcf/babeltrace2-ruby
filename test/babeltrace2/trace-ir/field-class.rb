class BTFieldClassTest < Minitest::Test
  def test_field_class
    stream_beginning_count = 0
    stream_end_count = 0
    consume = lambda { |iterator, _|
      mess = iterator.next_messages
      mess.each { |m|
        case m.type
        when :BT_MESSAGE_TYPE_STREAM_BEGINNING
          stream_beginning_count += 1
        when :BT_MESSAGE_TYPE_STREAM_END
          stream_end_count += 1
        end
      }
    }

    states = [
      :BT_MESSAGE_TYPE_STREAM_BEGINNING,
      :BT_MESSAGE_TYPE_STREAM_END ]
    index = 0
    trace_class = nil
    stream_class = nil
    trace = nil
    stream = nil

    next_method = lambda { |it, capacity|
      return [] if capacity == 0
      m = case states[index]
        when :BT_MESSAGE_TYPE_STREAM_BEGINNING
          BT2::BTMessage::StreamBeginning.new(self_message_iterator: it, stream: stream)
        when :BT_MESSAGE_TYPE_STREAM_END
          BT2::BTMessage::StreamEnd.new(self_message_iterator: it, stream: stream)
        when nil
          raise StopIteration
        else
          raise "invalid state"
        end
      index += 1
      [m]
    }

    comp_initialize_method = lambda { |self_component, configuration, params, data|
      self_component.add_output_port("p0")
      trace_class = BT2::BTTraceClass.new(self_component: self_component)

      f = BT2::BTFieldClassBool.new(trace_class: trace_class)
      assert_equal(:BT_FIELD_CLASS_TYPE_BOOL, f.type)
      assert_instance_of(BT2::BTFieldClassBool,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal({}, f.user_attributes.value)
      f.user_attributes = { "foo" => 15 }
      assert_equal({ "foo" => 15 }, f.user_attributes.value)

      f = BT2::BTFieldClassBitArray.new(trace_class: trace_class, length: 12)
      assert_equal(:BT_FIELD_CLASS_TYPE_BIT_ARRAY, f.type)
      assert_instance_of(BT2::BTFieldClassBitArray,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal(12, f.length)

      f = BT2::BTFieldClassIntegerUnsigned.new(trace_class: trace_class)
      assert_equal(:BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER, f.type)
      assert_instance_of(BT2::BTFieldClassIntegerUnsigned,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal(64, f.field_value_range)
      f.field_value_range = 32
      assert_equal(32, f.field_value_range)
      assert_equal(:BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_DECIMAL,
                   f.preferred_display_base)
      f.preferred_display_base = :BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_HEXADECIMAL
      assert_equal(:BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_HEXADECIMAL,
                   f.preferred_display_base)
      f.preferred_display_base = 8
      assert_equal(:BT_FIELD_CLASS_INTEGER_PREFERRED_DISPLAY_BASE_OCTAL,
                   f.preferred_display_base)
      assert_equal(8, f.preferred_display_base_integer)

      f = BT2::BTFieldClassIntegerSigned.new(trace_class: trace_class)
      assert_equal(:BT_FIELD_CLASS_TYPE_SIGNED_INTEGER, f.type)
      assert_instance_of(BT2::BTFieldClassIntegerSigned,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal(64, f.field_value_range)

      f = BT2::BTFieldClassRealSinglePrecision.new(trace_class: trace_class)
      assert_equal(:BT_FIELD_CLASS_TYPE_SINGLE_PRECISION_REAL, f.type)
      assert_instance_of(BT2::BTFieldClassRealSinglePrecision,
                         BT2::BTFieldClass.from_handle(f.handle))

      f = BT2::BTFieldClassRealDoublePrecision.new(trace_class: trace_class)
      assert_equal(:BT_FIELD_CLASS_TYPE_DOUBLE_PRECISION_REAL, f.type)
      assert_instance_of(BT2::BTFieldClassRealDoublePrecision,
                         BT2::BTFieldClass.from_handle(f.handle))

      f = BT2::BTFieldClassEnumerationUnsigned.new(trace_class: trace_class)
      assert_equal(:BT_FIELD_CLASS_TYPE_UNSIGNED_ENUMERATION, f.type)
      assert_instance_of(BT2::BTFieldClassEnumerationUnsigned,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal(0, f.mapping_count)
      f.add_mapping("foo", [1..5, [7,9], 15])
      assert_equal(1, f.mapping_count)
      f.add_mapping(:bar, 4..6)
      assert_equal(2, f.mapping_count)
      assert_equal("foo", f.mapping(0).label)
      assert_equal([1..5, 7..9, 15..15], f.mapping("foo").ranges.value)
      assert_equal(:bar, f.mapping(1).label)
      assert_equal([4..6], f.mapping(:bar).ranges.value)
      assert_equal([], f.get_mapping_labels_for_value(0))
      assert_equal(["foo"], f.get_mapping_labels_for_value(8))
      assert_equal([:bar], f.get_mapping_labels_for_value(6))
      assert_equal(["foo", :bar], f.get_mapping_labels_for_value(5))

      f = BT2::BTFieldClassEnumerationSigned.new(trace_class: trace_class)
      assert_equal(:BT_FIELD_CLASS_TYPE_SIGNED_ENUMERATION, f.type)
      assert_instance_of(BT2::BTFieldClassEnumerationSigned,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal(0, f.mapping_count)
      f.add_mapping("foo", [-1..5, [7,9], 15])
      assert_equal(1, f.mapping_count)
      f.add_mapping(:bar, 4..6)
      assert_equal(2, f.mapping_count)
      assert_equal("foo", f.mapping(0).label)
      assert_equal([-1..5, 7..9, 15..15], f.mapping("foo").ranges.value)
      assert_equal(:bar, f.mapping(1).label)
      assert_equal([4..6], f.mapping(:bar).ranges.value)
      assert_equal([], f.get_mapping_labels_for_value(-2))
      assert_equal(["foo"], f.get_mapping_labels_for_value(8))
      assert_equal([:bar], f.get_mapping_labels_for_value(6))
      assert_equal(["foo", :bar], f.get_mapping_labels_for_value(5))

      f = BT2::BTFieldClassString.new(trace_class: trace_class)
      assert_equal(:BT_FIELD_CLASS_TYPE_STRING, f.type)
      assert_instance_of(BT2::BTFieldClassString,
                         BT2::BTFieldClass.from_handle(f.handle))

      elem = f
      f = BT2::BTFieldClassArrayStatic.new(trace_class: trace_class,
                                           element_field_class: elem,
                                           length: 5)
      assert_equal(:BT_FIELD_CLASS_TYPE_STATIC_ARRAY, f.type)
      assert_instance_of(BT2::BTFieldClassArrayStatic,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal(elem, f.element_field_class)
      assert_equal(5, f.length)

      elem = f
      f = BT2::BTFieldClassArrayDynamic.new(trace_class: trace_class,
                                            element_field_class: elem)
      assert_equal(:BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITHOUT_LENGTH_FIELD, f.type)
      assert_instance_of(BT2::BTFieldClassArrayDynamic,
                         BT2::BTFieldClass.from_handle(f.handle))
      refute_kind_of(BT2::BTFieldClassArrayDynamicWithLengthField,
                     BT2::BTFieldClass.from_handle(f.handle))

      length = BT2::BTFieldClassIntegerUnsigned.new(trace_class: trace_class)
      f = BT2::BTFieldClassArrayDynamic.new(trace_class: trace_class,
                                            element_field_class: elem,
                                            length_field_class: length)
      assert_equal(:BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITH_LENGTH_FIELD, f.type)
      assert_instance_of(BT2::BTFieldClassArrayDynamic,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_kind_of(BT2::BTFieldClassArrayDynamicWithLengthField,
                     BT2::BTFieldClass.from_handle(f.handle))
      elem = nil
      length = nil

      f = BT2::BTFieldClassStructure.new(trace_class: trace_class)
      assert_equal(:BT_FIELD_CLASS_TYPE_STRUCTURE, f.type)
      assert_instance_of(BT2::BTFieldClassStructure,
                         BT2::BTFieldClass.from_handle(f.handle))
      f1 = BT2::BTFieldClassBool.new(trace_class: trace_class)
      f2 = BT2::BTFieldClassString.new(trace_class: trace_class)
      assert_equal(0, f.member_count)
      f.append_member("foo", f1)
      assert_equal(1, f.member_count)
      f.append_member(:bar, f2)
      assert_equal(2, f.member_count)
      assert_nil(f[15])
      assert_nil(f["baz"])
      mem = f[0]
      assert_instance_of(BT2::BTFieldClassStructureMember, mem)
      assert_equal(mem, f["foo"])
      assert_equal(f1, mem.field_class)
      assert_equal("foo", mem.name)
      assert_equal({}, mem.user_attributes.value)
      mem.user_attributes = { "foo" => 15 }
      assert_equal({ "foo" => 15 }, mem.user_attributes.value)
      mem = f[1]
      assert_equal(mem, f[:bar])
      assert_equal(f2, mem.field_class)
      assert_equal(:bar, mem.name)
      mem = nil
      f1 = nil
      f2 = nil

      opt = BT2::BTFieldClassBool.new(trace_class: trace_class)
      f = BT2::BTFieldClassOptionWithoutSelectorField.new(trace_class: trace_class,
                                                          optional_field_class: opt)
      assert_equal(:BT_FIELD_CLASS_TYPE_OPTION_WITHOUT_SELECTOR_FIELD, f.type)
      assert_instance_of(BT2::BTFieldClassOptionWithoutSelectorField,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal(opt, f.field_class)

      opt = BT2::BTFieldClassBool.new(trace_class: trace_class)
      select = BT2::BTFieldClassBool.new(trace_class: trace_class)
      f = BT2::BTFieldClassOptionWithSelectorFieldBool.new(trace_class: trace_class,
                                                           optional_field_class: opt,
                                                           selector_field_class: select)
      assert_equal(:BT_FIELD_CLASS_TYPE_OPTION_WITH_BOOL_SELECTOR_FIELD, f.type)
      assert_instance_of(BT2::BTFieldClassOptionWithSelectorFieldBool,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal(opt, f.field_class)
      assert_nil(f.get_selector_field_path)
      refute(f.selector_is_reversed?)
      f.selector_is_reversed = true
      assert(f.selector_is_reversed?)

      opt = BT2::BTFieldClassBool.new(trace_class: trace_class)
      select = BT2::BTFieldClassIntegerUnsigned.new(trace_class: trace_class)
      f = BT2::BTFieldClassOptionWithSelectorFieldIntegerUnsigned.new(
                 trace_class: trace_class,
                 optional_field_class: opt,
                 selector_field_class: select,
                 ranges: [1..5, [7,9], 15] )
      assert_equal(:BT_FIELD_CLASS_TYPE_OPTION_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD, f.type)
      assert_instance_of(BT2::BTFieldClassOptionWithSelectorFieldIntegerUnsigned,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal(opt, f.field_class)
      assert_nil(f.get_selector_field_path)
      assert_equal([1..5, 7..9, 15..15], f.selector_ranges.value)

      opt = BT2::BTFieldClassBool.new(trace_class: trace_class)
      select = BT2::BTFieldClassIntegerSigned.new(trace_class: trace_class)
      f = BT2::BTFieldClassOptionWithSelectorFieldIntegerSigned.new(
                 trace_class: trace_class,
                 optional_field_class: opt,
                 selector_field_class: select,
                 ranges: [-1..5, [7,9], 15] )
      assert_equal(:BT_FIELD_CLASS_TYPE_OPTION_WITH_SIGNED_INTEGER_SELECTOR_FIELD, f.type)
      assert_instance_of(BT2::BTFieldClassOptionWithSelectorFieldIntegerSigned,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_equal(opt, f.field_class)
      assert_nil(f.get_selector_field_path)
      assert_equal([-1..5, 7..9, 15..15], f.selector_ranges.value)
      opt = nil
      select = nil

      f = BT2::BTFieldClassVariant.new(trace_class: trace_class)
      assert_equal(:BT_FIELD_CLASS_TYPE_VARIANT_WITHOUT_SELECTOR_FIELD, f.type)
      assert_kind_of(BT2::BTFieldClassVariantWithoutSelectorField, f)
      assert_instance_of(BT2::BTFieldClassVariant,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_kind_of(BT2::BTFieldClassVariantWithoutSelectorField,
                     BT2::BTFieldClass.from_handle(f.handle))
      f1 = BT2::BTFieldClassBool.new(trace_class: trace_class)
      f2 = BT2::BTFieldClassString.new(trace_class: trace_class)
      assert_equal(0, f.option_count)
      f.append_option("foo", f1)
      assert_equal(1, f.option_count)
      f.append_option(:bar, f2)
      assert_equal(2, f.option_count)
      assert_nil(f[15])
      assert_nil(f["baz"])
      opt = f[0]
      assert_instance_of(BT2::BTFieldClassVariantOption, opt)
      assert_equal(opt, f["foo"])
      assert_equal(f1, opt.field_class)
      assert_equal("foo", opt.name)
      assert_equal({}, opt.user_attributes.value)
      opt.user_attributes = { "foo" => 15 }
      assert_equal({ "foo" => 15 }, opt.user_attributes.value)
      opt = f[1]
      assert_equal(opt, f[:bar])
      assert_equal(f2, opt.field_class)
      assert_equal(:bar, opt.name)
      opt = nil
      f1 = nil
      f2 = nil

      select = BT2::BTFieldClassIntegerUnsigned.new(trace_class: trace_class)
      f = BT2::BTFieldClassVariant.new(trace_class: trace_class,
                                       selector_field_class: select)
      assert_equal(:BT_FIELD_CLASS_TYPE_VARIANT_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD, f.type)
      assert_kind_of(BT2::BTFieldClassVariantWithSelectorFieldIntegerUnsigned, f)
      assert_instance_of(BT2::BTFieldClassVariant,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_kind_of(BT2::BTFieldClassVariantWithSelectorFieldIntegerUnsigned,
                     BT2::BTFieldClass.from_handle(f.handle))
      f1 = BT2::BTFieldClassBool.new(trace_class: trace_class)
      f2 = BT2::BTFieldClassString.new(trace_class: trace_class)
      assert_nil(f.selector_field_path)
      assert_equal(0, f.option_count)
      f.append_option("foo", f1, [1..5, 8..10])
      assert_equal(1, f.option_count)
      f.append_option(:bar, f2, [6..7])
      assert_equal(2, f.option_count)
      assert_nil(f[15])
      assert_nil(f["baz"])
      opt = f[0]
      assert_instance_of(BT2::BTFieldClassVariantWithSelectorFieldIntegerUnsignedOption, opt)
      assert_equal(opt, f["foo"])
      assert_equal(f1, opt.field_class)
      assert_equal("foo", opt.name)
      assert_equal([1..5, 8..10], opt.ranges.value)
      assert_equal({}, opt.user_attributes.value)
      opt.user_attributes = { "foo" => 15 }
      assert_equal({ "foo" => 15 }, opt.user_attributes.value)
      opt = f[1]
      assert_equal(opt, f[:bar])
      assert_equal(f2, opt.field_class)
      assert_equal(:bar, opt.name)
      assert_equal([6..7], opt.ranges.value)
      opt = nil
      f1 = nil
      f2 = nil

      select = BT2::BTFieldClassIntegerSigned.new(trace_class: trace_class)
      f = BT2::BTFieldClassVariant.new(trace_class: trace_class,
                                       selector_field_class: select)
      assert_equal(:BT_FIELD_CLASS_TYPE_VARIANT_WITH_SIGNED_INTEGER_SELECTOR_FIELD, f.type)
      assert_kind_of(BT2::BTFieldClassVariantWithSelectorFieldIntegerSigned, f)
      assert_instance_of(BT2::BTFieldClassVariant,
                         BT2::BTFieldClass.from_handle(f.handle))
      assert_kind_of(BT2::BTFieldClassVariantWithSelectorFieldIntegerSigned,
                     BT2::BTFieldClass.from_handle(f.handle))
      f1 = BT2::BTFieldClassBool.new(trace_class: trace_class)
      f2 = BT2::BTFieldClassString.new(trace_class: trace_class)
      assert_nil(f.selector_field_path)
      assert_equal(0, f.option_count)
      f.append_option("foo", f1, [-1..5, 8..10])
      assert_equal(1, f.option_count)
      f.append_option(:bar, f2, [6..7])
      assert_equal(2, f.option_count)
      assert_nil(f[15])
      assert_nil(f["baz"])
      opt = f[0]
      assert_instance_of(BT2::BTFieldClassVariantWithSelectorFieldIntegerSignedOption, opt)
      assert_equal(opt, f["foo"])
      assert_equal(f1, opt.field_class)
      assert_equal("foo", opt.name)
      assert_equal([-1..5, 8..10], opt.ranges.value)
      assert_equal({}, opt.user_attributes.value)
      opt.user_attributes = { "foo" => 15 }
      assert_equal({ "foo" => 15 }, opt.user_attributes.value)
      opt = f[1]
      assert_equal(opt, f[:bar])
      assert_equal(f2, opt.field_class)
      assert_equal(:bar, opt.name)
      assert_equal([6..7], opt.ranges.value)
      opt = nil
      f1 = nil
      f2 = nil

      stream_class = BT2::BTStreamClass.new(trace_class: trace_class)
      href = trace_class.to_h
      h = trace_class.to_h
      assert_equal(href, BT2::BTTraceClass.from_h(self_component, h).to_h)
      trace = BT2::BTTrace.new(trace_class: trace_class)
      stream = BT2::BTStream.new(stream_class: stream_class, trace: trace)
    }

    fini_done = false
    comp_finalize_method = lambda { |self_component|
      fini_done = true
    }

    iter_class = BT2::BTMessageIteratorClass.new(next_method: next_method)
    source_class = BT2::BTComponentClass::Source.new(name: "empty_stream", message_iterator_class: iter_class)
    source_class.initialize_method = comp_initialize_method
    source_class.finalize_method = comp_finalize_method

    graph = BT2::BTGraph.new
    comp1 = graph.add(source_class, "source")
    comp2 = graph.add_simple_sink("count", consume)
    op = comp1.output_port(0)
    ip = comp2.input_port(0)
    graph.connect_ports(op, ip)
    graph.run
    assert_equal(1, stream_beginning_count)
    assert_equal(1, stream_end_count)
    source_class = nil
    iter_class = nil
    graph = nil
    comp1 = nil
    comp2 = nil
    op = ip = nil
    trace_class = nil
    stream_class = nil
    trace = nil
    stream = nil
    GC.start
    assert(fini_done)
  end
end
