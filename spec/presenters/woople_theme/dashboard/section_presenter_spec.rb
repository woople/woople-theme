require 'spec_helper'

describe WoopleTheme::Dashboard::SectionPresenter do
  describe '#render' do
    describe 'when section is enabled' do
      let(:data) { stub_presenter }
      subject { WoopleTheme::Dashboard::SectionPresenter.new(data) }
      it "yields the block" do
        expect { |block| subject.render &block }.to yield_control
      end
    end

    describe 'when section is not enabled' do
    let(:data) { stub_presenter(false) }
      subject { WoopleTheme::Dashboard::SectionPresenter.new(data) }
      it "does not yield the block" do
        expect { |block| subject.render &block }.not_to yield_control
      end
    end
  end

  def stub_presenter(enable=true)
    stub({title:'section title', enabled?: enable}).as_null_object
  end
end
