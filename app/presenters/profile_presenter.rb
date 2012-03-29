class ProfilePresenter < SimpleDelegator
  def initialize(profile_links)
    super(profile_links)
  end

  def each(*)
    super do |e|
      yield ProfilePresenter.new(e)
    end
  end

  def url
    __getobj__[:url]
  end

  def name
    __getobj__[:name]
  end
end
