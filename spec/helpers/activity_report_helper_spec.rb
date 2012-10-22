require 'spec_helper'

describe ActivityReportHelper do

  describe "#activity_reports" do
    it 'renders correctly' do
      report_stub = stub(name: 'Daily', type: :week, data_path: '/data.json', download_path: '/data.csv')

      helper_stub = stub(reports: [report_stub])
      html = helper.activity_reports(helper_stub)
      page = Capybara::Node::Simple.new(html)

      page.find('#reports_nav li:first-child').text.should eq(report_stub.name)
      page.find('#reports_data .report-download a')[:href].should eq(report_stub.download_path)
    end
  end

  describe "#activity_report_legend" do
    it 'renders correctly' do
      helper_stub = ['1-2', '3-4', '5+']
      html = helper.activity_report_legend(helper_stub)
      page = Capybara::Node::Simple.new(html)

      page.find('.legend span:nth-child(1)')[:class].should eq('badge badge-error')
      page.find('.legend span:nth-child(1)').text.should eq(I18n.t('woople_theme.reports.legend.viewed', range: helper_stub[0]))

      page.find('.legend span:nth-child(2)')[:class].should eq('badge badge-warning')
      page.find('.legend span:nth-child(2)').text.should eq(I18n.t('woople_theme.reports.legend.viewed', range: helper_stub[1]))

      page.find('.legend span:nth-child(3)')[:class].should eq('badge badge-success')
      page.find('.legend span:nth-child(3)').text.should eq(I18n.t('woople_theme.reports.legend.viewed', range: helper_stub[2]))
    end
  end

  describe "#activity_report_download" do
    it 'renders correctly' do
      path = 'http://example.com'
      html = helper.activity_report_download(path)
      page = Capybara::Node::Simple.new(html)

      page.find('a')[:href].should eq(path)
      page.find('a').text.should eq(" Download")
    end

    it 'returns nil when a link is not provided' do
      path = nil
      html = helper.activity_report_download(path)

      html.should be_nil
    end
  end
end
