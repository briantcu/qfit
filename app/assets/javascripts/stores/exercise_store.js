var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/exercise_constants.js');

var ExerciseStore = new Store({
    plyometrics: [],
    warmups: [],
    exercises: [],
    sprints: [],

    setPlyos: function(data){
        this.plyometrics = data;
    },

    setWarmups: function(data){
        this.warmups = data;
    },

    setExercises: function(data){
        this.exercises = data;
    },

    setSprints: function(data){
        this.sprints = data;
    },

    getData: function(){
        return {
            plyometrics: this.plyometrics,
            warmups: this.warmups,
            exercises: this.exercises,
            sprints: this.sprints
        };
    }
});

dispatcher.register(C.STRENGTH_LOADED, function(data) {
    if(data){
        ExerciseStore.setExercises(data);
        ExerciseStore.change();
    }
});

dispatcher.register(C.WARMUPS_LOADED, function(data) {
    if(data){
        ExerciseStore.setWarmups(data);
        ExerciseStore.change();
    }
});

dispatcher.register(C.PLYOS_LOADED, function(data) {
    if(data){
        ExerciseStore.setPlyos(data);
        ExerciseStore.change();
    }
});

dispatcher.register(C.SPRINTS_LOADED, function(data) {
    if(data){
        ExerciseStore.setSprints(data);
        ExerciseStore.change();
    }
});

export default ExerciseStore;