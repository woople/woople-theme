require 'delegate'
require 'action_view'
require 'active_support/core_ext/object/blank'

class OutlineAssessmentPresenter < SimpleDelegator
  include ActionView::Helpers::TagHelper
  
  def render
    yield if enabled?
  end

  def render_relearnings
    yield unless relearnings.empty?
  end

  def start_button_tag
    css = 'btn btn-primary btn-large'
    
    if url.present?
      content_tag(:a, I18n.t('woople_theme.assessment.start'), class: css, href: url)
    else
      content_tag(:a, I18n.t('woople_theme.assessment.start'), class: "#{css} disabled")
    end
  end
end
