#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

agent = WebSync::ClientAgent.new($root)
agent.listen(:repository_synchronized) do |*args|
  puts "Repository synchronized."
  load(File.expand_path("../notify.rb", __FILE__))
end
agent.sync_repo
