MyItemView = Backbone.Marionette.View.extend
  constructor: ->
    console.log "MyItemView.constructor"
    Backbone.Marionette.View.prototype.constructor.apply(this, arguments)
    return


  render: ->
    console.log "MyItemView.render"
    tmplName = @getTemplate()
    context = {collection: @collection}
    tmpl = Meteor.ui.chunk ->
      Template[tmplName] context
    @.$el.html(tmpl)
    return this
