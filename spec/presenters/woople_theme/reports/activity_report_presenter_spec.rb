require 'spec_helper'

describe WoopleTheme::Reports::ActivityReportPresenter do
  describe "#report_link" do
    let(:data) { stub_presenter(name: 'daily', type: 'daily') }

    subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

    specify { subject.report_link.should eq('<a href="#daily" data-container="daily_report_chart" data-path="/data.json" data-toggle="tab" data-type="daily">Daily</a>') }
  end

  describe "#name" do
    let(:data) { stub_presenter(name: 'daily') }

    subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

    specify { subject.name.should eq('Daily') }
  end

  describe "#tab_name" do
    let(:data) { stub_presenter(type: 'Test') }

    subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

    specify { subject.tab_name.should eq('test') }
  end

  describe "#href" do
    let(:data) { stub_presenter(type: 'test') }

    subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

    specify { subject.href.should eq('#test') }
  end

  describe "#container" do
    let(:data) { stub_presenter(type: 'test') }

    subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

    specify { subject.container.should eq('test_report_chart') }
  end

  describe "#legend" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

    describe 'when report is daily' do
      it 'returns the correct legend' do
        subject.stub(:daily?) { true }

        subject.legend.should eq(WoopleTheme::Reports::ActivityReportPresenter::DAILY_LEGEND)
      end
    end

    describe 'when report is weekly' do
      it 'returns the correct legend' do
        subject.stub(:weekly?) { true }

        subject.legend.should eq(WoopleTheme::Reports::ActivityReportPresenter::WEEKLY_LEGEND)
      end
    end

    describe 'when report is monthly' do
      it 'returns the correct legend' do
        subject.stub(:monthly?) { true }

        subject.legend.should eq(WoopleTheme::Reports::ActivityReportPresenter::MONTHLY_LEGEND)
      end
    end
  end

  describe "#chart_title" do
    let(:data) { stub_presenter }

    subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

    describe 'when report is daily' do
      it 'returns the correct title' do
        subject.stub(:daily?) { true }

        subject.chart_title.should eq(I18n.t('woople_theme.reports.chart.titles.daily'))
      end
    end

    describe 'when report is weekly' do
      it 'returns the correct title' do
        subject.stub(:weekly?) { true }

        subject.chart_title.should eq(I18n.t('woople_theme.reports.chart.titles.weekly'))
      end
    end

    describe 'when report is monthly' do
      it 'returns the correct title' do
        subject.stub(:monthly?) { true }

        subject.chart_title.should eq(I18n.t('woople_theme.reports.chart.titles.monthly'))
      end
    end
  end

  describe "#daily?" do
    describe 'when report type is week' do
      let(:data) { stub_presenter(type: 'week') }

      subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

      specify { subject.daily?.should be_true }
    end

    describe 'when report type is not week' do
      let(:data) { stub_presenter(type: 'week-not') }

      subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

      specify { subject.daily?.should_not be_true }
    end
  end

  describe "#weekly?" do
    describe 'when report type is month' do
      let(:data) { stub_presenter(type: 'month') }

      subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

      specify { subject.weekly?.should be_true }
    end

    describe 'when report type is not month' do
      let(:data) { stub_presenter(type: 'month-not') }

      subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

      specify { subject.weekly?.should_not be_true }
    end
  end

  describe "#monthly?" do
    describe 'when report type is annual' do
      let(:data) { stub_presenter(type: 'annual') }

      subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

      specify { subject.monthly?.should be_true }
    end

    describe 'when report type is not annual' do
      let(:data) { stub_presenter(type: 'annual-not') }

      subject { WoopleTheme::Reports::ActivityReportPresenter.new(data) }

      specify { subject.monthly?.should_not be_true }
    end
  end

  private

  def stub_presenter(options = {})
    defaults = {name: nil, type: nil, data_path: '/data.json', download_path: '/data.csv'}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
