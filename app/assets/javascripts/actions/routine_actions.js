var dispatcher = require('global_dispatcher.js');
var C = require('constants/routine_constants.js');

var RoutineActions = {

    getCalendar: function(year, month, user_id, whichMonth) {
        $.ajax({
            type: 'get',
            url: '/users/'+user_id+'/calendar/year/'+year+'/month/'+month+'.json',
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.CALENDAR, {key: whichMonth, data: data})
            },
            error: function(response) {
                alert(response.responseJSON.errors);
            }
        });
    },

    getRoutine: function(year, month, day, user_id) {
        dispatcher.dispatch(C.LOADING, true);
        $.ajax({
            type: 'get',
            url: '/users/'+user_id+'/daily_routines/year/'+year+'/month/'+month+'/day/'+day+'.json',
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                if (response.status == 404) {
                    dispatcher.dispatch(C.ROUTINE_LOADED, {});
                } else {
                    alert(response.responseJSON.errors);
                }
            }
        });
    },

    swapWarmup: function(peid, exid) {
        var payload = JSON.stringify({performed_warm_up: { warmup_id: exid}});
        $.ajax({
            type: 'put',
            url: '/performed_warm_ups/'+peid+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: payload,
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.responseJSON.errors);
            }
        });
    },

    swapStrength: function(peid, exid) {
        var payload = JSON.stringify({performed_exercise: { exercise_id: exid}});
        $.ajax({
            type: 'put',
            url: '/performed_exercises/'+peid+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: payload,
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.responseJSON.errors);
            }
        });
    },

    swapPlyo: function(peid, exid) {
        var payload = JSON.stringify({performed_plyometric: { plyometric_id: exid}});
        $.ajax({
            type: 'put',
            url: '/performed_plyometrics/'+peid+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: payload,
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.responseJSON.errors);
            }
        });
    },

    swapSprint: function(peid, exid) {
        var payload = JSON.stringify({performed_sprint: { sprint_id: exid}});
        $.ajax({
            type: 'put',
            url: '/performed_sprints/'+peid+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: payload,
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.responseJSON.errors);
            }
        });
    },

    deleteExercise: function(type, peid) {
        var url = '/performed_' + type + '/' + peid + '.json';
        $.ajax({
            type: 'delete',
            url: url,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.responseJSON.errors);
            }
        });
    },

    addExercise: function(routineId, type, exId) {

        $.ajax({
            type: 'post',
            url: '/daily_routines/'+ routineId + '/'+ type + '/' +exId+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.responseJSON.errors);
            }
        });
    },

    resetRoutine: function(routineId) {
        dispatcher.dispatch(C.LOADING, true);
        $.ajax({
            type: 'get',
            url: '/daily_routines/' + routineId + '/reset.json',
            dataType: 'json',
            success: function (data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function (response) {
                alert(response.responseJSON.errors);
            }
        });
    },

    postComment: function(routineId, comment) {
        var payload = JSON.stringify({message: { message_type: 5, to_id: routineId, message: comment}});
        $.ajax({
            type: 'post',
            url: '/messages.json',
            data: payload,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                //dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.responseJSON.errors);
            }
        });
    },

    skipWorkout: function(routineId) {
        dispatcher.dispatch(C.LOADING, true);
        $.ajax({
            type: 'put',
            url: '/daily_routines/' + routineId + '/skip.json',
            dataType: 'json',
            success: function (data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function (response) {
                alert(response.responseJSON.errors);
            }
        });
    },

    completeWorkout: function(routine) {
        var payload = JSON.stringify(routine);
        dispatcher.dispatch(C.LOADING, true);
        $.ajax({
            type: 'put',
            url: '/daily_routines/' + routine.id + '/close.json',
            dataType: 'json',
            data: payload,
            success: function (data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function (response) {
                alert(response.responseJSON.errors);
            }
        });
    }

};

export default RoutineActions;