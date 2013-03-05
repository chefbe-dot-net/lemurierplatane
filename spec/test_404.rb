require 'helper'
["/this/is-not-an-existing-page", "/fr/unexisting-one"].each do |path|
  describe path do

    before do
      get path
    end

    it 'does not respond' do
      status.should == 404
      content_type.should =~ %r{text/html}
      body.should =~ %r{<title>Page Not Found}
    end

  end
end