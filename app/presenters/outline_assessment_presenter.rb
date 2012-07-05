require 'ostruct'
require 'delegate'
require 'action_view'
require 'active_support/core_ext/object/blank'
require 'woople_theme_i18n'

class OutlineAssessmentPresenter < SimpleDelegator
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper

  def render
    yield if enabled?
  end

  def render_relearnings
    yield unless relearnings.empty?
  end

  def start_button_tag
    css_classes = 'btn btn-primary btn-large'

    if startable?
      submit_tag I18n.t('woople_theme.assessment.start'), class: css_classes
    else
      submit_tag I18n.t('woople_theme.assessment.start'), class: "#{css_classes} disabled", disabled: true
    end
  end

  def history_link_tag
    history.empty? ? '' : content_tag(:a, I18n.t('woople_theme.assessment.history'))
  end

  def each_history_item
    history.each do |history_item|
      yield normalize(history_item)
    end
  end

  private

  def normalize history_item
    OpenStruct.new(
      date: WoopleThemeI18n.l(history_item.completed_at.to_date),
      score: "#{history_item.score}%",
      result_name: history_item.passed ? I18n.t('woople_theme.assessment.pass') : I18n.t('woople_theme.assessment.fail'),
      url: history_item.url
    )
  end
end
