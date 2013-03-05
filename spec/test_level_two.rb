require 'helper'
['fr/chambres', 'fr/chambres/'].each do |path|
  describe "/#{path}" do

    before do
      get "/#{path}"
    end

    it 'responds' do
      status.should == 200
    end

    it 'contains the expected title' do
      body.should =~ %r{<title>Le M.rier Platane</title>}
    end

  end
end
