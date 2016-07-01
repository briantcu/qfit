var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/routine_constants.js');

var RoutineStore = new Store({

    calendar: undefined,
    next_calendar: undefined,
    prev_calendar: undefined,
    routine: undefined,
    loading: true,

    setCalendar: function(data) {
        if (data.key == C.CALENDAR) {
            this.calendar = data.data;
        } else if (data.key == C.PREV_CALENDAR) {
            this.prev_calendar = data.data;
        } else {
            this.next_calendar = data.data;
        }

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
            prev_calendar: this.prev_calendar,
            next_calendar: this.next_calendar,
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