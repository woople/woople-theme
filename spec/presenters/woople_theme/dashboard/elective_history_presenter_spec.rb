require 'spec_helper'

describe WoopleTheme::Dashboard::ElectiveHistoryPresenter do
  describe "#render_time_remaining" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    it "should not yield" do
      expect { |block| subject.render_time_remaining(&block).not_to yield_control }
    end
  end

  describe "#render_popularity" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    it "should not yield" do
      expect { |block| subject.render_popularity(&block).not_to yield_control }
    end
  end

  describe "#render_certification_metadata" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    it "should not yield" do
      expect { |block| subject.render_certification_metadata(&block).not_to yield_control }
    end
  end

  describe "#render_progress_bar" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    it "should not yield" do
      expect { |block| subject.render_progress_bar(&block).not_to yield_control }
    end
  end

  describe "#render_elective_points" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    it "should yield" do
      expect { |block| subject.render_elective_points(&block).to yield_control }
    end
  end

  describe "#render_completed_on" do
    let(:data) { stub_presenter() }

    subject { WoopleTheme::Dashboard::ElectiveHistoryPresenter.new(data) }

    it "should yield" do
      expect { |block| subject.render_completed_on(&block).to yield_control }
    end
  end

  def stub_presenter(options = {})
    defaults = {name: 'Elective Course', url: '/course', image: nil, completed_on: Time.current, current_points: 0, total_points: 0}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
