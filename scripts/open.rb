#!/usr/bin/env ruby
Encoding.default_external = Encoding::UTF_8
Dir.chdir File.expand_path("../../", __FILE__)

retried = false
begin
  require 'bundler'
  Bundler.setup
rescue
  raise if retried
  puts "Bundling..."
  `bundle`
  retried = true
  retry
end

require 'polygon/script'
Polygon::Script::Open.run(ARGV)
