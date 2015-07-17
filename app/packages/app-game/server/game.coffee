# Return a reference to a cell by its ID.
getCellById = (cellId, grid) ->
    for i in [0...grid.length] by 1
        for j in [0...grid[i].length] by 1
            if grid[i][j].id is cellId
                return grid[i][j]

Meteor.methods
    updateGrid: (cellId, game) =>
        return if game.currentPlayer isnt Meteor.user().username
        return if game.player2 is null
        return if game.status.playing is false
        cell = getCellById cellId, game.grid
        return if cell.value != ""

        currentPlayer = game.currentPlayer
        cellCount = game.cellCount

        # Set the cell value and owner.
        if (game.currentPlayer == game.player1)
            cell.value = "X"
            cell.owner = game.player1
        else
            cell.value = "O"
            cell.owner = game.player2

        # Now that the grid has been updated,
        # see if there is a winner.

        won = @.checkWon cell, game.grid

        # If game is a tie.
        if !won and cellCount - 1 is 0
            Games.update game._id,
                $set:
                    grid: game.grid
                    status:
                        tie: true
                        playing: false
                        won: false

        # If game continues.
        else if !won and cellCount - 1 > 0
            # Update current player.
            if (game.currentPlayer == game.player1)
                currentPlayer = game.player2
            else
                currentPlayer = game.player1

            # Update board.
            Games.update game._id,
                $set:
                    grid: game.grid
                    currentPlayer: currentPlayer
                    cellCount: cellCount - 1

        # If game has been won.
        else
            Games.update game._id,
                $set:
                    grid: game.grid
                    status:
                        tie: false
                        playing: false
                        won: true