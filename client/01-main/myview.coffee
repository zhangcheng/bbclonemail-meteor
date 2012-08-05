MyItemView = Backbone.Marionette.View.extend
  constructor: ->
    console.log "MyItemView.constructor"
    Backbone.Marionette.View.prototype.constructor.apply(this, arguments)
    @initialEvents()
    return


  initialEvents: ->
    console.log "MyItemView.initialEvents"
    return


  render: ->
    console.log "MyItemView.render: ", @
#    @beforeRender() if @beforeRender
#    @trigger "before:render", @
#    @trigger "item:before:render", @

    tmplName = @getTemplate()
    context = {model: @model, collection: @collection}
    console.log "context: ", context
    tmpl = Meteor.ui.chunk ->
      Template[tmplName] context
    @.$el.html(tmpl)

#    @onRender()  if @onRender
#    @trigger "render", @
#    @trigger "item:rendered", @
    @
