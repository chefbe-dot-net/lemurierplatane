require 'polygon'
require 'helpers'

class App < Polygon::Base
  helpers Helpers

  get "*" do
    wlang :closed, locals: {}, layout: false
  end

end
