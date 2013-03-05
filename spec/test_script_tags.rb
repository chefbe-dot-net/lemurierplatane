require 'helper'
describe "script tags at /" do

  before do
    get '/'
  end

  it 'refer to accessible scripts' do
    body.scan %r{<script.*src="(.*?)"} do |match|
      head (js = match.first)
      next unless internal?(js)
      status.should == 200
      content_type.should =~ %r{application/javascript}
    end
  end

end