#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

Dir.chdir(File.expand_path('../../..', __FILE__)) do
  Bundler::with_original_env do
    puts `bundle install --deployment --local`
    puts `touch tmp/restart.txt`
    puts "Restarted."
  end
end
