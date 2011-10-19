ENV["RACK_ENV"] = "production"

require 'bundler'
Bundler.setup(:runtime)

here = File.dirname(__FILE__)

map '/redeploy' do
  run lambda{|env|
    script = ::File.join(here, 'hooks/server/redeploy.rb')
    result = Bundler::with_original_env do 
      Kernel.`(script)
    end
    [200, 
     {"Content-type" => "text/plain"},
     [ result ] ]
  }
end

$LOAD_PATH.unshift(File.join(here, 'lib'))
require 'webapp'
map '/' do
  run WebApp
end
