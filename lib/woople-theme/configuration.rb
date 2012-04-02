module WoopleTheme
  class Configuration
    attr_accessor :profile_helper, :menu_helper, :layout_javascript

    def profile_helper
      @profile_helper || :profile_helper
    end

    def menu_helper
      @menu_helper || :menu_helper
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

end
