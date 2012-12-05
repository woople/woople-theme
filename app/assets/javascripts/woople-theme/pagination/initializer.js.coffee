$(document).ready ->
  p = new Pagination()

  if $('#content_outline.channels').not('.episode').length
    p.init('#content_outline.channels .pagination a', {
      container: '#content_outline.channels .content_outline_details'},
    false)

  if $('#content_outline.channels.episode').length
    p.init('#content_outline.channels .pagination a', {
      container: '#content_outline.channels .content_outline_details',
      scrollTo: false},
    false)
