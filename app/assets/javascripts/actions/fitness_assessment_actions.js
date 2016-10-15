var dispatcher = require('global_dispatcher.js');
var C = require('constants/fitness_assessment_constants.js');
var UC = require('constants/user_constants.js');

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
    },

    setExperienceLevel: function(level) {
        dispatcher.dispatch(C.EX_LEVEL, level);
    },

    submit: function(data, callback) {
        var local_data = {};
        local_data.fitness_assessment_submission = {};
        local_data.fitness_assessment_submission.user_id = data.user.id;
        local_data.fitness_assessment_submission.weight = data.userWeight;
        local_data.fitness_assessment_submission.bench_reps = data.userWeight;
        local_data.fitness_assessment_submission.bench_weight = data.userWeight;
        local_data.fitness_assessment_submission.squat_weight = data.squatWeight;
        local_data.fitness_assessment_submission.squat_reps = data.squatReps;
        local_data.fitness_assessment_submission.push_ups = data.pushups;
        local_data.fitness_assessment_submission.pull_ups = data.pullups;
        local_data.fitness_assessment_submission.assisted_push_ups = data.assistedPushups;
        local_data.fitness_assessment_submission.experience_level = data.experienceLevel;
        local_data.fitness_assessment_submission.sex = data.user.sex;
        var payload = JSON.stringify(local_data);

        $.ajax({
            type: 'post',
            url: '/users/'+data.user.id+'/fitness.json',
            dataType: 'json',
            data: payload,
            contentType: "application/json; charset=utf-8",
            success: function(user) {
                if (user.is_sub_user) {
                    location.href = '/workout';
                } else {
                    dispatcher.dispatch(C.RESET);
                    dispatcher.dispatch(UC.LOADED, user);
                    callback();
                }
            },
            error: function(results) {
                alert('Something went wrong!');
            }
        });
    }
};

export default FitnessAssessmentActions;