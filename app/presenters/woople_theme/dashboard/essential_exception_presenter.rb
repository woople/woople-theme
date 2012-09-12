require 'action_view/helpers/url_helper'
require 'woople_theme_i18n'

module WoopleTheme
  module Dashboard
    class EssentialExceptionPresenter < ExceptionPresenter
      include ActionView::Helpers::UrlHelper

      enforce_definitions :url

      def title
        link_to(source.name, source.url)
      end

      def subtitle
        I18n.t('woople_theme.dashboards.member.exceptions.reason', reason: source.description)
      end

    end
  end
end
