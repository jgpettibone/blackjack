class window.Player1Hand extends Backbone.Firebase.Collection

  firebase: new Firebase "https://blackjack-hr.firebaseio.com/hands/player1"

  model: Card

  ready: false

  initialize: (array, @deck, @isDealer) ->
    test = 0
    # url = "https://blackjack-hr.firebaseio.com/hands/"
    # if @isDealer
    #   url = "#{url}dealer"
    # else
    #   url = "#{url}player1"
    # @firebase = new Firebase(url)

  hit: ->
    @add(@deck.pop())
    @last()

  stand: ->
    @trigger('stand')

  lose: ->
    @trigger('lose')

  win: -> 
    @trigger('win')

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if score > 21
      @lose()
      console.log()
    if hasAce then [score, score + 10] else [score]

  getBestScore: ->
    scores = @scores()
    return scores[0] if scores.length is 1
    return scores[1] if scores[1] <= 21
    return scores[0]

class window.Player2Hand extends Backbone.Firebase.Collection

  firebase: new Firebase "https://blackjack-hr.firebaseio.com/hands/player2"

  model: Card

  ready: false

  initialize: (array, @deck, @isDealer) ->
    test = 0
    # url = "https://blackjack-hr.firebaseio.com/hands/"
    # if @isDealer
    #   url = "#{url}dealer"
    # else
    #   url = "#{url}player1"
    # @firebase = new Firebase(url)

  hit: -> 
    @add(@deck.pop())
    @last()

  stand: ->
    @trigger('stand')

  lose: ->
    @trigger('lose')

  win: -> 
    @trigger('win')

  clear: ->
    @trigger('clear')

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if score > 21 then @lose()
    if hasAce then [score, score + 10] else [score]

  getBestScore: ->
    scores = @scores().slice()
    if scores[0] > 21 then return 0
    return scores[0] if scores.length is 1
    return scores[1] if scores[1] <= 21
    return scores[0]



class window.DealerHand extends Backbone.Firebase.Collection

  firebase: new Firebase "https://blackjack-hr.firebaseio.com/hands/dealer"

  model: Card

  initialize: (array, @deck, @isDealer) ->
    test = 0
    # url = "https://blackjack-hr.firebaseio.com/hands/"
    # if @isDealer
    #   url = "#{url}dealer"
    # else
    #   url = "#{url}player1"
    # @firebase = new Firebase(url)

  parse: (val)->
    console.log(val)

  hit: ->
    @add(@deck.pop())
    @last()

  stand: ->
    @trigger('stand')

  lose: ->
    @trigger('lose')

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if score > 21 then @lose()
    if hasAce then [score, score + 10] else [score]

  getBestScore: ->
    scores = @scores()
    return scores[0] if scores.length is 1
    return scores[1] if scores[1] <= 21
    return scores[0]

