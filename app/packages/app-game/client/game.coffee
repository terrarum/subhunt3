#Meteor.log.info "game"

Meteor.subscribe 'games'

game = null

Template.game.helpers
    currentPlayerString: ->
        if Meteor.user().username is @.currentPlayer
            return "your"
        else
            return @.currentPlayer + "'s"
    phaser: ->
        setTimeout(->
            window.phaserGame = new Phaser.Game(800, 600, Phaser.AUTO, 'game')
        , 500)
        return ""


Template.game.events
    'click .js-delete': ->
        Meteor.call "deleteGame", game._id
        Router.go "/"
    'click #game': (ev) ->
        Meteor.call "move", ev.offsetX, ev.offsetY
    'click .fire': ->
        Meteor.call "fire"
    'click .ping': ->
        Meteor.call "ping"
