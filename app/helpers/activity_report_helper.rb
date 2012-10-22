module ActivityReportHelper

  def activity_reports(presenter)
    render partial: 'woople-theme/reports/activity/show',
      object: ThemePresentation.wrap(presenter, WoopleTheme::Reports::ActivityReportsPresenter),
      as: 'presenter'
  end

  def activity_report_legend(legend)
    render partial: 'woople-theme/reports/activity/legend', locals: { legend: legend }
  end

  def activity_report_download(download_path)
    return if download_path.nil?

    render partial: 'woople-theme/reports/activity/download', locals: { download_path: download_path }
  end

end
