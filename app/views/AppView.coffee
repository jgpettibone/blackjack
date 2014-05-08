class window.AppView extends Backbone.View

  template: _.template '
    <button class="deal-button">Deal</button><button class="stand-button">Stand</button>
    <div class="dealer-hand-container"></div>
    <button class="hit-button-1">Hit</button>
    <div class="player1-hand-container"></div>
    <button class="hit-button-2">Hit</button>
    <div class="player2-hand-container"></div>
  '

  events:
    "click .hit-button-1": -> @model.get('player1Hand').hit()
    # "click .stand-button-1": ->
    #   @buttons(off, 1)
    #   @model.get('player1Hand').stand()
    "click .hit-button-2": -> @model.get('player2Hand').hit()
    # "click .stand-button-2": ->
    #   @buttons(off, 2)
    #   @model.get('player2Hand').stand()
    "click .stand-button": ->
      console.log(@model.collection)
      @model.set('standCount', @model.get('standCount') + 1)
      if @model.get('standCount') is 2 then @model.dealersTurn()
      # @model.standCount = @model.standCount + 1
      # if @model.standCount is 2 then @model.dealersTurn
    "click .deal-button": ->
      # console.log("dealing")
      # @buttons(on)
      @model.setNewHands()
      @render()

  initialize: ->
    # @model.on('rebind', => @attachListeners())
    # @model.on('unbind', => @detachListeners())
    @model.get('dealerHand').on('add remove', =>
      @model.checkWinner()
    )
    # @model.get('player1Hand').on('lose', => @upStand())
    # @model.get('player2Hand').on('lose', => @upStand())
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player1-hand-container').html new HandView(collection: @model.get 'player1Hand').el
    @$('.player2-hand-container').html new HandView(collection: @model.get 'player2Hand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  attachListeners: ->
    return

  detachListeners: ->
    @model.get('player1Hand').off()
    @model.get('player2Hand').off()
    @model.get('dealerHand').off()


  # buttons: (state, player)->
  #   if (player is 1)
  #     @$('.hit-button-1').prop('disabled', !state)
  #     @$('.stand-button-1').prop('disabled', !state)
  #   else if (player is 2)
  #     @$('.hit-button-2').prop('disabled', !state)
  #     @$('.stand-button-2').prop('disabled', !state)
  #   else
  #     @$('.hit-button-1').prop('disabled', !state)
  #     @$('.stand-button-1').prop('disabled', !state)
  #     @$('.hit-button-2').prop('disabled', !state)
  #     @$('.stand-button-2').prop('disabled', !state)

