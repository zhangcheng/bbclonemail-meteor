BBCloneMail = new Backbone.Marionette.Application()


BBCloneMail.addRegions
  content: ".content"


BBCloneMail.vent.on "layout:rendered", ->
  console.log "layout:rendered"
  Backbone.history.start()


Backbone.Marionette.TemplateCache.prototype.loadTemplate = (tmplName) ->
  console.log "loadTemplate: ", tmplName
  tmpl = Meteor.ui.chunk ->
    Template[tmplName]()


Meteor.startup ->
  console.log "client startup"
  callback = ->
    console.log Category.find().count()
    BBCloneMail.start() if Category.find().count()
    Meteor.clearInterval id
  id = Meteor.setInterval callback, 3000
