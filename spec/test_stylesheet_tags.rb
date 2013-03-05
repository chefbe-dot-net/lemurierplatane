require 'helper'
describe "stylesheet tags at /" do

  before do
    get '/'
  end

  it 'refer to accessible stylesheets' do
    body.scan %r{<link\s+rel="stylesheet".*?href="(.*?)"} do |match|
      head (css = match.first)
      next unless internal?(css)
      status.should == 200
      content_type.should =~ %r{text/css}
    end
  end

end
