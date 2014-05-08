deck = new Deck()
player1Hand = new Player1Hand([], deck)
player2Hand = new Player2Hand([], deck)
dealerHand = new DealerHand([], deck, true)
# dealerHand = new Hand()
setTimeout( =>
  # console.log(dealerHand);
  new AppView(model: new App(deck, player1Hand, player2Hand, dealerHand)).$el.appendTo 'body'
,1000)
