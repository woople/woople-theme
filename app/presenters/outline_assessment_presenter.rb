require 'ostruct'
require 'delegate'
require 'action_view'
require 'active_support/core_ext/object/blank'
require 'woople_theme_i18n'

class OutlineAssessmentPresenter < SimpleDelegator
  include ActionView::Helpers::TagHelper
  
  def render
    yield if enabled?
  end

  def render_relearnings
    yield unless relearnings.empty?
  end

  def start_button_tag
    css_classes = 'btn btn-primary btn-large'

    if startable?
      content_tag :a, I18n.t('woople_theme.assessment.start'), class: css_classes, href: url
    else
      content_tag :a, I18n.t('woople_theme.assessment.start'), class: "#{css_classes} disabled"
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

  def render_pass_fail_alert
    return unless respond_to? :passed?
    if passed?
      yield OpenStruct.new(
        css_class: 'alert-success',
        heading: I18n.t('woople_theme.assessment.pass_alert.heading'),
        message: I18n.t('woople_theme.assessment.pass_alert.message')
      )
    else
      yield OpenStruct.new(
        css_class: 'alert-error',
        heading: I18n.t('woople_theme.assessment.fail_alert.heading'),
        message: I18n.t('woople_theme.assessment.fail_alert.message')
      )
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
