require 'helper'
describe "/robots.txt" do

  before do
    get '/robots.txt'
  end

  it 'responds' do
    status.should == 200
    content_type.should =~ %r{text/plain}
  end

end
