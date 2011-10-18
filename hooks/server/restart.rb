#!/usr/bin/env ruby
Dir.chdir(File.expand_path('../../..', __FILE__)) do
  puts `bundle install --deployment --local`
  puts `touch tmp/restart`
  puts "Restarted."
end
