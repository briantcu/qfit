var assign = require('object-assign');
var EventEmitter = require('events').EventEmitter;

var Store = function(extend){
    if (extend) {assign(this, extend);}
};

assign(Store.prototype, EventEmitter.prototype, {
    change: function() {
        this.emit('change');
    },
    addChangeListener: function(callback) {
        this.on('change', callback);
    },
    removeChangeListener: function(callback) {
        this.removeListener('change', callback);
    }
});

module.exports = Store;