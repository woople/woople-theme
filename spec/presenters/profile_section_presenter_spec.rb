require_relative '../../app/presenters/profile_section_presenter'
require_relative '../../app/presenters/profile_link_presenter'
require_relative '../../app/presenters/theme_presentation'

describe ProfileSectionPresenter do
  describe "#links" do
    it "wraps each item in the profile link presenter" do
      stubbed = stub(name: nil, url: nil)
      section = [stubbed]

      ProfileSectionPresenter.new(section).links.each do |item|
        item.wrapped_by.should eq([ProfileLinkPresenter])
      end
    end
  end
end
