require_relative '../../app/presenters/content_item_presenter'
require_relative '../../spec/support/content_image_example'
require 'active_support/core_ext/object/blank'

describe ContentItemPresenter do
  let(:presenter) { ContentItemPresenter }
  include_examples 'content_image'

  describe "#render_elective_points" do
    let(:data) { stub_presenter() }

    subject { ContentItemPresenter.new(data) }

    it "should not yield" do
      expect { |block| subject.render_elective_points(&block).not_to yield_control }
    end
  end

  describe "#render_essential_duration" do
    let(:data) { stub_presenter() }

    subject { ContentItemPresenter.new(data) }

    it "should not yield" do
      expect { |block| subject.render_essential_duration(&block).not_to yield_control }
    end
  end

  describe "#render_certification_metadata" do
    describe "when null certification_metadata" do
      subject { ContentItemPresenter.new(stub_presenter(certification_metadata:nil)) }

      it "does not yield metadata" do
        expect { |block| subject.render_elective_points(&block).not_toyield_control }
      end
    end

    describe "when present certification_metadata" do
      subject { ContentItemPresenter.new(stub_presenter(certification_metadata:'data')) }

      it "yields metadata" do
        expect { |block| subject.render_elective_points(&block).to yield_control }
      end
    end
  end

  describe "#render_popularity" do
    let(:data) { stub_presenter() }

    subject { ContentItemPresenter.new(data) }

    it "should yield" do
      expect { |block| subject.render_popularity(&block).to yield_control }
    end
  end

  describe "#render_time_remaining" do
    let(:data) { stub_presenter() }

    subject { ContentItemPresenter.new(data) }

    it "should yield" do
      expect { |block| subject.render_time_remaining(&block).to yield_control }
    end
  end

  describe "#render_progress_bar" do
    let(:data) { stub_presenter() }

    subject { ContentItemPresenter.new(data) }

    it "should yield" do
      expect { |block| subject.render_progress_bar(&block).to yield_control }
    end
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
