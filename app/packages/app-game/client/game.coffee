Meteor.subscribe 'games'

Template.game.helpers
    currentPlayerString: ->
        if Meteor.user().username is @.player1
            currentPos = @.player1Sub
        if Meteor.user().username is @.player2
            currentPos = @.player2Sub

        Session.set "currentPlayerPos", currentPos

        if Meteor.user().username is @.currentPlayer
            return "your"
        else
            return @.currentPlayer + "'s"
    phaser: ->
        console.log "phaser"
        $(document).trigger("renderPhaser")

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
