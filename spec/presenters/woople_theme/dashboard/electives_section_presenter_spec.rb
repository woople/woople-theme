require 'spec_helper'

describe WoopleTheme::Dashboard::ElectivesSectionPresenter do
  describe "#render_history" do
    describe "more than one completed elective" do
      let(:data) { stub_presenter([],[stub]) }

      subject { WoopleTheme::Dashboard::ElectivesSectionPresenter.new(data) }

      it "yields the block" do
        expect { |block| subject.render_history(&block) }.to yield_control
      end
    end

    describe "0 completed/in-progress electives" do
      let(:data) { stub_presenter }

      subject { WoopleTheme::Dashboard::ElectivesSectionPresenter.new(data) }

      it "does not yields the block" do
        expect { |block| subject.render_history(&block)}.not_to yield_control
      end
    end
  end

  describe "#render_exceptions" do
    describe "at least one elective exception" do
      let(:data) { stub_presenter([],[],[stub]) }

      subject { WoopleTheme::Dashboard::ElectivesSectionPresenter.new(data) }

      it "yields the block" do
        expect { |block| subject.render_exceptions(&block) }.to yield_control
      end
    end

    describe "0 elective exceptions" do
      let(:data) { stub_presenter }

      subject { WoopleTheme::Dashboard::ElectivesSectionPresenter.new(data) }

      it "does not yield the block" do
        expect { |block| subject.render_exceptions(&block) }.not_to yield_control
      end
    end
  end

  private

  def stub_presenter(remaining=[], history=[], exceptions=[])
    stub({title:'title', enabled?: true, electives_history: history, electives_exceptions: exceptions})
  end
end
