require 'delegate'

class MenuSectionPresenter < SimpleDelegator
  def name
    yield(section.name) if section.respond_to? :name
  end

  def links
    return [] unless section.respond_to? :links

    @links ||= ThemePresentation.wrap_collection(section.links, MenuLinkPresenter)
  end

  def widgets
    return [] unless section.respond_to? :widgets

    @widgets ||= ThemePresentation.wrap_collection(section.widgets, MenuWidgetPresenter)
  end

  private

  def section
    __getobj__
  end
end
