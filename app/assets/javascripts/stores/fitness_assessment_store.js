var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/fitness_assessment_constants.js');

var FitnessAssessmentStore = new Store({
    quads: {}, //array of key/values for each quad
    goal: C.MASS,
    setQuads: function(quads){
        this.quads = quads;
    },

    setGoal: function(goal) {
        this.goal = goal;
    },

    getData: function(){
        return {
            quads: this.quads,
            goal: this.goal
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
        FitnessAssessmentStore.change();
    }
});

export default FitnessAssessmentStore;