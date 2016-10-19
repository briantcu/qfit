var dispatcher = require('global_dispatcher.js');
var C = require('constants/routine_constants.js');

var RoutineActions = {

    storeResults: function(type, exerciseId, setNum, reps, weight) {
        //Reps can be true/false for completed if lap/plyo/warmup
        dispatcher.dispatch(C.INPUT_CHANGED, {type: type, exId: exerciseId, setNum: setNum, reps: reps, weight: weight});
    },

    getCalendar: function(year, month, user_id, whichMonth, forUser) {
        if (forUser) {
            var url = '/users/'+user_id+'/calendar/year/'+year+'/month/'+month+'.json';
        } else {
            var url = '/groups/'+user_id+'/calendar/year/'+year+'/month/'+month+'.json';
        }
        $.ajax({
            type: 'get',
            url: url,
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.CALENDAR, {key: whichMonth, data: data})
            },
            error: function(response) {
                alert(response.errors);
            }
        });
    },

    getRoutine: function(year, month, day, id) {
        dispatcher.dispatch(C.LOADING, true);
        if (gon.viewing == 'user') {
            var url = '/users/'+id+'/daily_routines/year/'+year+'/month/'+month+'/day/'+day+'.json';
        } else {
            var url = '/groups/'+id+'/group_routines/year/'+year+'/month/'+month+'/day/'+day+'.json';
        }
        $.ajax({
            type: 'get',
            url: url,
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                if (response.status == 404) {
                    dispatcher.dispatch(C.ROUTINE_LOADED, {});
                } else {
                    alert(response.errors);
                }
            }
        });
    },

    getById: function(id) {
        dispatcher.dispatch(C.LOADING, true);
        if (gon.viewing == 'user') {
            var url = '/daily_routines/'+id+'.json';
        } else {
            var url = '/group_routines/'+id+'.json';
        }
        $.ajax({
            type: 'get',
            url: url,
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                if (response.status == 404) {
                    dispatcher.dispatch(C.ROUTINE_LOADED, {});
                } else {
                    alert(response.errors);
                }
            }
        });
    },

    swapWarmup: function(peid, exid) {
        if (gon.viewing == 'user') {
            var payload = JSON.stringify({performed_warm_up: { warmup_id: exid}});
            var url = '/performed_warm_ups/'+peid+'.json';
        } else {
            var payload = JSON.stringify({group_performed_warmup: { warmup_id: exid}});
            var url = '/group_performed_warmups/'+peid+'.json';
        }
        $.ajax({
            type: 'put',
            url: url,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: payload,
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.errors);
            }
        });
    },

    swapStrength: function(peid, exid) {
        if (gon.viewing == 'user') {
            var payload = JSON.stringify({performed_exercise: { exercise_id: exid}});
            var url = '/performed_exercises/'+peid+'.json';
        } else {
            var payload = JSON.stringify({group_performed_exercise: { exercise_id: exid}});
            var url = '/group_performed_exercises/'+peid+'.json';
        }
        $.ajax({
            type: 'put',
            url: url,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: payload,
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.errors);
            }
        });
    },

    swapPlyo: function(peid, exid) {
        if (gon.viewing == 'user') {
            var payload = JSON.stringify({performed_plyometric: { plyometric_id: exid}});
            var url = '/performed_plyometrics/'+peid+'.json';
        } else {
            var payload = JSON.stringify({group_performed_plyometric: { plyometric_id: exid}});
            var url = '/group_performed_plyometrics/'+peid+'.json';
        }
        $.ajax({
            type: 'put',
            url: url,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: payload,
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.errors);
            }
        });
    },

    swapSprint: function(peid, exid) {

        if (gon.viewing == 'user') {
            var payload = JSON.stringify({performed_sprint: { sprint_id: exid}});
            var url = '/performed_sprints/'+peid+'.json';
        } else {
            var payload = JSON.stringify({group_performed_sprint: { sprint_id: exid}});
            var url = '/group_performed_sprints/'+peid+'.json';
        }
        $.ajax({
            type: 'put',
            url: url,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: payload,
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.errors);
            }
        });
    },

    deleteExercise: function(type, peid) {
        if (gon.viewing == 'user') {
            var url = '/performed_' + type + '/' + peid + '.json';

            if (type == 'custom') {
                url = '/custom_exercises/' + peid + '.json';
            }
        } else {
            if (type == "warm_ups") {
                type = "warmups";
            }
            var url = '/group_performed_' + type + '/' + peid + '.json';

            if (type == 'custom') {
                url = '/group_custom_exercises/' + peid + '.json';
            }
        }

        $.ajax({
            type: 'delete',
            url: url,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.errors);
            }
        });
    },

    addExercise: function(routineId, type, exId) {
        if (gon.viewing == 'user') {
            var url = '/daily_routines/'+ routineId + '/'+ type + '/' +exId+'.json';
        } else {
            if (type == "warm_ups") {
                type = "warmups";
            }
            var url = '/group_routines/'+ routineId + '/'+ type + '/' +exId+'.json';
        }

        $.ajax({
            type: 'post',
            url: url,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.errors);
            }
        });
    },

    addCustomExercise: function(routineId, type, name) {
        var type_id = 4;
        if (type == 'weights') {
            type_id = 1;
        }

        if (type == 'plyos') {
            type_id = 2;
        }

        if (type == 'sprinting') {
            type_id = 3;
        }
        if (gon.viewing == 'user') {
            var url = '/daily_routines/'+ routineId + '/custom/'+ type_id + '/' +name+'.json';
        } else {
            if (type == "warm_ups") {
                type = "warmups";
            }
            var url = '/group_routines/'+ routineId + '/custom/'+ type_id + '/' +name+'.json';
        }

        $.ajax({
            type: 'post',
            url: url,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function(response) {
                alert(response.errors);
            }
        });
    },

    resetRoutine: function(routineId) {
        dispatcher.dispatch(C.LOADING, true);
        if (gon.viewing == 'user') {
            var url = '/daily_routines/'+ routineId + '/reset.json';
        } else {
            var url = '/group_routines/'+ routineId + '/reset.json';
        }
        $.ajax({
            type: 'get',
            url: url,
            dataType: 'json',
            success: function (data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function (response) {
                alert(response.errors);
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
                this.getById(routineId);
            }.bind(this),
            error: function(response) {
                alert(response.errors);
            }
        });
    },

    completeWorkout: function(routine) {
        _.each(routine.performed_sprints, function(ps) {
            ps.laps_attributes = ps.laps;
        });
        routine.performed_sprints_attributes = routine.performed_sprints;
        _.each(routine.performed_exercises, function(pe) {
            pe.weight_sets_attributes = pe.weight_sets;
        });
        routine.performed_exercises_attributes = routine.performed_exercises;

        routine.performed_plyometrics_attributes = routine.performed_plyometrics;
        routine.performed_warm_ups_attributes = routine.performed_warm_ups;

        var payload = JSON.stringify({daily_routine: routine});
        dispatcher.dispatch(C.LOADING, true);
        $.ajax({
            type: 'put',
            url: '/daily_routines/' + routine.id + '/close.json',
            dataType: 'json',
            data: payload,
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data)
            },
            error: function (response) {
                alert(response.errors);
            }
        });
    }

};

export default RoutineActions;