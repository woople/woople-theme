class MenuPresenter < SimpleDelegator
  def initialize(menu)
    super(menu)
  end

  def each(*)
    super do |e|
      yield MenuSectionPresenter.new(e)
    end
  end
end

class MenuSectionPresenter < SimpleDelegator
  def initialize(section)
    super(OpenStruct.new(section))
  end

  def name
    yield(section.name) if section.respond_to? :name
  end

  def each(*)
    section.links.each do |link|
      yield MenuLinkPresenter.new(link)
    end
  end

  private

  def section
    __getobj__
  end
end

class MenuLinkPresenter < SimpleDelegator
  include ActionView::Helpers::TagHelper

  def initialize(link)
    super(OpenStruct.new(link))
  end

  def featured_tag(name, tag = :em)
    if link.featured
      content_tag(tag, name.html_safe)
    else
      name
    end
  end

  def badge
    return "" if link.badge.nil?
    content_tag(:span, link.badge, class: 'badge')
  end

  def certification_badge
    return "" if link.certification_badge.nil?
    content_tag(:span, content_tag(:i, '', class: "cert-status-#{link.certification_badge}") + " #{link.certification_badge.titleize}", class: 'badge label-icon')
  end

  def css_class
    "active" if link.selected
  end

  private

  def link
    __getobj__
  end
end
