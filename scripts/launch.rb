#!/usr/bin/env ruby
Encoding.default_external = Encoding::UTF_8
Dir.chdir File.expand_path("../../", __FILE__)
require 'bundler/setup'
require 'polygon/script'
Polygon::Script::Launch.run(ARGV)
