require 'bundler'
Bundler.setup(:runtime)

here = File.dirname(__FILE__)

map '/redeploy' do
  run lambda{|env|
    script = ::File.join(here, 'hooks/server/restart.rb')
    result = `#{script}`
    ::File.open(::File.join(here, 'logs/restart.log'), 'w'){|io|
      io << result << "\n"
    }
    [200, 
     {"Content-type" => "text/plain"},
     [result] ]
  }
end

$LOAD_PATH.unshift(File.join(here, 'lib'))
require 'webapp'
map '/' do
  run WebApp
end
