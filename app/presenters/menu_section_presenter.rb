require 'delegate'

class MenuSectionPresenter < SimpleDelegator
  def name
    yield(section.name) if section.respond_to? :name
  end

  def links
    @links ||= ThemePresentation.wrap_collection(section.links, MenuLinkPresenter)
  end

  private

  def section
    __getobj__
  end

end

