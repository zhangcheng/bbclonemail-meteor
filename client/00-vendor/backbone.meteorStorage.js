/**
 * Backbone localStorage Adapter
 * https://github.com/jeromegn/Backbone.localStorage
 */

(function() {
// A simple module to replace `Backbone.sync` with *localStorage*-based
// persistence. Models are given GUIDS, and saved into a JSON object. Simple
// as that.

// Hold reference to Underscore.js and Backbone.js in the closure in order
// to make things work even if they are removed from the global namespace
var _ = this._;
var Backbone = this.Backbone;

// Generate four random hex digits.
function S4() {
   return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
};

// Generate a pseudo-GUID by concatenating random hexadecimal.
function guid() {
   return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
};

// Our Store is represented by a single JS object in *localStorage*. Create it
// with a meaningful name, like the name you'd give a table.
// window.Store is deprectated, use Backbone.LocalStorage instead
Backbone.MeteorStorage = function(collection) {
  this.collection = collection;
  this.records = collection.find().fetch();
};

_.extend(Backbone.MeteorStorage.prototype, {

  // Save the current state of the **Store** to *localStorage*.
  save: function() {
    console.log("Backbone.MeteorStorage.save");
//    this.localStorage().setItem(this.name, this.records.join(","));
  },

  // Add a model, giving it a (hopefully)-unique GUID, if it doesn't already
  // have an id of it's own.
  create: function(model) {
    console.log("Backbone.MeteorStorage.create", model);
    return model.toJSON();
  },

  // Update a model by replacing its copy in `this.data`.
  update: function(model) {
    console.log("Backbone.MeteorStorage.update", model);
    return model.toJSON();
  },

  // Retrieve a model from `this.data` by id.
  find: function(model) {
    console.log("Backbone.MeteorStorage.find", model);
    return {}
//    return JSON.parse(this.localStorage().getItem(this.name+"-"+model.id));
  },

  // Return the array of all models currently in storage.
  findAll: function() {
    return this.collection.find().fetch()
  },

  // Delete a model from `this.data`, returning it.
  destroy: function(model) {
    console.log("Backbone.MeteorStorage.destroy", model);
    // this.meteorStorage().removeItem(this.name+"-"+model.id);
    // this.records = _.reject(this.records, function(record_id){return record_id == model.id.toString();});
    // this.save();
    return model;
  },

  meteorStorage: function() {
      return meteorStorage;
  }

});

// localSync delegate to the model or collection's
// *localStorage* property, which should be an instance of `Store`.
// window.Store.sync and Backbone.localSync is deprectated, use Backbone.LocalStorage.sync instead
Backbone.MeteorStorage.sync = function(method, model, options, error) {
  var store = model.meteorStorage || model.collection.meteorStorage;

  // Backwards compatibility with Backbone <= 0.3.3
  if (typeof options == 'function') {
    options = {
      success: options,
      error: error
    };
  }

  var resp;

  switch (method) {
    case "read":    resp = model.id != undefined ? store.find(model) : store.findAll(); break;
    case "create":  resp = store.create(model);                            break;
    case "update":  resp = store.update(model);                            break;
    case "delete":  resp = store.destroy(model);                           break;
  }

  if (resp) {
    options.success(resp);
  } else {
    options.error("Record not found");
  }
};

Backbone.ajaxSync = Backbone.sync;

Backbone.getSyncMethod = function(model) {
	if(model.meteorStorage || (model.collection && model.collection.meteorStorage))
	{
		return Backbone.MeteorStorage.sync;
	}

	return Backbone.ajaxSync;
};

// Override 'Backbone.sync' to default to localSync,
// the original 'Backbone.sync' is still available in 'Backbone.ajaxSync'
Backbone.sync = function(method, model, options, error) {
	return Backbone.getSyncMethod(model).apply(this, [method, model, options, error]);
};

})();
