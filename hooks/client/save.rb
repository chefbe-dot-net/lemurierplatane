#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

if ARGV.size != 1
  puts "Usage: save.rb COMMIT_MESSAGE"
  exit(1)
end

agent = WebSync::ClientAgent.new($root)
agent.listen(:working_dir_saved) do |*args|
  puts "Local copy saved successfully."
end
agent.save ARGV[0]

