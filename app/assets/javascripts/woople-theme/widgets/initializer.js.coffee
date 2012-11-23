$(document).ready ->
  widgets = $('#navigation .widget[data-url]')

  if widgets
    widgets.on 'click', (event)->
      url = $(this).data('url')

      if url
        window.location = url

