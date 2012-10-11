module PersonalReportHelper

  def personal_reports(presenter)
    render partial: 'woople-theme/reports/personal/show',
      object: ThemePresentation.wrap(presenter, WoopleTheme::Reports::PersonalReportsPresenter),
      as: 'presenter'
  end

  def personal_report_legend(legend)
    render partial: 'woople-theme/reports/personal/legend', locals: { legend: legend }
  end

  def personal_report_download(download_path)
    return if download_path.nil?

    render partial: 'woople-theme/reports/personal/download', locals: { download_path: download_path }
  end

end
