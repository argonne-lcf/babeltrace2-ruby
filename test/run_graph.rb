[ '../lib', 'lib' ].each { |d| $:.unshift(d) if File::directory?(d) }
require 'babeltrace2'

trace_path = File.join(__dir__, "thapi-opencl-session-20201021-112005")
trace_location = File.join(trace_path, "ust/uid/1000/64-bit/")
ctf_fs = BT2::BTPlugin.find("ctf").get_source_component_class_by_name("fs")
utils_muxer = BT2::BTPlugin.find("utils").get_filter_component_class_by_name("muxer")
text_pretty = BT2::BTPlugin.find("text").get_sink_component_class_by_name("pretty")

graph = BT2::BTGraph.new
comp1 = graph.add_component(ctf_fs, "trace", params: {"inputs" => [ trace_location ]})
comp2 = graph.add_component(utils_muxer, "mux")
comp3 = graph.add_component(text_pretty, "pretty")
ops = comp1.output_ports
ops.each_with_index { |op, i|
  ip = comp2.input_port(i)
  graph.connect_ports(op, ip)
}

op = comp2.output_port(0)
ip = comp3.input_port(0)
graph.connect_ports(op, ip)
graph.run
