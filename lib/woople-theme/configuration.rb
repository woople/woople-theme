module WoopleTheme
  class Configuration
    attr_accessor :profile_helper, :menu_helper, :impersonation_banner_helper, :layout_javascript

    def profile_helper
      @profile_helper || :profile_helper
    end

    def menu_helper
      @menu_helper || :menu_helper
    end

    def impersonation_banner_helper
      @impersonation_banner_helper || :impersonation_banner_helper
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
