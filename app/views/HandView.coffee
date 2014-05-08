class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>Player<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on 'lose', =>
      console.log('chaning dealer hand ')
      @$el.addClass('loser')
    @collection.on 'win', => 
      @$el.addClass('winner')
    @collection.on 'clear', => 
      @$el.removeClass('winner loser')


    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      # console.log(card)
      new CardView(model: card).$el
    @$('.score').text @collection.getBestScore()