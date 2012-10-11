#= require spec_helper
#= require twitter/bootstrap/tab
#= require highcharts
#= require woople-theme/reports/personal_report

describe 'PersonalReport', ->
  beforeEach ->
    $('body').html( JST['templates/tabs']() )

    @selector = $('#spec_reports_nav a[data-toggle="tab"]')
    @sut      = new PersonalReport()

  describe 'shownListener', ->
    it 'should load the report based on the selector data-attributes', ->
      spy  = sinon.spy(@sut, 'shownListener')
      stub = sinon.stub(@sut, 'loadReport').returns(true)

      @sut.init(@selector, false)

      @selector.trigger('shown')

      expect(spy).to.have.been.calledOnce
      expect(stub).to.have.been.calledOnce

      spy.restore()
      stub.restore()

  describe 'loadReport', ->
    describe 'successful response', ->
      it 'builds the report', ->
        stub1 = sinon.stub(jQuery, 'ajax').yieldsTo('success', [1, 2, 3])
        stub2 = sinon.stub(@sut, 'buildReport').returns(true)
        spy   = sinon.spy(@sut, 'successCallback')

        @sut.init(@selector, false)

        target = @selector.attr('data-toggle')

        @sut.loadReport(
          $(target).attr('data-type'),
          $(target).attr('data-container'),
          $(target).attr('data-path')
        )

        expect(stub1).to.have.been.calledOnce
        expect(stub2).to.have.been.calledOnce
        expect(spy.withArgs([1, 2, 3])).to.have.been.calledOnce

        stub1.restore()
        stub2.restore()
        spy.restore()

    describe 'error response', ->
      it 'currently does nothing', ->
        stub = sinon.stub(jQuery, 'ajax').yieldsTo('error', [1, 2, 3])
        spy  = sinon.spy(@sut, 'errorCallback')

        @sut.init(@selector, false)

        target = @selector.attr('data-toggle')

        @sut.loadReport(
          $(target).attr('data-type'),
          $(target).attr('data-container'),
          $(target).attr('data-path')
        )

        expect(stub).to.have.been.calledOnce
        expect(spy.withArgs([1, 2, 3])).to.have.been.calledOnce

        stub.restore()
        spy.restore()

  describe 'buildReport', ->
    it 'should render the chart', ->
      stub1 = sinon.stub(@sut, 'highchartOptions').returns(true)
      stub2 = sinon.stub(Highcharts, 'Chart').returns(true)

      @sut.buildReport()

      expect(@sut.chart).to.exist
      expect(stub1).to.have.been.calledOnce
      expect(stub2.withArgs(@sut.highchartOptions())).to.have.been.calledOnce

      stub1.restore()
      stub2.restore()

  describe 'reportTitle', ->
    it 'should use the data-title of the active tab pane', ->
      @sut.reportType = 'week'

      expect(@sut.reportTitle()).to.equal($('#week').data('title'))

  describe 'categories', ->
    it 'creates an array of formatted categories', ->
      spy = sinon.spy(@sut, 'formatCategoryName')

      dataMock =
        primary_name: "2012-10-05"
        secondary_name: ""

      @sut.reportData = [dataMock]

      categories = @sut.categories()

      expect(spy).to.have.been.calledOnce
      expect(categories).to.not.be.empty

      spy.restore()

  describe 'formatCategoryName', ->
    it 'formats the chart category name', ->
      data =
        primary_name: 'Primary'
        secondary_name: 'Secondary'

      expect(@sut.formatCategoryName(data)).to.equal("<strong>Primary</strong><br />Secondary")

  describe 'uniqueViews', ->
    it 'creates an array of formatted views', ->
      spy = sinon.spy(@sut, 'gradeColour')

      dataMock =
        primary_name: "2012-10-05"
        secondary_name: "",
        views: 1,
        relearns: 1

      @sut.reportData = [dataMock]

      uniqueViews = @sut.uniqueViews()

      expect(spy.withArgs(dataMock)).to.have.been.calledOnce
      expect(uniqueViews).to.not.be.empty

      spy.restore()

  describe 'relearns', ->
    it 'creates an array of formatted relearns', ->
      spy = sinon.spy(@sut, 'gradeColour')

      dataMock =
        primary_name: "2012-10-05"
        secondary_name: "",
        views: 1,
        relearns: 1

      @sut.reportData = [dataMock]

      relearns = @sut.relearns()

      expect(spy.withArgs(dataMock)).to.have.been.calledOnce
      expect(relearns).to.not.be.empty

      spy.restore()

  describe 'gradeColour', ->
    afterEach ->
      @stub.restore()

    it 'returns GREEN when above or equal to the GREEN_GOAL', ->
      @stub = sinon.stub(@sut, 'isWeekly').returns(true)

      dataMock =
        views: 7
        relearns: 0

      expectation = "rgba(#{PersonalReport.GREEN}, 1)"

      expect(@sut.gradeColour(dataMock, 1)).to.equal(expectation)

    it 'returns YELLOW when between the YELLOW_GOAL and GREEN_GOAL', ->
      @stub = sinon.stub(@sut, 'isWeekly').returns(true)

      dataMock =
        views: 4
        relearns: 0

      expectation = "rgba(#{PersonalReport.YELLOW}, 1)"

      expect(@sut.gradeColour(dataMock, 1)).to.equal(expectation)

    it 'returns RED when beneath the YELLOW_GOAL', ->
      @stub = sinon.stub(@sut, 'isWeekly').returns(true)

      dataMock =
        views: 1
        relearns: 0

      expectation = "rgba(#{PersonalReport.RED}, 1)"

      expect(@sut.gradeColour(dataMock, 1)).to.equal(expectation)

  describe 'multiplier', ->
    it 'returns 1 if report type is week', ->
      @sut.reportType = 'week'
      expect(@sut.multiplier()).to.equal(1)

    it 'returns 7 if report type is month', ->
      @sut.reportType = 'month'
      expect(@sut.multiplier()).to.equal(7)

    it 'returns 31 if report type is annual', ->
      @sut.reportType = 'annual'
      expect(@sut.multiplier()).to.equal(31)

  describe 'log', ->
    it 'should write to the console when debugging is enabled', ->
      stub = sinon.stub(console, 'log').returns(true)

      @sut.init('x', true)

      expect(stub.withArgs("[PersonalReport] initialize")).to.have.been.calledOnce
      stub.restore()

    it 'should not write to the console when debugging is disabled', ->
      stub = sinon.stub(console, 'log').returns(true)

      @sut.init('x', false)

      expect(stub).to.not.have.been.called
      stub.restore()
