require 'spec_helper'

describe WoopleTheme::Dashboard::EssentialsSectionPresenter do
  describe "#render_remaining" do
    describe "more than one essential remaining" do
      let(:data) { stub_presenter([stub]) }

      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }

      specify { expect { |b| subject.render_remaining(&b) }.to yield_control }
    end

    describe "0 essentials remaining" do
      let(:data) { stub_presenter }

      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }

      specify { expect { |b| subject.render_remaining(&b) }.not_to yield_control }
    end
  end

  describe "#render_completed" do
    describe "more than one completed essential" do
      let(:data) { stub_presenter([],[stub]) }

      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }

      specify { expect { |b| subject.render_completed(&b) }.to yield_control }
    end

    describe "0 completed essentials" do
      let(:data) { stub_presenter }

      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }

      specify { expect { |b| subject.render_completed(&b) }.not_to yield_control }
    end
  end

  describe "#render_exceptions" do
    describe "at least one essential exception" do
      let(:data) { stub_presenter([],[],[stub]) }

      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }

      specify { expect { |b| subject.render_exceptions(&b) }.to yield_control }
    end

    describe "0 essential exceptions" do
      let(:data) { stub_presenter }

      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }

      specify { expect { |b| subject.render_exceptions(&b) }.not_to yield_control }
    end
  end

  private

  def stub_presenter(remaining=[], completed=[], exceptions=[])
    stub({title:'title', enabled?: true, essentials_remaining: remaining, essentials_completed: completed, essentials_exceptions: exceptions})
  end
end
