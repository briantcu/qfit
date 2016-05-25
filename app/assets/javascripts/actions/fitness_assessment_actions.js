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
        console.log(weight);
    },

    setBench: function(weight, reps) {

    },

    setSquat: function(weight, reps) {

    },

    setPushUps: function(count) {

    },

    setPullUps: function(count) {

    },

    setAssistedPushUps: function(count) {

    }
};

export default FitnessAssessmentActions;