class Load
    preload: ->
        console.log "Load prffffeload"

#        buttonBmd = this.game.add.bitmapData 50, 10
#        buttonBmd.ctx.fillStyle = '#ffffff'
#        buttonBmd.ctx.fillRect 0, 0, 50, 10
#        this.load.image "submarine", buttonBmd.canvas.toDataURL(), 50, 10

        this.load.image "submarine", "/assets/sub.png"

        this.game.stage.backgroundColor = "#3ba2b9"

    create: ->
        window.gameData = {}
        this.game.physics.startSystem Phaser.Physics.ARCADE

        currentPos = Session.get "currentPlayerPos"

        window.gameData.player = this.game.add.sprite currentPos.x, currentPos.y, "submarine"
        gameData.player.anchor.setTo 0.5, 0.5
        gameData.player.angle = currentPos.angle

$ ->
    $(document).on "renderPhaser", ->
        # Create Phaser object.
        if window.phaserGame is undefined
            window.phaserGame = new Phaser.Game(800, 600, Phaser.AUTO, 'game')

        phaserGame.state.add "Load", Load
        phaserGame.state.start "Load"
