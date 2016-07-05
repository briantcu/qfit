var dispatcher = require('global_dispatcher.js');
var C = require('constants/exercise_constants.js');

var ExerciseActions = {

    getExercises: function() {
        $.ajax({
            type: 'get',
            url: '/warmups.json',
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.WARMUPS_LOADED, data)
            }
        });
        $.ajax({
            type: 'get',
            url: '/plyometrics.json',
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.PLYOS_LOADED, data)
            }
        });
        $.ajax({
            type: 'get',
            url: '/exercise_types.json',
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.STRENGTH_LOADED, data)
            }
        });
        $.ajax({
            type: 'get',
            url: '/sprints.json',
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.SPRINTS_LOADED, data)
            }
        });
    }
};

export default ExerciseActions;