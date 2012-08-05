# Backbone.BBCloneMail
# A reference application for Backbone.Marionette
#
# Copyright (C)2012 Derick Bailey, Muted Solutions, LLC
# Distributed Under MIT License
#
# Documentation and Full License Available at:
# http://github.com/derickbailey/backbone.bbclonemail
# http://github.com/derickbailey/backbone.marionette

# MailApp
# -------

# This is the app controller or sub-application
# for email. It contains all of the
# high level knowledge of how to run the app
# when it's in mail mode.
BBCloneMail.module "MailApp", (MailApp, BBCloneMail, Backbone, Marionette, $, _) ->

  # Mail App Public API
  # -------------------

  # Show the inbox with all email.
  MailApp.showInbox = ->
    MailApp.showCategory()
    BBCloneMail.vent.trigger "mail:show"


  # Show a list of email for the given category.
  MailApp.showCategory = (category) ->
    showFilteredEmailList category
    MailApp.Categories.showCategoryList()


  # Show an individual email message, by Id
  MailApp.showMessage = (messageId) ->
    MailApp.emailList.onReset (list) ->
      email = list.get(messageId)
      MailApp.MailBox.showMessage email

    MailApp.Categories.showCategoryList()


  # Mail App Event Handlers
  # -----------------------

  # When a category is selected, filter the mail list
  # based on it.
  BBCloneMail.vent.bind "mail:category:show", (category) ->
    showFilteredEmailList category


  # When the mail app is shown or `inbox` is clicked,
  # show all the mail.
  BBCloneMail.vent.bind "mail:show", ->
    showFilteredEmailList()


  # Mail App Initializer
  # --------------------

  # Initializes the email collection object with the list
  # of emails that are passed in from the call to
  # `BBCloneMail.start`.
  BBCloneMail.addInitializer ->
    MailApp.emailList = Email.find().fetch()


