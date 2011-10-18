#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

agent = WebSync::ServerAgent.new($root)
agent.listen(:production_up_to_date) do |*args|
  `bundle install --deployment --local`
  `touch tmp/restart.txt`
end
agent.synchronize
