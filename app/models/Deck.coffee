class window.Deck extends Backbone.Collection

   # firebase: new Firebase("https://blackjack-hr.firebaseio.com/deck")

  model: Card

  initialize: ->
    # console.log("created new Deck: ", @)
    @add _(_.range(0, 52)).shuffle().map (card) ->
      new Card
        revealed: true
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: ->
    # console.log(@.length)
    hand = new Player1Hand([ @pop(), @pop() ], @)
    hand = new Player2Hand([ @pop(), @pop() ], @)

  dealDealer: -> new DealerHand [ @pop().flip(), @pop() ], @, true
