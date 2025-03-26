Gem::Specification.new do |s|
  s.name = 'babeltrace2'
  s.version = "0.1.5"
  s.author = "Brice Videau"
  s.email = "bvideau@anl.gov"
  s.homepage = "https://github.com/alcf-perfengr/babeltrace2-ruby"
  s.summary = "Ruby Babeltrace 2 bindings"
  s.description = "Ruby Babeltrace 2 ffi bindings"
  s.files = Dir[ 'babeltrace2.gemspec', 'LICENSE', 'lib/**/**/*.rb', 'ext/**/*.rb' ]
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.3.0'
  s.add_dependency 'ffi', '~> 1.9', '>=1.9.3'
end
