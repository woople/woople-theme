$(document).ready ->
  if $('#reports')
    pr = new ActivityReport()
    pr.init('#reports_nav a[data-toggle="tab"]', false)

    $('#reports_nav a:first').tab('show')
