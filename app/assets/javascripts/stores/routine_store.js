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
    },

    inputChanged: function(data) {
        if (data.type == C.WEIGHTS) {
            var performedExercise = _.find(this.routine.performed_exercises, function(ex){ return ex.exercise.id == data.exId;});
            var perf_reps = isNaN(parseFloat(data.reps)) ? 0 : parseFloat(data.reps);
            var perf_weight = isNaN(parseFloat(data.weight)) ? 0 : parseFloat(data.weight);
            performedExercise.weight_sets[data.setNum - 1].perf_reps = perf_reps;
            performedExercise.weight_sets[data.setNum - 1].perf_weight = perf_weight;
        } else if (data.type == C.PLYOS) {
            var performedExercise = _.find(this.routine.performed_plyometrics, function(ex){ return ex.id == data.exId;});
            if (data.setNum == 1) {
                performedExercise.performed_one = data.reps;
            } else if (data.setNum == 2) {
                performedExercise.performed_two = data.reps;
            } else {
                performedExercise.performed_three = data.reps;
            }
        } else if (data.type == C.SPRINTS) {
            var performedExercise = _.find(this.routine.performed_sprints, function(ex){ return ex.id == data.exId;});
            performedExercise.laps[data.setNum - 1].completed = data.reps;
        } else if (data.type == C.WARMUP) {
            var performedExercise = _.find(this.routine.performed_warm_ups, function(ex){ return ex.id == data.exId;});
            performedExercise.completed = data.reps;
        }
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

dispatcher.register(C.INPUT_CHANGED, function(data) {
    RoutineStore.inputChanged(data);
    RoutineStore.change();
});

export default RoutineStore;