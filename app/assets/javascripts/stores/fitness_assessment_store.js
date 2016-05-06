var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/tote_constants.js');

//var ToteStore = new Store({
//    tote: {},
//    setTote: function(tote){
//        this.tote = tote;
//    },
//    getData: function(){
//        return {
//            tote: this.tote
//        };
//    }
//});
//
//dispatcher.register(C.ACTIVE_TOTE, function(data) {
//    if(data){
//        ToteStore.setTote(data);
//        ToteStore.change();
//    }
//});
//
//module.exports = ToteStore;