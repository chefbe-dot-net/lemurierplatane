#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

agent = WebSync::ServerAgent.new($root)
agent.listen(:production_up_to_date) do |*args|
  puts `bundle install --deployment --local`
  puts `touch tmp/restart.txt`
  puts "Done."
end
begin
  agent.synchronize
rescue Exception => ex
  puts "Something goes wrong here..."
  puts ex.message
  puts ex.backtrace.join("\n")
  exit(1)
end
