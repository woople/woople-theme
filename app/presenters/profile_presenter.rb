require 'delegate'

class ProfilePresenter < SimpleDelegator
  def each(*)
    super do |e|
      yield ThemePresentation.wrap(e, ProfilePresenter)
    end
  end
end
