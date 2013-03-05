require 'helper'
describe "/humans.txt" do

  before do
    get '/humans.txt'
  end

  it 'responds' do
    status.should == 200
    content_type.should =~ %r{text/plain}
  end

end
