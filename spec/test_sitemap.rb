require 'helper'
describe "/sitemap.xml" do

  before do
    get '/sitemap.xml'
  end

  it 'responds' do
    status.should == 200
    content_type.should =~ %r{application/xml}
  end

  it 'contains some url entries' do
    body.should =~ %r{<url>}
  end

  describe "the mapped urls" do

    let(:got) do
      urls = []
      body.gsub('&#47;', '/').scan %r{<loc>http://[^\/]+/(.*)</loc>} do |match|
        urls << match.first
      end
      Relation(:path => urls)
    end

    let(:expected) do
      database.query{ sitemap }.project([:path])
    end

    it 'is not larger' do
      (got - expected).should be_empty
    end

    it 'is not smaller' do
      (expected - got).should be_empty
    end
  end

  database.query{ sitemap }.each do |tuple|
    url = tuple[:path]

    describe url do
      before {
        head(url)
        follow_redirect! if status==302
      }
      specify{ status.should == 200 }
    end
  end

end
