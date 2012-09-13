require 'spec_helper'
require 'woople_theme_i18n'

describe WoopleTheme::Dashboard::ElectiveHistoryPresenter do
  describe "#render_time_remaining" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    specify { expect { |b| subject.render_time_remaining(&b) }.not_to yield_control }
  end

  describe "#render_popularity" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    specify { expect { |b| subject.render_popularity(&b) }.not_to yield_control }
  end

  describe "#render_certification_metadata" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    specify { expect { |b| subject.render_certification_metadata(&b) }.not_to yield_control }
  end

  describe "#render_progress_bar" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    specify { expect { |b| subject.render_progress_bar(&b) }.not_to yield_control }
  end

  describe "#render_elective_points" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    specify { expect { |b| subject.render_elective_points(&b) }.to yield_control }
  end

  describe "#render_completed_on" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    specify { expect { |b| subject.render_completed_on(&b) }.to yield_control }
  end

  describe "#formatted_completed_on" do
    context "when completed_on is nil" do
      let(:data) { stub_presenter(completed_on: nil) }

      subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

      it "should return in progress" do
        subject.formatted_completed_on.should eq(I18n.t('woople_theme.dashboards.member.electives_section.in_progress'))
      end
    end

    context "when completed_on is not nil" do
      let(:data) { stub_presenter(completed_on: Time.current.to_date) }

      subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

      it "should return the formatted date" do
        subject.formatted_completed_on.should eq(WoopleThemeI18n.l(subject.completed_on))
      end
    end
  end

  private

  def stub_presenter(options = {})
    defaults = {name: 'Elective Course', url: '/course', image: nil, completed_on: Time.current, current_points: 0, total_points: 0}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
