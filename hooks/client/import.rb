#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

agent = WebSync::ClientAgent.new($root)
agent.listen(:working_dir_synchronized) do |*args|
  puts "Local copy synchronized successfully."
end
agent.sync_local
