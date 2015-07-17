# Tic Tac Toe

app-core is the main package.

Multiplayer Tic Tac Toe powered by Meteor.

Start meteor with local mongo:

```MONGO_URL="mongodb://localhost:27017/tictactoe" meteor```

# Things I Am Doing Wrong

- Using game IDs in the URL - should create a friendly URL of some kind.
- Game creator always goes first - should randomise.
- Cells need to know their X and Y position. Instead of this, there should be a 'get pos of cell with given id' function that returns an x/y object for reference to complement the 'get cell by pos' function.
- Really need tests for all of the grid functions.
- Using player names rather than player IDs to identify players in a game.
- Games should reference player objects rather than null or a string

# Things I Could Do Better

- Store directions in pairs to get rid of that nasty getOppositeDirection switch?
- Some things are reacting to the results of a DB change (e.g. returning player to lobby if game is deleted) immediately, without time to present a message to the player.
- Game status needs to be stored as a boolean but this creates a nasty state object. Need helper methods for setting and getting the game state.

# Features to Add

- Games could be spectated