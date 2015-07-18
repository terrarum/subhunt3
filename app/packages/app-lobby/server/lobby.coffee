#Meteor.log.info "server/lobby"

Meteor.publish "games", ->
    Games.find()

Meteor.methods
    # Add a game to the lobby.
    addGame: ->
        if !Meteor.userId()
            throw new Meteor.Error("not-authorized")

        # Random variables for positioning!
        # p1's sub will be at  50 <= x <= 300, 50 <= y <= 550
        # p2's sub will be at 750 >= x >= 500, 50 <= y <= 550
        # Both sub's rotation values will be between 180 and -180
        p1x   =  50 + Math.round(Math.random() * 250)
        p1y   =  50 + Math.round(Math.random() * 500)
        p1Rot = 180 - Math.round(Math.random() * 360)
        p2x   = 750 - Math.round(Math.random() * 250)
        p2y   =  50 + Math.round(Math.random() * 500)
        p2Rot = 180 - Math.round(Math.random() * 360)

        Games.insert
            createdAt: new Date()
            ownerId: Meteor.userId()
            player1: Meteor.user().username
            player1Sub:
                x: p1x
                y: p1y
                angle: p1Rot
            player2: null
            player2Sub:
                x: p2x
                y: p2y
                angle: p2Rot
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
