require_relative '../../app/presenters/content_item_presenter'
require_relative '../../spec/support/content_image_example'
require 'active_support/core_ext/object/blank'
require 'spec_helper'

describe ContentItemPresenter do
  let(:presenter) { ContentItemPresenter }
  include_examples 'content_image'

  describe "#render_elective_points" do
    let(:data) { stub_presenter() }

    subject { ContentItemPresenter.new(data) }

    specify { expect { |b| subject.render_elective_points(&b) }.not_to yield_control }
  end

  describe "#render_essential_duration" do
    let(:data) { stub_presenter() }

    subject { ContentItemPresenter.new(data) }

    specify { expect { |b| subject.render_essential_duration(&b) }.not_to yield_control }
  end

  describe "#render_certification_metadata" do
    describe "when null certification_metadata" do
      subject { ContentItemPresenter.new(stub_presenter(certification_metadata:nil)) }

      specify { expect { |b| subject.render_certification_metadata(&b) }.not_to yield_control }
    end

    describe "when present certification_metadata" do
      subject { ContentItemPresenter.new(stub_presenter(certification_metadata:'data')) }

      specify { expect { |b| subject.render_certification_metadata(&b) }.to yield_control }
    end
  end

  describe "#render_popularity" do
    let(:data) { stub_presenter() }

    subject { ContentItemPresenter.new(data) }

    specify { expect { |b| subject.render_popularity(&b) }.to yield_control }
  end

  describe "#render_time_remaining" do
    let(:data) { stub_presenter() }

    subject { ContentItemPresenter.new(data) }

    specify { expect { |b| subject.render_time_remaining(&b) }.to yield_control }
  end

  describe "#render_progress_bar" do
    let(:data) { stub_presenter(percent_complete: 100) }

    subject { ContentItemPresenter.new(data) }

    specify { expect { |b| subject.render_progress_bar(&b) }.to yield_control }
  end

  describe "#completed_class" do
    describe "when the object is completed" do
      subject { ContentItemPresenter.new(stub_presenter(completed?: true)) }

      it "has a class of completed" do
        subject.completed_class.should == 'completed'
      end
    end

    describe "when the object is incompleted" do
      subject { ContentItemPresenter.new(stub_presenter(completed?: false)) }

      it "has a class of nil" do
        subject.completed_class.should be_nil
      end
    end
  end

  private

  def stub_presenter(options = {})
    defaults = {name: 'Content Item', url: '/course', image: nil}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
