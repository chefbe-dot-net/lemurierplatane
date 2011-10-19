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

