require 'webapp'
require 'test/unit'
require 'capybara'
require 'capybara/dsl'
class WebAppTest < Test::Unit::TestCase
  include Capybara::DSL

  def setup
    ENV['RACK_ENV'] = "development"
    Capybara.app = WebApp.new
  end

end
