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
                alert(JSON.parse(response.responseJSON));
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
                    alert(JSON.parse(response.responseJSON));
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
                alert(JSON.parse(response.responseJSON));
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
                alert(JSON.parse(response.responseJSON));
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
                alert(JSON.parse(response.responseJSON));
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
                alert(JSON.parse(response.responseJSON));
            }
        });
    }
};

export default RoutineActions;