Encoding.default_external = Encoding::UTF_8

# set development environment and launch dependencies
ENV["RACK_ENV"] = "development"
require 'bundler'
Bundler.setup(:development)

# chdir to root now
Dir.chdir(root = File.expand_path('../../',__FILE__)) do
  # update loadpath and load project
  $: << File.join(root,"lib")
  require 'app'
  
  use Rack::Nocache
  use Rack::CommonLogger
  run App
end
