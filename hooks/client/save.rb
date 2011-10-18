#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

if ARGV.size == 1
  agent = WebSync::ClientAgent.new($root)
  agent.save(ARGV[0])
else
  puts "Usage: save.rb COMMIT_MESSAGE"
  exit(1)
end
