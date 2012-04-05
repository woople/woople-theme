require 'rubygems'
require 'less-rails-bootstrap'

module WoopleTheme
  class Engine < ::Rails::Engine
    initializer :assets do |config|
      Rails.application.config.assets.precompile += [
        'woople-theme/framework.css',
        'woople-theme/theme.css',
        'woople-theme/theme-retina.css'
      ]
    end

    initializer "something" do |config|
      WoopleTheme.configure do |c|
        #create an empty configuration
      end
    end
  end
end
