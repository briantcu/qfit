var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/routine_constants.js');

var RoutineStore = new Store({

    calendar: undefined,
    routine: undefined,
    loading: true,

    setCalendar: function(data) {
        this.calendar = data;
    },

    setRoutine: function(data) {
        this.routine = data;
        this.loading = false;
    },

    setLoading: function(data) {
        this.loading = data;
    },

    getData: function(){
        return {
            calendar: this.calendar,
            routine: this.routine,
            loading: this.loading
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

dispatcher.register(C.LOADING, function(data) {
    RoutineStore.setLoading(data);
    RoutineStore.change();
});

export default RoutineStore;