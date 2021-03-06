var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/fitness_assessment_constants.js');

var FitnessAssessmentStore = new Store({
    quads: {}, //array of key/values for each quad
    goal: C.MASS,
    userWeight: undefined,
    benchWeight: undefined,
    benchReps: undefined,
    pushups: undefined,
    pullups: undefined,
    assistedPushups: undefined,
    squatWeight: undefined,
    squatReps: undefined,
    complete: false,
    module: undefined,
    experienceLevel: 1,

    setQuads: function(quads){
        for (var key in quads) {
            this.quads[key] = quads[key];
        }
    },

    setGoal: function(goal) {
        this.goal = goal;
    },

    setModule: function(goal) {
        this.module = "PowerRip";
        if (goal == C.LEAN) {
            this.module = "PowerLean";
        } else if (goal == C.MASS) {
            this.module = 'PowerMass';
        }
    },

    setExperienceLevel: function(level) {
        this.experienceLevel = level;
    },

    setUserWeight: function(weight) {
        this.userWeight = weight;
    },

    setBench: function(data) {
        this.benchWeight = data.weight;
        this.benchReps = data.reps;
    },

    setSquat: function(data) {
        this.squatWeight = data.weight;
        this.squatReps = data.reps;
        this.complete = true;
    },

    setPushUps: function(count) {
        this.pushups = count;
    },

    setPullUps: function(count) {
        this.pullups = count;
    },

    setAssistedPushups: function(count) {
        this.assistedPushups = count;
    },

    reset: function() {
        this.complete = false;
    },

    getData: function(){
        return {
            quads: this.quads,
            goal: this.goal,
            userWeight: this.userWeight,
            benchWeight: this.benchWeight,
            benchReps: this.benchReps,
            pushups: this.pushups,
            pullups: this.pullups,
            assistedPushups: this.assistedPushups,
            squatWeight: this.squatWeight,
            squatReps: this.squatReps,
            complete: this.complete,
            module: this.module,
            experienceLevel: this.experienceLevel
        };
    }
});

dispatcher.register(C.QUADS, function(data) {
    if(data){
        FitnessAssessmentStore.setQuads(data);
        FitnessAssessmentStore.change();
    }
});

dispatcher.register(C.GOAL, function(data) {
    if(data){
        FitnessAssessmentStore.setGoal(data);
        FitnessAssessmentStore.setModule(data);
        FitnessAssessmentStore.change();
    }
});

dispatcher.register(C.USER_WEIGHT, function(data) {
    if(data){
        FitnessAssessmentStore.setUserWeight(data);
        FitnessAssessmentStore.change();
    }
});

dispatcher.register(C.BENCH, function(data) {
    if(data){
        FitnessAssessmentStore.setBench(data);
        FitnessAssessmentStore.change();
    }
});

dispatcher.register(C.SQUAT, function(data) {
    if(data){
        FitnessAssessmentStore.setSquat(data);
        FitnessAssessmentStore.change();
    }
});

dispatcher.register(C.PUSHUPS, function(data) {
    if(data){
        FitnessAssessmentStore.setPushUps(data);
        FitnessAssessmentStore.change();
    }
});

dispatcher.register(C.PULLUPS, function(data) {
    if(data){
        FitnessAssessmentStore.setPullUps(data);
        FitnessAssessmentStore.change();
    }
});

dispatcher.register(C.ASSISTED_PUSHUPS, function(data) {
    if(data){
        FitnessAssessmentStore.setAssistedPushups(data);
        FitnessAssessmentStore.change();
    }
});

dispatcher.register(C.RESET, function() {
    FitnessAssessmentStore.reset();
    FitnessAssessmentStore.change();
});

dispatcher.register(C.EX_LEVEL, function(level) {
    FitnessAssessmentStore.setExperienceLevel(level);
    FitnessAssessmentStore.change();
});

export default FitnessAssessmentStore;