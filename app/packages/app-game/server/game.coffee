# Return a reference to a cell by its ID.
getCellById = (cellId, grid) ->
    for i in [0...grid.length] by 1
        for j in [0...grid[i].length] by 1
            if grid[i][j].id is cellId
                return grid[i][j]

Meteor.methods
    move: (x, y) ->
        console.log "Player Move To ", x, y

    ping: ->
        console.log "Player Ping"

    fire: ->
        console.log "Player Fire"
