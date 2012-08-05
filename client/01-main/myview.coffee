MyItemView = (tmpl) ->
  self = @
  Backbone.View.extend
    initialize: ->
      _.bindAll(self, 'render')
      return
    template: ->
      Meteor.ui.render ->
        return tmpl
    render: ->
      $(el).empty().append(self.template())
      return
