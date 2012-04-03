require 'delegate'

class MenuPresenter < SimpleDelegator
  def initialize(menu)
    super(ThemePresentation.wrap_collection(menu, MenuSectionPresenter))
  end
end
