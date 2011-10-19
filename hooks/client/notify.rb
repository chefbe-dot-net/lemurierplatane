#!/usr/bin/env ruby
require File.expand_path('../../commons', __FILE__)

require 'http'
puts "Notifying production server..."
puts Http.post("http://www.lemurierplatane.fr/redeploy")

