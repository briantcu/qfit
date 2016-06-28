var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/routine_constants.js');

var RoutineStore = new Store({

    calendar: undefined,
    routine: undefined,

    setCalendar: function(data) {
        this.calendar = data;
    },

    setRoutine: function(data) {
        this.routine = data;
    },

    getData: function(){
        return {
            calendar: this.calendar,
            routine: this.routine
        };
    }
});

dispatcher.register(C.CALENDAR, function(data) {
    RoutineStore.setCalendar(data);
    RoutineStore.change();
});

dispatcher.register(C.ROUTINE_LOADED, function(data) {
    RoutineStore.setRoutine(data);
    RoutineStore.change();
});

export default RoutineStore;