require 'bundler'
Bundler.setup(:runtime)

map '/redeploy' do
  run lambda{|env| `ruby hooks/server/redeploy`}
end

$LOAD_PATH.unshift(File.expand_path("../lib",__FILE__))
require 'webapp'
map '/' do
  run WebApp
end
