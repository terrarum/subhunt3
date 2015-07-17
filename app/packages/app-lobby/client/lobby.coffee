#Meteor.log.info "client/lobby"

Template.lobby.events
    'click .js-new-game': ->
        createGame()

Template.gameItem.events
    'click .js-delete': ->
        deleteGame @

    'click .js-join': ->
        joinGame @

    'click .js-resume': ->
        Router.go '/game/' + this._id

createGame = ->
    Meteor.call 'addGame', (error, gameId) ->
        if (error)
            console.log "Something went wrong while creating your game."
        else
            Router.go '/game/' + gameId

deleteGame = (game) ->
    Meteor.call 'deleteGame', game._id

joinGame = (game) ->
    Meteor.call 'joinGame', game._id
    Router.go '/game/' + game._id

# Returns all open games.
Template.gamesList.helpers
    gamesList: ->
        return Games.find
            "status.waiting": true
            player2: null
            player1:
                $not: Meteor.user().username

# Returns any games that you are a player of that are not open.
Template.yourGamesList.helpers
    gamesList: ->
        return Games.find
            $or: [
                    player1: Meteor.user().username
                ,
                    player2: Meteor.user().username
            ]

Template.gameItem.helpers
    # Returns whether or not the current user is the
    # owner of the game.
    owner: ->
        return Meteor.userId() == @.ownerId
    memberOf: ->
        username = Meteor.user().username
        if @.player1 is username or @.player2 is username
            console.log "member of"
            return true
        else
            console.log "not member of"
            return false
