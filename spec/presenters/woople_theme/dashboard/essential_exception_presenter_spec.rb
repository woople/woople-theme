require 'spec_helper'

describe WoopleTheme::Dashboard::EssentialExceptionPresenter do
  describe "#title" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Dashboard::EssentialExceptionPresenter.new(data) }

    it "should be a link to the course" do
      subject.title.should eq("<a href=\"#{subject.url}\">#{subject.name}</a>")
    end
  end

  describe "#subtitle" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Dashboard::EssentialExceptionPresenter.new(data) }

    it "should be formatted as a reason" do
      subject.subtitle.should eq(I18n.t('woople_theme.dashboards.member.exceptions.reason', reason: subject.description))
    end
  end

  private

  def stub_presenter(options = {})
    defaults = {name: "Exception", description: "Reason", url: '/course', completed_on: Time.at(rand * Time.now.to_i)}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
