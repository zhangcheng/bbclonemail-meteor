# Backbone.BBCloneMail
# A reference application for Backbone.Marionette
#
# Copyright (C)2012 Derick Bailey, Muted Solutions, LLC
# Distributed Under MIT License
#
# Documentation and Full License Available at:
# http://github.com/derickbailey/backbone.bbclonemail
# http://github.com/derickbailey/backbone.marionette

# Routing
# -------
BBCloneMail.module "Routing", (Routing, BBCloneMail, Backbone, Marionette, $, _) ->

  # Public API
  # ----------

  # The `showRoute` method is a private method used to update the
  # url's hash fragment route. It accepts a base route and an
  # unlimited number of optional parameters for the route:
  # `showRoute("foo", "bar", "baz", "etc");`.
  Routing.showRoute = ->
    route = getRoutePath(arguments)
    Backbone.history.navigate route, false


  # Helper Methods
  # --------------

  # Creates a proper route based on the `routeParts`
  # that are passed to it.
  getRoutePath = (routeParts) ->
    base = routeParts[0]
    length = routeParts.length
    route = base
    if length > 1
      i = 1

      while i < length
        arg = routeParts[i]
        route = route + "/" + arg  if arg
        i++
    route

