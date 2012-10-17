#= require spec_helper
#= require underscore-min
#= require woople-theme/organization_dashboard_controller

describe 'OrganizationDashboardController', ->
  beforeEach ->
    $('body').html('<div id="organization-accounts"><div class="status-alert"></div><div class="remind-column"><button class="btn"></div></div></div>')
    @sut = new OrganizationDashboardController()

  describe 'init', ->
    it 'sets up the listeners', ->
      callback =
        reminderCallback: 'foo'
      listenersStub = sinon.stub(@sut, 'setupListeners')

      @sut.init(callback)
      expect(listenersStub).to.have.been.calledOnce

  describe 'setupListeners', ->
    beforeEach ->
      @mobileStub = sinon.stub(@sut, 'mobileSetup')
      @buttonsStub = sinon.stub(@sut, 'bindReminderButtons')
      @sut.setupListeners()

    it 'sets up mobile', ->
      expect(@mobileStub).to.have.been.calledOnce

    it 'binds reminder buttons', ->
      expect(@buttonsStub).to.have.been.calledOnce

  describe 'mobileSetup', ->
    it 'switches the button when on a small screen', ->
      sinon.stub(@sut, 'isPhone').returns(true)
      @sut.mobileSetup()
      expect($('#organization-accounts button').hasClass('btn-large')).to.be.true

    it 'does not switch the button on other screens', ->
      sinon.stub(@sut, 'isPhone').returns(false)
      sinon.stub(@sut,'createPopover')
      @sut.mobileSetup()
      expect($('#organization-accounts button').hasClass('btn-large')).to.be.false

  #this is a bit integrated, otherwise we end up in some funky stubbing
  describe 'bindReminderButtons', ->
    it 'binds the callback to the click event', ->
      callbackSpy = sinon.spy()
      options =
        reminderCallback: callbackSpy
      sinon.stub(@sut,'createPopover')
      @sut.init(options)
      $('#organization-accounts .remind-column .btn').first().click()
      expect(callbackSpy).to.have.been.calledOnce

  describe 'log', ->
    beforeEach ->
      sinon.stub(@sut,'setupListeners')

    it 'writes to the console when debugging is enabled', ->
      stub = sinon.stub(console, 'log').returns(true)

      @sut.init(
        reminderCallback: 'foo'
        , true # debugMode
      )

      expect(stub).to.have.been.calledOnce
      stub.restore()

    it 'does not write to the console when debugging is disabled', ->
      stub = sinon.stub(console, 'log').returns(true)

      @sut.init(
        reminderCallback: 'foo'
        , false # debugMode
      )

      expect(stub).to.not.have.been.called
      stub.restore()

  describe 'isPhone', ->
    it 'returns true when the window width is phone sized', ->
      windowStub = sinon.stub(@sut, "windowWidth").returns(480)
      expect(@sut.isPhone()).to.be.true
      windowStub.restore()

      windowStub =sinon.stub(@sut, "windowWidth").returns(280)
      expect(@sut.isPhone()).to.be.true
      windowStub.restore()

    it 'returns false when the window is not phone sized', ->
      windowStub = sinon.stub(@sut, 'windowWidth').returns(1000)
      expect(@sut.isPhone()).to.be.false
      windowStub.restore()

      windowStub = sinon.stub(@sut, 'windowWidth').returns(481)
      expect(@sut.isPhone()).to.be.false
