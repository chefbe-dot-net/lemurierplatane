require 'bundler'
Bundler.setup(:runtime)

map '/redeploy' do
  run lambda{|env| `ruby hooks/server/redeploy`}
end

require 'webapp'
map '/' do
  run WebApp
end
