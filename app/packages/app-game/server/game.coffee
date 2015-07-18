# Return a reference to a cell by its ID.
getCellById = (cellId, grid) ->
    for i in [0...grid.length] by 1
        for j in [0...grid[i].length] by 1
            if grid[i][j].id is cellId
                return grid[i][j]

getGame = (gameId) ->
    return Games.findOne
        _id: gameId

Meteor.methods
    move: (gameId, x, y) ->
        console.log "Player Move To ", x, y
        game = getGame(gameId)
        console.log game.currentPlayer
        return if game.currentPlayer isnt Meteor.user().username
        console.log game.currentPlayer + " is the current player."

    ping: (gameId) ->
        console.log "Player Ping"
        game = getGame(gameId)
        return if game.currentPlayer isnt Meteor.user().username

    fire: (gameId) ->
        console.log "Player Fire"
        game = getGame(gameId)
        return if game.currentPlayer isnt Meteor.user().username
