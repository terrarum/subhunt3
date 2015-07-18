#Meteor.log.info "server/lobby"

Meteor.publish "games", ->
    Games.find()

Meteor.methods
    # Add a game to the lobby.
    addGame: ->
        if !Meteor.userId()
            throw new Meteor.Error("not-authorized")

        Games.insert
            createdAt: new Date()
            ownerId: Meteor.userId()
            player1: Meteor.user().username
            player2: null
            currentPlayer: Meteor.user().username
            status:
                tie: false
                waiting: true
                playing: false
                won: false

    # Delete a game from the lobby.
    deleteGame: (gameId) ->
        Games.remove gameId

    # Join a game.
    joinGame: (gameId) ->
        Games.update gameId,
            $set:
                player2: Meteor.user().username
                status:
                    tie: false
                    waiting: false
                    playing: true
                    won: false
