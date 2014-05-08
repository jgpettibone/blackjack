#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model
  #firebase: new Firebase("https://blackjack-hr.firebaseio.com/app")

  initialize: (deck, player1Hand, player2Hand, dealerHand) ->
    # load deck from server
    @set 'deck', deck
    @set 'player1Hand', player1Hand
    @set 'player2Hand', player2Hand
    @set 'dealerHand', dealerHand
    @set 'standCount', 0

  dealersTurn: ->
    # console.log("player1 ", @get('player1Hand').ready, " and player2 ", @get('player2Hand').ready)
    # if @get('player1Hand').ready and @get('player2Hand').ready
      @set 'standCount', 0
      dealerHand = @get('dealerHand')
      player1Hand = @get('player1Hand')
      player2Hand = @get('player2Hand')
      dealerHand.first().flip()
      while (Math.min.apply(@, dealerHand.scores()) < 17)
        dealerHand.hit()
      # if player1Hand.getBestScore() is dealerHand.getBestScore() then @trigger('push')
      # else if dealerHand.getBestScore() > player1Hand.getBestScore() then player1Hand.lose()

      # if player2Hand.getBestScore() is dealerHand.getBestScore() then @trigger('push')
      # else if dealerHand.getBestScore() > player2Hand.getBestScore() then player2Hand.lose()
      # else dealerHand.lose()

  setNewHands: ->
    # @get(('player1Hand')).ready = false
    # @get(('player2Hand')).ready = false
    # @get(('player1Hand')).clear()
    # @get(('player2Hand')).clear()

    # console.log("player1 ", @get('player1Hand').ready, " and player2 ", @get('player2Hand').ready)

    if @lowDeck()
      @set('deck', new Deck())
    # @trigger('unbind')

    @get('player1Hand').reset([])
    @get('player2Hand').reset([])
    @get('deck').dealPlayer()
    @get('dealerHand').reset([])

    @get('deck').dealDealer()
    # @trigger('rebind')

  lowDeck: ->
    if @get('deck').length > 8 then false else true

  checkWinner: ->
    if @get('dealerHand').getBestScore() > 16
      if @get('dealerHand').getBestScore() > 21
        if @get('player1Hand').getBestScore() > 21 then @get('player1Hand').lose() else @get('player1Hand').win()
        if @get('player2Hand').getBestScore() > 21 then @get('player2Hand').lose() else @get('player2Hand').win()
      else
        if @get('player1Hand').getBestScore() >= @get('dealerHand').getBestScore()
          @get('player1Hand').win()
        else
          @get('player1Hand').lose()
        if @get('player2Hand').getBestScore() >= @get('dealerHand').getBestScore()
          @get('player2Hand').win()
        else
          @get('player2Hand').lose()
