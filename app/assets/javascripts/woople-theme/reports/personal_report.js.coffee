class PersonalReport
  @RED    = '255, 0, 0';
  @YELLOW = '255, 215, 0';
  @GREEN  = '70, 136, 71';

  @YELLOW_GOAL = 4;
  @GREEN_GOAL  = 7;

  init: (selector, @debugMode) ->
    @selector  = $(selector)

    @log('initialize')
    @setupListeners()

  setupListeners: ->
    @log('setup listeners')

    @selector.on 'shown', $.proxy(this, 'shownListener')

  shownListener: (event) ->
    @log('tab shown: ' + $(event.target).attr('href'))

    @loadReport(
      $(event.target).attr('data-type'),
      $(event.target).attr('data-container'),
      $(event.target).attr('data-path')
    )

  loadReport: (@reportType, @container, path) ->
    @log('report: loading...')

    $.ajax path,
      type: 'GET',
      success: $.proxy(this, 'successCallback'),
      error: $.proxy(this, 'errorCallback')

  successCallback: (data, textStatus, jqXHR) ->
    @log('report: loaded')

    @reportData = data

    @buildReport()

  errorCallback: (jqXHR, textStatus, errorThrown) ->
    @log('report: error')

  highchartOptions: ->
    options =
      chart:
        borderRadius: 0
        renderTo: @container
        height: 400
        type: 'column'
      title:
        text: @reportTitle()
      tooltip:
        borderColor: 'darkGrey'
        useHMTL: true
        headerFormat: '<strong>{series.name}</strong></table>'
        pointFormat:
          '<tbody>
          <tr><td>Total:</td><td>{point.y}</td></tr>
          </tbody>'
        footerFormat: '</table>'
      xAxis:
        categories: @categories()
        labels:
          formatter: ->
            numberOfAxisLabels = @axis.categories.length

            # if we end up excluding labels, we determine an even or odd number
            # of elements so that we always end up displaying the right-most label
            offset = numberOfAxisLabels % 2;
            index  = @axis.categories.indexOf(@value)

            if ((index + offset) % 2 == 0 and $(window).width() <= 500)
              return ''
            else
              return @value
      yAxis:
        title:
          text: "Views/Relearns"
        stackLabels:
          enabled: true
          style:
            fontWeight: 'bold'
            color: 'grey'
      plotOptions:
        series:
          stacking: 'normal'
          borderColor: 'white'
      series: [{
        type: 'column'
        name: 'Relearns'
        data: @relearns()
        borderColor: 'white'
        shadow: false
      },{
        type: 'column'
        name: 'Unique Views'
        data: @uniqueViews()
        borderColor: 'white'
        shadow: false
      }]
      credits:
        enabled: false
      legend:
        enabled: false

    options

  buildReport: ->
    @log('report: building')

    @chart = new Highcharts.Chart(@highchartOptions())

  reportTitle: ->
    @log('report title for: '+ @reportType);

    $('#'+ @reportType).data('title');

  categories: ->
    categories = []
    categories.push @formatCategoryName category for category in @reportData
    categories

  formatCategoryName: (data) ->
    return "<strong>#{data.primary_name}</strong><br />#{data.secondary_name}"

  uniqueViews: ->
    uniqueViews = []

    uniqueViews.push(
      y: data.views,
      color: @gradeColour(data, 1)
    ) for data in @reportData

    uniqueViews

  relearns: ->
    relearns = []

    relearns.push(
      y: data.relearns,
      color: @gradeColour(data, 0.5)
    ) for data in @reportData

    relearns

  gradeColour: (data, opacity) ->
    total = (parseInt(data.views, 10) + parseInt(data.relearns, 10))

    return "rgba(#{PersonalReport.RED}, #{opacity})" if (total < (PersonalReport.YELLOW_GOAL * @multiplier()))
    return "rgba(#{PersonalReport.YELLOW}, #{opacity})" if (total < (PersonalReport.GREEN_GOAL * @multiplier()))
    return "rgba(#{PersonalReport.GREEN}, #{opacity})" if (total >= (PersonalReport.GREEN_GOAL * @multiplier()))

  multiplier: ->
    return 1 if @isWeekly()
    return 7 if @isMonthly()
    return 31 if @isAnnually()

  isWeekly: ->
    @reportType is 'week'

  isMonthly: ->
    @reportType is 'month'

  isAnnually: ->
    @reportType is 'annual'

  log: (message) ->
    console.log("[PersonalReport] " + message) if @debugMode

@PersonalReport = PersonalReport
