require 'ostruct'
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

  def history_link_tag
    history.empty? ? '' : content_tag(:a, I18n.t('woople_theme.assessment.history'), class: 'flip-action pull-right')
  end

  def each_history_item
    history.each do |history_item|
      yield normalize(history_item)
    end
  end

  private

  def normalize history_item
    OpenStruct.new(
      date: history_item.completed_at.strftime("%b %d %Y"),
      score: "#{history_item.score}%",
      result_name: history_item.passed ? 'Pass' : 'Fail',
      url: history_item.url
    )
  end
end
