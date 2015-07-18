class GameState
    create: ->
        window.gameData = {}
        this.game.physics.startSystem Phaser.Physics.ARCADE

        window.gameData.player1 = Phaser.Sprite.call(this, game, 50, 50, "submarine")
        gameData.player1.anchor.setTo 0.5, 0.5

    update: ->

    render: ->
