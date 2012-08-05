# Backbone.BBCloneMail
# A reference application for Backbone.Marionette
#
# Copyright (C)2012 Derick Bailey, Muted Solutions, LLC
# Distributed Under MIT License
#
# Documentation and Full License Available at:
# http://github.com/derickbailey/backbone.bbclonemail
# http://github.com/derickbailey/backbone.marionette

# Contacts
# --------

# Manage the list of contacts and the categories for
# the contacts. Limited functionality at this point,
# but slowly adding more.
BBCloneMail.module "ContactsApp", (Contacts, BBCloneMail, Backbone, Marionette, $, _) ->

  # Contact Model And Collection
  # -----------------------------
  Contacts.Contact = Backbone.Model.extend
    meteorStorage: new Backbone.MeteorStorage(Contact)
  Contacts.ContactCollection = Backbone.Collection.extend
    meteorStorage: new Backbone.MeteorStorage(Contact)
    model: Contacts.Contact

  # Public API
  # ----------

  # Show the contact list and the categories.
  Contacts.showContactList = ->
    BBCloneMail.ContactsApp.ContactList.show Contacts.contacts
    BBCloneMail.ContactsApp.Categories.show()
    BBCloneMail.vent.trigger "contacts:show"


  # Initializer
  # -----------
  BBCloneMail.addInitializer ->
    Contacts.contacts = new Contacts.ContactCollection()
    Contacts.contacts.fetch()


