require 'bundler'
Bundler.setup(:runtime)

here = File.dirname(__FILE__)

map '/redeploy' do
  run lambda{|env|
    script = ::File.join(here, 'hooks/server/redeploy.rb')
    [200, 
     {"Content-type" => "text/plain"},
     [ `#{script}` ] ]
  }
end

$LOAD_PATH.unshift(File.join(here, 'lib'))
require 'webapp'
map '/' do
  run WebApp
end
