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
  BBCloneMail.start()
