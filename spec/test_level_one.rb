require 'helper'
['fr', 'nl', 'en', 'fr/', 'nl/', 'en/'].each do |lang|
  describe "/#{lang}" do

    before do
      get "/#{lang}"
    end

    it 'responds' do
      status.should == 200
    end

    it 'contains the expected title' do
      body.should =~ %r{<title>Le M.rier Platane</title>}
    end

  end
end
