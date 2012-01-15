#!/usr/bin/env ruby
class Restore

  attr_reader :root, :logio

  def initialize(root)
    @root = root
  end

  def say(what)
    puts what
    logio << what rescue nil
  end

  def shell(command)
    say "-"*35 + " #{command}\n"
    IO.popen(command, :err => [:child, :out]) do |io|
      while s = io.gets
        say(s)
      end
    end
    say "-"*35 + " done (#{$?})\n\n"
  end

  def run!
    log_file = File.join(root, 'logs', 'restore.log')
    File.open(log_file, 'w') do |log|
      @logio = log
      restore!
    end
  end

  def restore!
    Dir.chdir(root) do
      shell "git remote update"
      shell "git reset --hard origin/master"
      shell "bundle install --no-color"
    end
  rescue Exception => ex
    say("something goes really bad here:")
    say("\t#{ex.message}\n\t")
    say(ex.backtrace.join("\n\t"))
  end

end # class Restore

if $0 == __FILE__
  root = File.expand_path('../..', __FILE__)
  Restore.new(root).run!
end