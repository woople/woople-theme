$(document).ready ->
  if $('#reports')
    pr = new PersonalReport()
    pr.init('#reports_nav a[data-toggle="tab"]', false)

    $('#reports_nav a:first').tab('show')
