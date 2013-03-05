require 'helper'
describe "The dynamic site content" do

  shared_examples_for "a valid content entry" do
    it{ should be_a(Polygon::Entry) }

    it 'should have valid content' do
      (data = subject.to_hash).should be_a(Hash)
    end
  end

  database.cog(:entries).each do |tuple|
    entry = tuple[:entry]

    describe "#{entry.relative_path}" do
      subject{ tuple[:entry] }
      it_should_behave_like "a valid content entry"
    end
  end

end
