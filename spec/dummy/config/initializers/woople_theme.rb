WoopleTheme.configure do |config|
  config.profile_helper = :profile_model
  config.menu_helper = :menu_model
  config.layout_javascript = 'application'
end

module Paperclip
  class Attachment; end
end
