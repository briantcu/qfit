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

    submit: function(fitness, user, callback) {
        var local_data = {};
        local_data.fitness_assessment_submission = {};
        local_data.fitness_assessment_submission.user_id = user.id;
        local_data.fitness_assessment_submission.weight = fitness.userWeight;
        local_data.fitness_assessment_submission.bench_reps = fitness.benchReps;
        local_data.fitness_assessment_submission.bench_weight = fitness.benchWeight;
        local_data.fitness_assessment_submission.squat_weight = fitness.squatWeight;
        local_data.fitness_assessment_submission.squat_reps = fitness.squatReps;
        local_data.fitness_assessment_submission.push_ups = fitness.pushups;
        local_data.fitness_assessment_submission.pull_ups = fitness.pullups;
        local_data.fitness_assessment_submission.assisted_push_ups = fitness.assistedPushups;
        local_data.fitness_assessment_submission.experience_level = fitness.experienceLevel;
        local_data.fitness_assessment_submission.sex = user.sex;
        var payload = JSON.stringify(local_data);

        $.ajax({
            type: 'post',
            url: '/users/'+user.id+'/fitness.json',
            dataType: 'json',
            data: payload,
            contentType: "application/json; charset=utf-8",
            success: function(user, status, xhr) {
                if (user.is_sub_user) {
                    location.href = xhr.getResponseHeader('Location');
                    location.href = '/workout';
                } else {
                    dispatcher.dispatch(C.RESET);
                    dispatcher.dispatch(UC.LOADED, user);
                    callback();
                }
            },
            error: function(results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    }
};

export default FitnessAssessmentActions;