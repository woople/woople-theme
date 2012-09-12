require 'spec_helper'

describe WoopleTheme::Dashboard::ExceptionPresenter do
  describe "#title" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Dashboard::ExceptionPresenter.new(data) }

    it "should be plain text" do
      subject.title.should eq(subject.name)
    end
  end

  describe "#date" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Dashboard::ExceptionPresenter.new(data) }

    it "should be formatted / localized" do
      subject.date.should eq(WoopleThemeI18n.l(subject.completed_on.to_date))
    end
  end

  private

  def stub_presenter(options = {})
    defaults = {name: "Exception", description: "Reason", url: '/course', completed_on: Time.at(rand * Time.now.to_i)}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
