require 'bundler/setup'

$LOAD_PATH.unshift ::File.join(here, "lib")
require 'websync'
map '/reload' do
  run WebSync::Passenger::Server.new(here)
end

require 'webapp'
map '/' do
  run WebApp
end
