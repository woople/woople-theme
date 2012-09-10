require 'spec_helper'

describe WoopleTheme::Dashboard::ElectiveExceptionPresenter do
  describe "#title" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Dashboard::ElectiveExceptionPresenter.new(data) }

    it "should be plain text" do
      subject.title.should eq(subject.name)
    end
  end

  describe "#subtitle" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Dashboard::ElectiveExceptionPresenter.new(data) }

    it "should be formatted as points" do
      subject.subtitle.should eq(I18n.t('woople_theme.dashboards.member.points', count: subject.description, points: subject.description))
    end
  end

  private

  def stub_presenter(options = {})
    defaults = {name: 'Exception', description: 'Reason', completed_on: Time.at(rand * Time.now.to_i)}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
