MyCollectionView = Backbone.Marionette.View.extend
  constructor: ->
    console.log "MyCollectionView.constructor"
    Backbone.Marionette.View.prototype.constructor.apply(this, arguments)
    @initialEvents()
    return


  initialEvents: ->
    console.log "MyCollectionView.initialEvents"
    return


  render: ->
    console.log "MyCollectionView.render: ", @
    return @

    if @collection and @collection.length > 0
      @showCollection()
    else
      @showEmptyView()

    @


  # Internal method to loop through each item in the
  # collection view and show it
  showCollection: ->
    self = this
    ItemView = @getItemView()
    _.each @collection, (item, index) ->
      self.addItemView item, ItemView, index


  # Retrieve the itemView type, either from `this.options.itemView`
  # or from the `itemView` in the object definition. The "options"
  # takes precedence.
  getItemView: ->
    itemView = @options.itemView or @itemView
    unless itemView
      err = new Error("An `itemView` must be specified")
      err.name = "NoItemViewError"
      throw err
    itemView


  # Render the child item's view and add it to the
  # HTML for the collection view.
  addItemView: (item, ItemView, index) ->
    that = this
    view = @buildItemView(item, ItemView)

    # Store the child view itself so we can properly
    # remove and/or close it later
    @storeChild view
    @onItemAdded view  if @onItemAdded
    @trigger "item:added", view

    # Render it and show it
    renderResult = @renderItemView(view, index)

    # call onShow for child item views
    @onShowCallbacks.add view.onShow, view  if view.onShow

    # Forward all child item view events through the parent,
    # prepending "itemview:" to the event name
    childBinding = @bindTo(view, "all", ->
      args = slice.call(arguments)
      args[0] = "itemview:" + args[0]
      args.splice 1, 0, view
      that.trigger.apply that, args
    )
