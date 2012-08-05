BBCloneMail = new Backbone.Marionette.Application()


BBCloneMail.addRegions
  content: ".content"


BBCloneMail.vent.on "layout:rendered", ->
  Backbone.history.start()


Backbone.Marionette.Renderer.render = (template, data) ->
  Meteor.ui.render ->
    Template[template] data


Meteor.startup ->
  console.debug "client startup"
  callback = () ->
    if Category.find().count()
      Meteor.clearInterval id
      BBCloneMail.start()
  id = Meteor.setInterval callback, 3000
