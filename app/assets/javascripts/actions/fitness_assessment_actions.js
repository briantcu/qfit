var dispatcher = require('global_dispatcher.js');
var C = require('constants/fitness_assessment_constants.js');

var FitnessAssessmentActions = {

    setQuads: function(quads) {
        dispatcher.dispatch(C.QUADS, quads);

    },

    setGoal: function(goal) {
        dispatcher.dispatch(C.GOAL, goal);
    }
};

export default FitnessAssessmentActions;