Meteor.startup ->
  console.log "bootstrapping..."

  iterator = (element, index, list) ->
    @insert element

  unless Category.find({}, limit: 1).count()
    _.each SEED.categories, iterator, Category

  unless Contact.find({}, limit: 1).count()
    _.each SEED.contacts, iterator, Contact

  unless Email.find({}, limit: 1).count()
    _.each SEED.emails, iterator, Email

