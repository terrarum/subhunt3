Meteor.subscribe 'games'

Template.game.helpers
    currentPlayerString: ->
        if Meteor.user().username is @.currentPlayer
            return "your"
        else
            return @.currentPlayer + "'s"
    phaser: ->
        console.log "phaser render"
        setTimeout(->
            window.phaserGame = new Phaser.Game(800, 600, Phaser.AUTO, 'game')
        , 500)
        return ""


Template.game.events
    'click .js-delete': ->
        Meteor.call "deleteGame", game._id
        Router.go "/"
    'click #game': (ev) ->
        Meteor.call "move", @._id, ev.offsetX, ev.offsetY
    'click .fire': ->
        Meteor.call "fire", @._id
    'click .ping': ->
        Meteor.call "ping", @._id
