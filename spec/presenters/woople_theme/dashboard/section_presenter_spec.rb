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

  describe '#title' do
    let(:data) { stub_presenter }
    subject { WoopleTheme::Dashboard::SectionPresenter.new(data) }

    it "returns a titlized title" do
      subject.title.should == "Section Title"
    end
  end

  describe "#css_id" do
    let(:data) { stub_presenter }
    subject { WoopleTheme::Dashboard::SectionPresenter.new(data) }

    it "returns a parameterized/cssnamified version of the section title" do
      subject.css_id.should == "section-title-section"
    end
  end

  def stub_presenter(enable=true)
    stub({title:'section title', enabled?: enable}).as_null_object
  end
end
