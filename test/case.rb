Encoding.default_external = Encoding::UTF_8 if RUBY_VERSION > "1.9"
ENV["RACK_ENV"] = "test"

require 'webapp'
require 'test/unit'
require 'rack/test'
class Case < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    WebApp
  end
  alias :settings :app

  def internal?(link)
    link && !(link =~ /^(https?|ftp|mailto):/) && !(link =~ /ajax.googleapis.com/)
  end

  [:status, :content_type, :body].each do |methname|
    define_method(methname) do |*args, &bl|
      last_response.send(methname, *args, &bl)
    end
  end

  def test_internal
    if self.class == Case
      assert internal?("relative")
      assert internal?("/absolute")
      assert !internal?("http://www.google.com/")
    end 
  end

end