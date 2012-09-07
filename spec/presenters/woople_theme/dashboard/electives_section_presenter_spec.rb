require 'spec_helper'

describe WoopleTheme::Dashboard::ElectivesSectionPresenter do
  describe "#render" do
    let(:data) { stub_presenter }
    subject { WoopleTheme::Dashboard::ElectivesSectionPresenter.new(data) }
    it "yields the block" do
      expect { |block| subject.render(&block) }.to yield_control
    end
  end

  def stub_presenter
    stub({title:'title', enabled?: true})
  end
end
