#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

agent = WebSync::ClientAgent.new($root)
agent.listen(:repository_synchronized) do |*args|
  puts "Repository synchronized, deploying now..."
  require 'http'
  puts Http.post("http://www.lemurierplatane.rb/redeploy")
end
agent.sync_repo
