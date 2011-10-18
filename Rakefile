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

namespace :ws do

  def client
    require 'websync'
    WebSync::ClientAgent.new(File.dirname(__FILE__))
  end

  def safe(message)
    puts message
    res = yield
    puts "done."
    res
  end

  task :import do
    safe("Importing bug fixes..."){
      client.sync_local
    }
  end

  task :save, :message do |t, args|
    safe("Saving..."){ 
      client.save(args[:message]) 
    }
  end

  task :deploy do
    safe("Deploying..."){
      client.sync_repo
    }
  end

end
