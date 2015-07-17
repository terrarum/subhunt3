#Meteor.log.info "game"

Meteor.subscribe 'games'

Template.game.helpers
    currentPlayerString: ->
        if Meteor.user().username is @.currentPlayer
            return "your"
        else
            return @.currentPlayer + "'s"

# Don't delete this.
game = null

Template.renderGrid.helpers
    grid: ->
        game = @
        if game.grid is undefined
            Router.go "/"
        return game.grid

Template.gridCell.events
    'click .js-grid-cell': ->
        return if game.currentPlayer isnt Meteor.user().username
        return if game.player2 is null
        return if @.value != ""
        Meteor.call 'updateGrid', @.id, game

Template.game.events
    'click .js-delete': ->
        Meteor.call "deleteGame", game._id
        Router.go "/"