getGame = (gameId) ->
    return Games.findOne
        _id: gameId

Meteor.methods
    move: (gameId, x, y) ->
        console.log "Player Move To ", x, y
        game = getGame(gameId)
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
