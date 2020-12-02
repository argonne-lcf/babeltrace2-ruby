plugin = UserPlugin.new(
  name: "TestPlugin",
  author: "TestAuthor",
  description: "Test plugin.")

OBJECT_STORE = {}

class TestSourceMessageIterator < UserMessageIterator
  attr_reader :fini
  def init(self_message_iterator, configuration, port)
    @states = [
      :BT_MESSAGE_TYPE_STREAM_BEGINNING,
      :BT_MESSAGE_TYPE_STREAM_END ]
    @index = 0
    @fini = false
  end

  def finalize(self_message_iterator)
    @states = nil
    @index = 0
    @fini = true
  end

  def next(self_message_iterator, capacity)
    stream = OBJECT_STORE[:stream]
    return [] if capacity == 0
    m = case @states[@index]
      when :BT_MESSAGE_TYPE_STREAM_BEGINNING
        self_message_iterator.create_stream_beginning(stream)
      when :BT_MESSAGE_TYPE_STREAM_END
        self_message_iterator.create_stream_end(stream)
      when nil
        raise StopIteration
      else
        raise "invalid state"
      end
    @index += 1
    [m]
  end
end

class TestSource < UserSource
  @name = "test source"
  @description = "Test source."
  @message_iterator_class = TestSourceMessageIterator

  attr_reader :fini

  def init(self_component, configuration, params, data)
    self_component.add_output_port("p0")
    trace_class = self_component.create_trace_class
    stream_class = trace_class.create_stream_class
    trace = trace_class.create_trace
    stream = stream_class.create_stream(trace)
    OBJECT_STORE[:stream] = stream
    @fini = false
  end

  def finalize(self_component)
    OBJECT_STORE[:stream] = nil
    @fini = true
  end
end

class TestFilterMessageIterator < UserMessageIterator
  attr_reader :fini

  def init(self_message_iterator, configuration, port)
    @upstream_it = self_message_iterator.create_message_iterator(self_message_iterator.component.input_port(0))
    @fini = false
    @mess = []
  end

  def next(self_message_iterator, capacity)
    if @mess.empty?
      @mess += @upstream_it.next_messages
    end
    return [] if capacity == 0
    [@mess.shift]
  end

  def finalize(self_message_iterator)
    @upstream_it = nil
    @fini = true
  end
end

class TestFilter < UserFilter
  @message_iterator_class = TestFilterMessageIterator

  attr_reader :fini

  def init(self_component, configuration, params, data)
    self_component.add_input_port("fi0")
    self_component.add_output_port("fo0")
    @fini = false
  end

  def finalize(self_component)
    @fini = true
  end
end

class TestSink < UserSink
  attr_reader :fini
  attr_reader :stream_beginning_count
  attr_reader :stream_end_count

  def init(self_component, configuration, params, data)
    @port = self_component.add_input_port("in0")
    @stream_beginning_count = 0
    @stream_end_count = 0
    @fini = false
  end

  def graph_is_configured(self_component)
    @iterator = self_component.create_message_iterator(@port)
  end

  def finalize(self_component)
    @iterator = nil
    @port = nil
    @fini = true
  end

  def consume(self_component)
    mess = @iterator.next_messages
    mess.each { |m|
      case m.type
      when :BT_MESSAGE_TYPE_STREAM_BEGINNING
        @stream_beginning_count += 1
      when :BT_MESSAGE_TYPE_STREAM_END
        @stream_end_count += 1
      end
    }
  end
end

plugin.register(TestSource)
plugin.register(TestFilter)
plugin.register(TestSink)

register(plugin)
