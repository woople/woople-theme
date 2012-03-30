module WoopleTheme
  class Configuration
    attr_accessor :profile_helper

    def profile_helper
      @profile_helper || :profile_helper
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
