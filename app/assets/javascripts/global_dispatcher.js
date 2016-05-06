var util = require('helpers/util.js');

var Dispatcher = function(){
    this.callbacks = {};
};

Dispatcher.prototype = {
    __add: function(name, fn){
        if (hasOwn.call(this.callbacks, name))
            this.callbacks[name].push(fn);
        else
            this.callbacks[name] = [fn];
    },
    __invoke: function(name, payload, clone){
        // default to cloningt the payload
        if (clone === undefined){
            clone = true;
        }

        if (!hasOwn.call(this.callbacks, name)){
            if (this.logging) {console.warn('DISPATCHER: "' + name + '" dispatched but there are no registered callbacks.');}
            return;
        }

        var group = this.callbacks[name];
        // clone object payload incase its mutated by a store
        if(payload && clone){
            payload = JSON.parse( JSON.stringify( payload ));
        }

        for (var i = 0; i < group.length; i++){
            // clone object payload incase its mutated by a store
            group[i].apply(this, [payload]);
        }
    },
    register: function(actionType, fn){
        if (util.empty(actionType))
            throw Error('Invalid action type.');

        this.__add(actionType, fn);
        return this;
    },
    dispatch: function(action /*, payload, clone */){
        var actionType, payload, clone = arguments[2];

        if (util.isString(action)){
            actionType = action;
            payload = arguments[1];
        }
        else if(action && hasOwn.call(action, 'actionType') && !util.empty(action.actionType)) {
            actionType = action.actionType;
            if(hasOwn.call(action, 'payload'))
                payload = action.payload;
        }
        else{
            if (this.logging){
                console.warn('DISPATCHER: "' + JSON.stringify(action) + '" is invalid to dispatch. Did you specify an `actionType`?.');
            }
            return;
        }

        this.__invoke(actionType, payload, clone);
        return this;
    }
};


var hasOwn = Object.prototype.hasOwnProperty;

module.exports = new Dispatcher();