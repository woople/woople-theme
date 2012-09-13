require 'spec_helper'

describe WoopleTheme::Dashboard::SectionPresenter do
  describe '#render' do
    describe 'when section is enabled' do
      let(:data) { stub_presenter }

      subject { WoopleTheme::Dashboard::SectionPresenter.new(data) }

      specify { expect { |b| subject.render(&b) }.to yield_control }
    end

    describe 'when section is not enabled' do
      let(:data) { stub_presenter(false) }

      subject { WoopleTheme::Dashboard::SectionPresenter.new(data) }

      specify { expect { |b| subject.render(&b) }.not_to yield_control }
    end
  end

  private

  def stub_presenter(enable=true)
    stub({title:'section title', enabled?: enable}).as_null_object
  end
end
