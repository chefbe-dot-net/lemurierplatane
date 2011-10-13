task :run do
  exec "bundle exec ruby -Ilib lib/webapp.rb"
end

task :test do
  files = Dir["test/test_*.rb"].join(" ")
  exec "bundle exec ruby -Ilib -Itest test/runall.rb"
end
