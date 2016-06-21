var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/program_constants.js');

var RoutineStore = new Store({

    getData: function(){
        return {

        };
    }
});

//dispatcher.register(C.SUGGESTED_LOADED, function(data) {
//    RoutineStore.setSuggestedSchedule(data);
//    RoutineStore.change();
//});

export default RoutineStore;