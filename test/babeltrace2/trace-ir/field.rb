class BTFieldTest < Minitest::Test
  def test_field
    packet_beginning_count = 0
    packet_end_count = 0
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
        when :BT_MESSAGE_TYPE_PACKET_BEGINNING
          assert_equal("{:bool: true, bit array: [false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, true], unsigned: 10, signed: 0xfffb, single: 15.0, double: 15.0, unsigned enum: (7) [foo, :bar], signed enum: (7) [foo, :bar], string: Hello, static array: [true, false, true, false, true, false, true, false, true, false, true, false, true, false, true], dynamic array wo length: [true, false, true, false, true], dynamic array w length: [true, false, true, false, true, false, true, false, true, false], option wo select: true, option w select bool: false, option w select unsigned: true, option w select signed: false, variant wo select: {:bar: baz}, variant w select unsigned: {foo: true}, variant w select signed: {foo: false}}", m.packet.context_field.to_s)
          assert_equal("{:bool=>true, \"bit array\"=>[false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, true], \"unsigned\"=>10, \"signed\"=>-5, \"single\"=>15.0, \"double\"=>15.0, \"unsigned enum\"=>7, \"signed enum\"=>7, \"string\"=>\"Hello\", \"static array\"=>[true, false, true, false, true, false, true, false, true, false, true, false, true, false, true], \"dynamic array wo length\"=>[true, false, true, false, true], \"dynamic array w length\"=>[true, false, true, false, true, false, true, false, true, false], \"option wo select\"=>true, \"option w select bool\"=>false, \"option w select unsigned\"=>true, \"option w select signed\"=>false, \"variant wo select\"=>{:bar=>\"baz\"}, \"variant w select unsigned\"=>{\"foo\"=>true}, \"variant w select signed\"=>{\"foo\"=>false}}", m.packet.context_field.value.to_s)
          packet_beginning_count += 1
        when :BT_MESSAGE_TYPE_PACKET_END
          packet_end_count += 1
        end
      }
    }

    states = [
      :BT_MESSAGE_TYPE_STREAM_BEGINNING,
      :BT_MESSAGE_TYPE_PACKET_BEGINNING,
      :BT_MESSAGE_TYPE_PACKET_END,
      :BT_MESSAGE_TYPE_STREAM_END ]
    index = 0
    trace_class = nil
    stream_class = nil
    trace = nil
    stream = nil
    field_class = nil
    packet = nil

    next_method = lambda { |it, capacity|
      return [] if capacity == 0
      m = case states[index]
        when :BT_MESSAGE_TYPE_STREAM_BEGINNING
          BT2::BTMessage::StreamBeginning.new(self_message_iterator: it, stream: stream)
        when :BT_MESSAGE_TYPE_STREAM_END
          BT2::BTMessage::StreamEnd.new(self_message_iterator: it, stream: stream)
        when :BT_MESSAGE_TYPE_PACKET_BEGINNING
          packet = BT2::BTPacket.new(stream: stream)
          assert_equal(stream, packet.stream)
          f = packet.context_field
          assert_equal(:BT_FIELD_CLASS_TYPE_STRUCTURE, f.class_type)
          assert_instance_of(BT2::BTFieldStructure, f)
          assert_equal(field_class, f.get_class)
          assert_equal(19, f.member_count)
          assert_nil(f[19])
          assert_nil(f["bool"])
          field_names = [:bool, "bit array", "unsigned", "signed", "single", 
                         "double", "unsigned enum", "signed enum", "string", 
                         "static array", "dynamic array wo length", "dynamic array w length", 
                         "option wo select", "option w select bool", "option w select unsigned", "option w select signed", 
                         "variant wo select", "variant w select unsigned", "variant w select signed"]
          assert_equal(field_names, f.field_names)
          sf = f[0]
          assert_equal(sf, f[:bool])
          assert_equal(:BT_FIELD_CLASS_TYPE_BOOL, sf.class_type)
          assert_instance_of(BT2::BTFieldBool, sf)
          sf.value = false
          refute(sf.value)
          sf.value = true
          assert(sf.value)

          sf = f[1]
          assert_equal(sf, f["bit array"])
          assert_equal(:BT_FIELD_CLASS_TYPE_BIT_ARRAY, sf.class_type)
          assert_instance_of(BT2::BTFieldBitArray, sf)
          assert_equal(16, sf.length)
          sf.value_as_integer = 0
          sf[1] = true
          sf[2] = true
          sf[0] = false
          sf[1] = false
          sf[-1] = true
          v = sf.value_as_integer
          assert_equal(0x8004, v)
          16.times { |i| assert_equal(v & (1<<i) != 0, sf[i]) }

          sf = f[2]
          assert_equal(:BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER, sf.class_type)
          assert_instance_of(BT2::BTFieldIntegerUnsigned, sf)
          assert_equal(16, sf.field_value_range)
          sf.value = 65
          assert_equal(65, sf.value)
          assert_equal("65", sf.to_s)
          sf.value = 10
          
          sf = f[3]
          assert_equal(:BT_FIELD_CLASS_TYPE_SIGNED_INTEGER, sf.class_type)
          assert_instance_of(BT2::BTFieldIntegerSigned, sf)
          assert_equal(16, sf.field_value_range)
          sf.value = 65
          assert_equal(65, sf.value)
          assert_equal("0x41", sf.to_s)
          sf.value = -65
          assert_equal(-65, sf.value)
          assert_equal("0xffbf", sf.to_s)
          sf.value = -5

          sf = f[4]
          assert_equal(:BT_FIELD_CLASS_TYPE_SINGLE_PRECISION_REAL, sf.class_type)
          assert_instance_of(BT2::BTFieldRealSinglePrecision, sf)
          sf.value = 15.0
          assert_equal(15.0, sf.value)
          
          sf = f[5]
          assert_equal(:BT_FIELD_CLASS_TYPE_DOUBLE_PRECISION_REAL, sf.class_type)
          assert_instance_of(BT2::BTFieldRealDoublePrecision, sf)
          sf.value = 15.0
          assert_equal(15.0, sf.value)

          sf = f[6]
          assert_equal(:BT_FIELD_CLASS_TYPE_UNSIGNED_ENUMERATION, sf.class_type)
          assert_instance_of(BT2::BTFieldEnumerationUnsigned, sf)
          sf.value = 0
          assert_equal([], sf.mapping_labels)
          sf.value = 1
          assert_equal(["foo"], sf.mapping_labels)
          sf.value = 7
          assert_equal(["foo", :bar], sf.mapping_labels)
          
          sf = f[7]
          assert_equal(:BT_FIELD_CLASS_TYPE_SIGNED_ENUMERATION, sf.class_type)
          assert_instance_of(BT2::BTFieldEnumerationSigned, sf)
          sf.value = -2
          assert_equal([], sf.mapping_labels)
          sf.value = 1
          assert_equal(["foo"], sf.mapping_labels)
          sf.value = 7
          assert_equal(["foo", :bar], sf.mapping_labels)

          sf = f[8]
          assert_equal(:BT_FIELD_CLASS_TYPE_STRING, sf.class_type)
          assert_instance_of(BT2::BTFieldString, sf)
          sf.value = "Hello"
          assert_equal("Hello", sf.value)
          sf.clear 
          assert_equal("", sf.value)
          sf.clear
# this breaka precondition in dev mode, so do not test it for now.
#          sf.append("Hello\0!", length: 7)
#          assert_equal("Hello\0!", sf.value)
#          sf.clear
          sf << "Hel"
          assert_equal("Hel", sf.value)
          sf.append("lo!", length: 2)
          assert_equal("Hello", sf.value)

          sf = f[9]
          assert_equal(:BT_FIELD_CLASS_TYPE_STATIC_ARRAY, sf.class_type)
          assert_instance_of(BT2::BTFieldArrayStatic, sf)
          assert_equal(15, sf.length)
          assert_nil(sf[16])
          assert_nil(sf[-16])
          sf_value = sf.length.times.collect { |indx| indx % 2 == 0 ? true : false }
          sf.length.times { |indx|
            ssf = sf[indx]
            ssf.value = sf_value[indx]
          }
          sf.each.each_cons(2) { |ssf1, ssf2|
            refute_equal(ssf1.value, ssf2.value)
          }
          sf.length.times { |indx|
            ssf = sf[indx]
            ssf.value = 0
          }
          sf.value = sf_value
          sf.each.each_cons(2) { |ssf1, ssf2|
            refute_equal(ssf1.value, ssf2.value)
          }
  
          sf = f[10]
          assert_equal(:BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITHOUT_LENGTH_FIELD, sf.class_type)
          assert_instance_of(BT2::BTFieldArrayDynamic, sf)
          refute_kind_of(BT2::BTFieldArrayDynamicWithLengthField, sf)
          sf.length = 5
          assert_equal(5, sf.length)
          assert_nil(sf[16])
          assert_nil(sf[-16])
          sf_value = sf.length.times.collect { |indx| indx % 2 == 0 ? true : false }
          sf.length.times { |indx|
            ssf = sf[indx]
            ssf.value =  sf_value[indx]
          }
          sf.each.each_cons(2) { |ssf1, ssf2|
            refute_equal(ssf1.value, ssf2.value)
          }
          sf.length.times { |indx|
            ssf = sf[indx]
            ssf.value = 0
          }
          sf.value = sf_value
          sf.each.each_cons(2) { |ssf1, ssf2|
            refute_equal(ssf1.value, ssf2.value)
          }

          sf = f[11]
          assert_equal(:BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY_WITH_LENGTH_FIELD, sf.class_type)
          assert_instance_of(BT2::BTFieldArrayDynamic, sf)
          assert_kind_of(BT2::BTFieldArrayDynamicWithLengthField, sf)
          sf.length = f[2].value
          assert_equal(f[2].value, sf.length)
          assert_nil(sf[16])
          assert_nil(sf[-16])
          sf_value = sf.length.times.collect { |indx| indx % 2 == 0 ? true : false }
          sf.length.times { |indx|
            ssf = sf[indx]
            ssf.value =  sf_value[indx]
          }
          sf.each.each_cons(2) { |ssf1, ssf2|
            refute_equal(ssf1.value, ssf2.value)
          }
          sf.length.times { |indx|
            ssf = sf[indx]
            ssf.value = 0
          }
          sf.value = sf_value
          sf.each.each_cons(2) { |ssf1, ssf2|
            refute_equal(ssf1.value, ssf2.value)
          }

          assert_equal("PACKET_CONTEXT[2]", sf.get_class.length_field_path.to_s)

          sf = f[12]
          assert_equal(:BT_FIELD_CLASS_TYPE_OPTION_WITHOUT_SELECTOR_FIELD, sf.class_type)
          assert_instance_of(BT2::BTFieldOptionWithoutSelectorField, sf)
          sf.has_field = false
          assert_nil(sf.field)
          sf.has_field = true
          ssf = sf.field
          ssf.value = true
         
          sf = f[13]
          assert_equal(:BT_FIELD_CLASS_TYPE_OPTION_WITH_BOOL_SELECTOR_FIELD, sf.class_type)
          assert_instance_of(BT2::BTFieldOptionWithSelectorFieldBool, sf)
          sf.has_field = f[0].value
          sf.field.value = false
          assert_equal("PACKET_CONTEXT[0]", sf.get_class.selector_field_path.to_s)

          sf = f[14]
          assert_equal(:BT_FIELD_CLASS_TYPE_OPTION_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD, sf.class_type)
          assert_instance_of(BT2::BTFieldOptionWithSelectorFieldIntegerUnsigned, sf)
          sf.has_field = f[0].value
          sf.field.value = true
          assert_equal("PACKET_CONTEXT[2]", sf.get_class.selector_field_path.to_s)

          sf = f[15]
          assert_equal(:BT_FIELD_CLASS_TYPE_OPTION_WITH_SIGNED_INTEGER_SELECTOR_FIELD, sf.class_type)
          assert_instance_of(BT2::BTFieldOptionWithSelectorFieldIntegerSigned, sf)
          sf.has_field = f[0].value
          sf.field.value = false
          assert_equal("PACKET_CONTEXT[3]", sf.get_class.selector_field_path.to_s)

          sf = f[16]
          assert_equal(:BT_FIELD_CLASS_TYPE_VARIANT_WITHOUT_SELECTOR_FIELD, sf.class_type)
          assert_instance_of(BT2::BTFieldVariantWithoutSelectorField, sf)
          sf.select_option_by_index(0)
          assert_equal(0, sf.selected_option_index)
          opt = sf.selected_option_class
          assert_instance_of(BT2::BTFieldClassVariantOption, sf.selected_option_class)
          assert_equal("foo", opt.name)
          assert_instance_of(BT2::BTFieldClassBool, opt.field_class)
          ssf = sf.selected_option_field
          assert_instance_of(BT2::BTFieldBool, ssf)
          sf.select_option_by_index(1)
          assert_equal(1, sf.selected_option_index)
          opt = sf.selected_option_class
          assert_equal(:bar, opt.name)
          assert_instance_of(BT2::BTFieldClassString, opt.field_class)
          ssf = sf.selected_option_field
          assert_instance_of(BT2::BTFieldString, ssf)
          ssf.value = "baz"

          sf = f[17]
          assert_equal(:BT_FIELD_CLASS_TYPE_VARIANT_WITH_UNSIGNED_INTEGER_SELECTOR_FIELD, sf.class_type)
          assert_instance_of(BT2::BTFieldVariantWithSelectorFieldIntegerUnsigned, sf)
          sf.select_option_by_index(0)
          ssf = sf.selected_option_field
          ssf.value = true

          sf = f[18]
          assert_equal(:BT_FIELD_CLASS_TYPE_VARIANT_WITH_SIGNED_INTEGER_SELECTOR_FIELD, sf.class_type)
          assert_instance_of(BT2::BTFieldVariantWithSelectorFieldIntegerSigned, sf)
          sf.select_option_by_index(0)
          ssf = sf.selected_option_field
          ssf.value = false

          BT2::BTMessage::PacketBeginning.new(self_message_iterator: it, packet: packet, clock_snapshot_value: 100)
        when :BT_MESSAGE_TYPE_PACKET_END
          p = packet
          packet = nil
          BT2::BTMessage::PacketEnd.new(self_message_iterator: it, packet: p, clock_snapshot_value: 200)
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
      trace_class = self_component.create_trace_class
      clock_class = self_component.create_clock_class
      stream_class = trace_class.create_stream_class
      stream_class.default_clock_class = clock_class
      stream_class.set_supports_packets(true, with_beginning_default_clock_snapshot: true,
                                              with_end_default_clock_snapshot: true)
      field_class = trace_class.create_structure
      field_class.append(:bool, b = trace_class.create_bool)
      field_class.append("bit array", trace_class.create_bit_array(16))
      u = trace_class.create_unsigned
      u.field_value_range = 16
      field_class.append("unsigned", u)
      s = trace_class.create_signed 
      s.field_value_range = 16
      s.preferred_display_base = 16
      field_class.append("signed", s)
      field_class.append("single", trace_class.create_single)
      field_class.append("double", trace_class.create_double)
      e = trace_class.create_unsigned_enum
      e.add_mapping("foo", [1..5, [7,9], 15])
      e.add_mapping(:bar, 4..8)
      field_class.append("unsigned enum", e)
      e = trace_class.create_signed_enum
      e.add_mapping("foo", [-1..5, [7,9], 15])
      e.add_mapping(:bar, 4..8)
      field_class.append("signed enum", e)
      field_class.append("string", trace_class.create_string)
      field_class.append("static array", trace_class.create_array(trace_class.create_bool, length: 15))
      field_class.append("dynamic array wo length", trace_class.create_array(trace_class.create_bool))
      field_class.append("dynamic array w length", trace_class.create_array(trace_class.create_bool, length: u))
      field_class.append("option wo select", trace_class.create_option(
        trace_class.create_bool))
      field_class.append("option w select bool", trace_class.create_option(
        trace_class.create_bool, selector_field_class: b))
      field_class.append("option w select unsigned", trace_class.create_option(
        trace_class.create_bool, selector_field_class: u, ranges: [1..15]))
      field_class.append("option w select signed", trace_class.create_option(
        trace_class.create_bool, selector_field_class: s, ranges: [-15..15]))
      v = trace_class.create_variant
      v.append("foo", trace_class.create_bool)
      v.append(:bar, trace_class.create_string)
      field_class.append("variant wo select", v)
      v = trace_class.create_variant(selector_field_class: u)
      v.append("foo", trace_class.create_bool, [1..5, 8..10])
      v.append(:bar, trace_class.create_string, [6..7])
      field_class.append("variant w select unsigned", v)
      v = trace_class.create_variant(selector_field_class: s)
      v.append("foo", trace_class.create_bool, [-5..5, 8..10])
      v.append(:bar, trace_class.create_string, [6..7])
      field_class.append("variant w select signed", v)
      stream_class.packet_context_field_class = field_class
      href = trace_class.to_h
      h = Marshal.load(Marshal.dump(href))
      assert_equal(href, BT2::BTTraceClass.from_h(self_component, h).to_h)
      trace = trace_class.create_trace
      stream = stream_class.create_stream(trace)
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
    assert_equal(1, packet_beginning_count)
    assert_equal(1, packet_end_count)
    source_class = nil
    iter_class = nil
    graph = nil
    comp1 = nil
    comp2 = nil
    op = ip = nil
    trace_class = nil
    stream_class = nil
    field_class = nil
    trace = nil
    stream = nil
    GC.start
    assert(fini_done)
  end
end
