require 'rubygems' unless RUBY_VERSION >= "1.9"
require 'bundler'
Bundler.setup(:runtime)

desc %q{Run the website locally}
task :run do
  exec "bundle exec ruby -Ilib lib/webapp.rb"
end

desc %q{Run all tests}
task :test do
  Bundler.setup(:test)
  files = Dir["test/test_*.rb"].join(" ")
  exec "bundle exec ruby -Ilib -Itest test/runall.rb"
end
