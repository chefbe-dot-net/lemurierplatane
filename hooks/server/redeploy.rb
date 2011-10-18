#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

agent = WebSync::ServerAgent.new($root)
agent.listen(:production_up_to_date) do |*args|
  Bundler::with_original_env do
    puts `#{File.expand_path('../restart.rb')}`
  end
end
begin
  puts "Nothing to be done." unless agent.synchronize
rescue Exception => ex
  puts "Something goes wrong here..."
  puts ex.message
  puts ex.backtrace.join("\n")
  exit(1)
end
