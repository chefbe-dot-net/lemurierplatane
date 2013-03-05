module Helpers
end
module Tilt
  class WLangTemplate

    def initialize(*args, &bl)
      bl ||= proc{|t| File.read(@file) }
      super(*args, &bl)
    end

  end
end