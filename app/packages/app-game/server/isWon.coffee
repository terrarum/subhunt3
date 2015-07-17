WIN_LENGTH = 3
NW = 0
N  = 1
NE = 2
E  = 3
SE = 4
S  = 5
SW = 6
W  = 7

chainLength = 0
baseDirs = [
    NW,
    N,
    NE,
    E
]
baseCell = null

# Check whether or not the game has been won.
@.checkWon = (cell, grid) ->
    baseCell = cell
    chainLength = 0

    for dir in baseDirs
        break if isWon()
        # Set chain to 1 because a token has been placed.
        chainLength = 1
        checkDirection baseCell, grid, dir

        if !isWon()
            # Check the opposite direction.
            checkDirection baseCell, grid, getOppositeDirection(dir)

    return isWon()

# Has the game been won yet?
isWon = ->
    return chainLength is WIN_LENGTH

# Check cells in given direction.
checkDirection = (cell, grid, dir) ->
    # Get a cell in a direction.
    nextCell = getCellInDir(grid, cell, dir)
    # If the new cell is valid and has the same value as the baseCell.
    if isCellValid(nextCell, baseCell.value)

        # Increase chain length.
        chainLength++

        if !isWon()
            # Check the next cell.
            checkDirection nextCell, grid, dir

# Returns the opposite direction to the one given.
getOppositeDirection = (dir) ->
    oppositeDir = null
    switch dir
        when N
            oppositeDir = S
        when NE
            oppositeDir = SW
        when E
            oppositeDir = W
        when SE
            oppositeDir = NW
        when S
            oppositeDir = N
        when SW
            oppositeDir = NE
        when W
            oppositeDir = E
        when NW
            oppositeDir = SE
        else
            console.log 'You did not supply a valid direction, so you will get null.'
    return oppositeDir

# Gets the next cell in the given direction.
getCellInDir = (grid, cell, dir) ->
    newCell = null
    switch dir
        when NW
            newCell = getCellByPos(grid, cell.x - 1, cell.y - 1)
        when N
            newCell = getCellByPos(grid, cell.x, cell.y - 1)
        when NE
            newCell = getCellByPos(grid, cell.x + 1, cell.y - 1)
        when E
            newCell = getCellByPos(grid, cell.x + 1, cell.y)
        when SE
            newCell = getCellByPos(grid, cell.x + 1, cell.y + 1)
        when S
            newCell = getCellByPos(grid, cell.x, cell.y + 1)
        when SW
            newCell = getCellByPos(grid, cell.x - 1, cell.y + 1)
        when W
            newCell = getCellByPos(grid, cell.x - 1, cell.y)
        else
            newCell = null
    return newCell

# Get a cell in the grid by its position.
getCellByPos = (grid, x, y) ->
    if grid[y] != undefined
        grid[y][x]
    else
        undefined

# Is the cell valid?
isCellValid = (cell, value) ->
    if cell == undefined
        false
    else if cell.value != value
        false
    else
        true