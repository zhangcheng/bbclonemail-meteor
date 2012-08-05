# Backbone.BBCloneMail
# A reference application for Backbone.Marionette
#
# Copyright (C)2012 Derick Bailey, Muted Solutions, LLC
# Distributed Under MIT License
#
# Documentation and Full License Available at:
# http://github.com/derickbailey/backbone.bbclonemail
# http://github.com/derickbailey/backbone.marionette
#
# BBCloneMail Models And Collections
# ----------------------------------

# Provide a guaranteed execution of a "reset" event for
# collections so I can find an item in the collection after
# the collection has been loaded.
BBCloneMail.Collection = Backbone.Collection.extend
  constructor: ->
    args = Array::slice.call(arguments)
    Backbone.Collection::constructor.apply @, args
    @onResetCallbacks = new Backbone.Marionette.Callbacks()
    @on "reset", @runOnResetCallbacks, @

  onReset: (callback) ->
    @onResetCallbacks.add callback

  runOnResetCallbacks: ->
    @onResetCallbacks.run @, @
