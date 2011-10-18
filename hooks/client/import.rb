#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

agent = WebSync::ClientAgent.new($root)
agent.sync_local
