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
        console.log(peid + ', ' + exid);
    },

    swapStrength: function(peid, exid) {
        console.log(peid + ', ' + exid);
    },

    swapPlyo: function(peid, exid) {
        console.log(peid + ', ' + exid);
    },

    swapSprint: function(peid, exid) {
        console.log(peid + ', ' + exid);
    }
};

export default RoutineActions;