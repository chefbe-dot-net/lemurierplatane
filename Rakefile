Encoding.default_external = Encoding::UTF_8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

desc %q{Regenerates CSS stylesheet} 
task :css do
  Dir.chdir(File.dirname(__FILE__)) do
    `lessc design/stylesheets/*.less > content/static/css/style.css`
    `cp -R design/stylesheets/* content/static/css/`
    `rm -rf content/static/css/*.less`
  end
end

desc %q{Run the website locally}
task :development do
  exec "ruby scripts/launch.rb development"
end

desc %q{Run all RSpec tests}
task :spec do
  require 'rspec'
  exit RSpec::Core::Runner.run(%w[-Ilib -Ispec --pattern=spec/**/test_*.rb --color .])
end
task :default => :spec
