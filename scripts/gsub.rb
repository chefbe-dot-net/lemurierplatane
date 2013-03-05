#!/usr/bin/env ruby
Dir.chdir File.expand_path("../../", __FILE__)
require 'bundler/setup'
require 'polygon/script'
Polygon::Script::Gsub.run(ARGV)
