require 'bundler'
Bundler.setup(:runtime)

map '/redeploy' do
  run lambda{|env|
    script = ::File.expand_path('../hooks/server/restart.rb', __FILE__)
    [200, 
     {"Content-type" => "text/plain"},
     [`#{script}`] ]
  }
end

$LOAD_PATH.unshift(File.expand_path("../lib",__FILE__))
require 'webapp'
map '/' do
  run WebApp
end
