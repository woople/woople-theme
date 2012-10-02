require 'spec_helper'

describe WoopleTheme::Dashboard::ElectivesSectionPresenter do
  describe "#render_history" do
    describe "more than one completed elective" do
      let(:data) { stub_presenter(electives_history: [stub]) }

      subject { WoopleTheme::Dashboard::ElectivesSectionPresenter.new(data) }

      specify { expect { |b| subject.render_history(&b) }.to yield_control }
    end

    describe "0 completed/in-progress electives" do
      let(:data) { stub_presenter }

      subject { WoopleTheme::Dashboard::ElectivesSectionPresenter.new(data) }

      specify { expect { |b| subject.render_history(&b) }.not_to yield_control }
    end
  end

  describe "#render_exceptions" do
    describe "at least one elective exception" do
      let(:data) { stub_presenter(electives_exceptions: [stub]) }

      subject { WoopleTheme::Dashboard::ElectivesSectionPresenter.new(data) }

      specify { expect { |b| subject.render_exceptions(&b) }.to yield_control }
    end

    describe "0 elective exceptions" do
      let(:data) { stub_presenter }

      subject { WoopleTheme::Dashboard::ElectivesSectionPresenter.new(data) }

      specify { expect { |b| subject.render_exceptions(&b) }.not_to yield_control }
    end
  end

  private

  def stub_presenter(options = {})
    defaults = {enabled?: nil, electives_history: [], electives_exceptions: [], points_earned: nil, points_total: nil}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
