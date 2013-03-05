require 'helper'
describe "/" do

  before do
    get '/'
    follow_redirect! if status==302
  end

  it 'responds' do
    status.should == 200
  end

  it 'contains the expected title' do
    body.should =~ %r{<title>Le M.rier Platane</title>}
  end

end
