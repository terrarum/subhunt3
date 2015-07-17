#Meteor.log.info "routes"

@.Games = new Mongo.Collection "games"

# Default routing options.
Router.configure
    layoutTemplate: 'mainLayout'
    yieldTemplates:
        header:
            to: 'header'
        footer:
            to: 'footer'

# Homepage.
Router.route '/',
    template: 'index'
    data: ->
        Session.set 'currentGame', null

# About page.
Router.route '/about'

# A game.
Router.route '/game',
    path: '/game/:_id'
    data: ->

        if (Meteor.isClient)
            new Phaser.Game(800, 600, Phaser.AUTO, 'game')

        # Set current game ID on session.
        Session.set 'currentGame', @.params._id
        return Games.findOne
            _id: @.params._id