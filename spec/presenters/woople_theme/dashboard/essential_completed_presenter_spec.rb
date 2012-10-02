require 'spec_helper'
require 'woople_theme_i18n'

describe WoopleTheme::Dashboard::EssentialCompletedPresenter do
  describe "#render_time_remaining" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Dashboard::EssentialCompletedPresenter.new(data) }

    specify { expect { |b| subject.render_time_remaining(&b) }.not_to yield_control }
  end

  describe "#render_popularity" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Dashboard::EssentialCompletedPresenter.new(data) }

    specify { expect { |b| subject.render_popularity(&b) }.not_to yield_control }
  end

  describe "#render_certification_metadata" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Dashboard::EssentialCompletedPresenter.new(data) }

    specify { expect { |b| subject.render_certification_metadata(&b) }.not_to yield_control }
  end

  describe "#render_progress_bar" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Dashboard::EssentialCompletedPresenter.new(data) }

    specify { expect { |b| subject.render_progress_bar(&b) }.not_to yield_control }
  end

  describe "#render_essential_duration" do
    let(:data) { stub_presenter(time_total: "00:01") }

    subject { WoopleTheme::Dashboard::EssentialCompletedPresenter.new(data) }

    specify { expect { |b| subject.render_essential_duration(&b) }.to yield_control }
  end

  describe "#render_completed_on" do
    context "when completed_on is nil" do
      let(:data) { stub_presenter(completed_on: nil) }

      subject { WoopleTheme::Dashboard::EssentialCompletedPresenter.new(data) }

      specify { expect { |b| subject.render_completed_on(&b) }.not_to yield_control }
    end

    context "when completed_on is not nil" do
      let(:data) { stub_presenter }

      subject { WoopleTheme::Dashboard::EssentialCompletedPresenter.new(data) }

      specify { expect { |b| subject.render_completed_on(&b) }.to yield_control }
    end
  end

  private

  def stub_presenter(options = {})
    defaults = {name: 'Elective Course', url: '/course', image: nil, completed_on: Time.current, time_total: '12:34', current_points: 0, total_points: 0}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
