require_relative '../../app/presenters/menu_presenter'
require_relative '../../app/presenters/menu_section_presenter'
require_relative '../../app/presenters/theme_presentation'

describe MenuPresenter do
  it "wraps each item in a the menu in a MenuSectionPresenter" do
    collection = [stub, stub, stub]

    MenuPresenter.new(collection).each do |item|
      item.wrapped_by.should == [MenuSectionPresenter]
    end
  end
end
