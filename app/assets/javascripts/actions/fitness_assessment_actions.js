var dispatcher = require('global_dispatcher.js');
var C = require('constants/fitness_assessment_constants.js');

var FitnessAssessmentActions = {

    setQuads: function(quads) {
        dispatcher.dispatch(C.QUADS, quads);

    },

    setGoal: function(goal) {
        dispatcher.dispatch(C.GOAL, goal);
    },

    setUserWeight: function(weight) {
        dispatcher.dispatch(C.USER_WEIGHT, weight);
    },

    setBench: function(weight, reps) {
        dispatcher.dispatch(C.BENCH, {weight: weight, reps: reps});
    },

    setSquat: function(weight, reps) {
        dispatcher.dispatch(C.SQUAT, {weight: weight, reps: reps});
    },

    setPushUps: function(count) {
        dispatcher.dispatch(C.PUSHUPS, count);
    },

    setPullUps: function(count) {
        dispatcher.dispatch(C.PULLUPS, count);
    },

    setAssistedPushUps: function(count) {
        dispatcher.dispatch(C.ASSISTED_PUSHUPS, count);
    }
};

export default FitnessAssessmentActions;