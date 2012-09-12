require 'spec_helper'

describe WoopleTheme::Dashboard::EssentialsSectionPresenter do
  describe "#render_remaining" do
    describe "more than one essential remaining" do
      let(:data) { stub_presenter([stub]) }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "yields the block" do
        expect { |block| subject.render_remaining(&block) }.to yield_control
      end
    end
    describe "0 essentials remaining" do
      let(:data) { stub_presenter }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "does not yield the block" do
        expect { |block| subject.render_remaining(&block)}.not_to yield_control
      end
    end
  end

  describe "#render_completed" do
    describe "more than one completed essential" do
      let(:data) { stub_presenter([],[stub]) }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "yields the block" do
        expect { |block| subject.render_completed(&block) }.to yield_control
      end
    end
    describe "0 completed essentials" do
      let(:data) { stub_presenter }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "does not yields the block" do
        expect { |block| subject.render_completed(&block)}.not_to yield_control
      end
    end
  end

  describe "#render_exceptions" do
    describe "at least one essential exception" do
      let(:data) { stub_presenter([],[],[stub]) }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "yields the block" do
        expect { |block| subject.render_exceptions(&block) }.to yield_control
      end
    end
    describe "0 essential exceptions" do
      let(:data) { stub_presenter }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "does not yield the block" do
        expect { |block| subject.render_exceptions(&block) }.not_to yield_control
      end
    end
  end

  private

  def stub_presenter(remaining=[], completed=[], exceptions=[])
    stub({title:'title', enabled?: true, essentials_remaining: remaining, essentials_completed: completed, essentials_exceptions: exceptions})
  end
end
