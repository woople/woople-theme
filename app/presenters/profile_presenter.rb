require 'delegate'

class ProfilePresenter < SimpleDelegator
  def each(*)
    super do |e|
      yield ThemePresentation.wrap(e, ProfilePresenter)
    end
  end

  def url
    __getobj__[:url]
  end

  def name
    __getobj__[:name]
  end
end
