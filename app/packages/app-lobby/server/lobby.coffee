#Meteor.log.info "server/lobby"

Meteor.publish "games", ->
    Games.find()

gridModel = (x, y) ->
    #Meteor.log.info "gridModel"
    return {
        id: uuid.v4()
        x: x
        y: y
        value: ''
        owner: ''
    }

# Creates a two-dimensional array of the given size.
grid = (count) ->
    gridArr = []
    for i in [0...count] by 1
        row = []
        for j in [0...count] by 1
            row.push gridModel j, i
        gridArr.push row
    return gridArr

Meteor.methods
    # Add a game to the lobby.
    addGame: ->
        if !Meteor.userId()
            throw new Meteor.Error("not-authorized")

        gridSize = 3

        Games.insert
            createdAt: new Date()
            ownerId: Meteor.userId()
            player1: Meteor.user().username
            player2: null
            currentPlayer: Meteor.user().username
            grid: grid(gridSize)
            cellCount: gridSize * gridSize
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
