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


Backbone.Marionette.Renderer.render = (template, data) ->
  console.log "Backbone.Marionette.Renderer.render", template, data
  tmpl = Meteor.ui.chunk ->
    Template[template] data
  return tmpl


Meteor.startup ->
  console.log "client startup"
  callback = () ->
    console.log Category.find().count(), id
    if Category.find().count()
      Meteor.clearInterval id
      BBCloneMail.start()
  id = Meteor.setInterval callback, 3000
  console.log "id: ", id
