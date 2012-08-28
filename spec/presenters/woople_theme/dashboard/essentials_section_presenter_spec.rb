require 'spec_helper'

describe WoopleTheme::Dashboard::EssentialsSectionPresenter do
  describe "#render_remaining" do
    describe "more than one essential remaining" do
      let(:data) { stub_presenter([stub]) }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "yields the block" do
        expect { |block| subject.render_remaining &block }.to yield_control
      end
    end
    describe "0 essentials remaining" do
      let(:data) { stub_presenter([]) }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "does not yield the block" do
        expect { |block| subject.render_remaining &block }.not_to yield_control
      end
    end
  end
  def stub_presenter(essentials)
    stub({title:'title', enabled?: true, essentials_remaining: essentials})
  end
end
