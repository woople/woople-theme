require_relative '../../app/presenters/profile_presenter'
require_relative '../../app/presenters/theme_presentation'


describe ProfilePresenter do
  it "wraps each item in the profile presenter" do
    items = [stub, stub, stub]

    ProfilePresenter.new(items).each do |item|
      item.wrapped_by.should == [ProfilePresenter]
    end
  end

  describe "#url" do
    subject { ProfilePresenter.new(url: 'blah') }

    it "returns the url" do
      subject.url.should == 'blah'
    end
  end

  describe "#name" do
    subject { ProfilePresenter.new(name: 'blah') }

    it "returns the name" do
      subject.name.should == 'blah'
    end
  end
end
