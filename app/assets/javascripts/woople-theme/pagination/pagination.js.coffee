class Pagination

  init: (@selector, options = {}, @debugMode=false) ->
    @log('initialize')

    @options = $.extend({container: null, timeout: 2500, scrollTo: 0}, options)

    @setupListeners()

  pushStateSupported: ->
    $.support.pjax

  setupListeners: ->
    @log('setup listeners')

    if @pushStateSupported()
      @configureWithPushState()
    else
      @configureWithoutPushState()

  configureWithPushState: ->
    @log('configuring with pushState support')

    $.pjax.defaults.scrollTo = @options.scrollTo;

    $(document).pjax(@selector, @options)
      .on('pjax:beforeSend', (e, xhr, err)=>
        @requestStart(e, xhr, err)
      )
      .on('pjax:success', (e, xhr, err) =>
        @requestEnd(e, xhr, err)
      )

  configureWithoutPushState: ->
    @log('configuring without pushState support')

    $(document).on 'click', @selector, (e)=>
      e.preventDefault();

      $.ajax({
        url: $(e.target).attr('href'),
        context: @,
        beforeSend: (xhr)->
          xhr.setRequestHeader('X-PJAX', 'true');
          @requestStart(e, xhr, null)
        success: (data, textStatus, xhr)->
          @requestEnd(e, xhr, null)
      })

  requestStart: (e, xhr, err)->
    @log('request is starting')
    $(@options.container).find('table tbody').css('opacity', 0.5)

  requestEnd: (e, xhr, err)->
    @log('request has finished')

    if not @pushStateSupported()
      $(@options.container).html(xhr.responseText)

      @log(typeof @options.scrollTo)

      if typeof @options.scrollTo is 'number'
        $(document).scrollTop(@options.scrollTo)

    $(@options.container).find('table tbody').css('opacity', 1)

  log: (message) ->
    console.log("[Pagination] " + message) if @debugMode

@Pagination = Pagination
