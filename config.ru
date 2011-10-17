$LOAD_PATH.unshift ::File.expand_path("../lib", __FILE__)
require 'bundler'
require 'bundler/setup'

require 'websync'
map '/reload' do
  run WebSync::Passenger::Server.new(::File.dirname( __FILE__))
end

require 'webapp'
map '/' do
  run WebApp
end
