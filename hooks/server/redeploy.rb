#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

agent = WebSync::ServerAgent.new($root)
agent.listen(:production_up_to_date) do |*args|
  puts `bundle install --deployment --local`
  puts `touch tmp/restart.txt`
  puts "Done."
end
agent.synchronize
