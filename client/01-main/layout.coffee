BBCloneMail.module "Layout", (Layout, BBCloneMail, Backbone, Marionette, $, _) ->

  # The application layout
  Layout = Backbone.Marionette.Layout.extend(
    template: "layout"

    # These are my visual regions: the "navigation" or
    # left hand list of categories, and the "main"
    # content area where the email list or contact list
    # is displayed.
    regions:
      navigation: "#navigation"
      main: "#main"


    # Handle the switching of the app between mail and contacts
    events:
      "change #app-selector select": "appChanged"

    initialize: ->

      # Make sure the `setSelection` method is always running in
      # the context of this view.
      _.bindAll this, "setSelection"

      # Bind the events to show the correct app selection.
      @setupAppSelectionEvents()


    # Figure out which app is being selected and call the
    # correct object's `show` method.
    appChanged: (e) ->
      e.preventDefault()
      appName = $(e.currentTarget).val()
      if appName is "mail"
        BBCloneMail.MailApp.showInbox()
      else
        BBCloneMail.ContactsApp.showContactList()


    # Show the correct app in the select box.
    setSelection: (app) ->
      @$("select").val app

    setupAppSelectionEvents: ->
      that = this

      # When the mail app is shown, be sure we are displaying "Mail"
      # in the app selector.
      BBCloneMail.vent.bind "mail:show", ->
        that.setSelection "mail"


      # When the contacts app is shown, be sure we are displaying
      # "Contacts" in the app selector.
      BBCloneMail.vent.bind "contacts:show", ->
        that.setSelection "contacts"

  )

  # Initialize the application layout and when the layout has
  # been rendered and displayed, then start the rest of the
  # application
  BBCloneMail.addInitializer ->

    # Render the layout and get it on the screen, first
    BBCloneMail.layout = new Layout()
    BBCloneMail.layout.on "show", ->
      BBCloneMail.vent.trigger "layout:rendered"

    BBCloneMail.content.show BBCloneMail.layout

  Layout

