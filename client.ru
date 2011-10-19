$LOAD_PATH.unshift(File.join(here = File.dirname(__FILE__), 'lib'))

ENV["RACK_ENV"] = "development"

require 'bundler'
Bundler.setup(:runtime)

require 'ext/nocache'
use Rack::Nocache

require 'webapp'
map '/' do
  run WebApp
end

$LOAD_PATH.unshift(File.join(here, 'websync-admin', 'lib'))
require 'websync'
require 'websync/admin'
map '/admin/' do
  WebSync::Admin.set :agent, WebSync::ClientAgent.new(here)
  run WebSync::Admin
end

