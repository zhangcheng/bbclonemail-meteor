Meteor.startup ->
  _.each ["category", "contact", "email"], (collection) ->
    _.each ["insert", "update", "remove"], (method) ->
      Meteor.default_server.method_handlers["/" + collection + "/" + method] = ->
