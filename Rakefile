require 'rubygems' unless RUBY_VERSION >= "1.9"
require 'bundler'
Bundler.setup

desc %q{Run the website locally}
task :run do
  exec "bundle exec ruby -Ilib lib/webapp.rb"
end

desc %q{Run all tests}
task :test do
  files = Dir["test/test_*.rb"].join(" ")
  exec "bundle exec ruby -Ilib -Itest test/runall.rb"
end

require 'websync/rake_tasks'
WebSync::RakeTasks.new do |t|
  t.working_dir = File.dirname(__FILE__)
  sync = WebSync::Passenger::Client.new do |cl|
    cl.url = "http://www.lemurierplatane.fr/reload"
  end
  t.listen :repository_synchronized, sync
end
