# Launches the website locally
task :run do
  exec "bundle exec ruby -Ilib lib/webapp.rb"
end

# Runs all tests
task :test do
  files = Dir["test/test_*.rb"].join(" ")
  exec "bundle exec ruby -Ilib -Itest test/runall.rb"
end

require 'websync/rake_tasks'
WebSync::RakeTasks.new do |t|
  t.working_dir = File.dirname(__FILE__)
end
