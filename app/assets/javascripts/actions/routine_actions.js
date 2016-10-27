var dispatcher = require('global_dispatcher.js');
var C = require('constants/routine_constants.js');

var RoutineActions = {

    storeResults: function(type, exerciseId, setNum, reps, weight, details) {
        //Reps can be true/false for completed if lap/plyo/warmup
        dispatcher.dispatch(C.INPUT_CHANGED, {type: type, exId: exerciseId, setNum: setNum, reps: reps, weight: weight, details: details});
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
        if (!routineId) {
            this.createRoutine(type, exId);
            return
        }
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

    createRoutine(type, exId) {
        var date = this.getDateForRoutine();
        if (gon.viewing == 'user') {
            var payload = JSON.stringify({daily_routine: { day: date.day, month: date.month, year: date.year, user_id: gon.current_user_id}});
            var url = '/daily_routines.json';
        } else {
            var payload = JSON.stringify({group_routine: { day: date.day, month: date.month, year: date.year, group_id: gon.team_id}});
            var url = '/group_routines.json';
        }

        $.ajax({
            type: 'post',
            url: url,
            data: payload,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                this.addExercise(data.id, type, exId);
            }.bind(this),
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

    completeWorkout: function(routine, callback) {
        var routine = JSON.parse(JSON.stringify( routine ));
        routine.performed_sprints_attributes = routine.performed_sprints;
        delete routine['performed_sprints'];
        _.each(routine.performed_sprints_attributes, function(ps) {
            ps.laps_attributes = ps.laps;
            delete ps['laps'];
            delete ps['sprint'];
            delete ps['sprint_details'];
        });

        routine.performed_exercises_attributes = routine.performed_exercises;
        delete routine['performed_exercises'];
        _.each(routine.performed_exercises_attributes, function(pe) {
            pe.weight_sets_attributes = pe.weight_sets;
            delete pe['weight_sets'];
            delete pe['exercise'];
            delete pe['exercise_type'];
        });

        routine.performed_plyometrics_attributes = routine.performed_plyometrics;
        delete routine['performed_plyometrics'];
        _.each(routine.performed_plyometrics_attributes, function(pe) {
            delete pe['plyometric'];
        });

        routine.performed_warm_ups_attributes = routine.performed_warm_ups;
        delete routine['performed_warm_ups'];
        _.each(routine.performed_warm_ups_attributes, function(pe) {
            delete pe['warmup'];
        });

        delete routine['comments'];
        delete routine['messages'];
        routine.custom_exercises_attributes = routine.custom_exercises;
        delete routine.custom_exercises;

        var payload = JSON.stringify({daily_routine: routine});
        dispatcher.dispatch(C.LOADING, true);
        $.ajax({
            type: 'put',
            url: '/daily_routines/' + routine.id + '/close.json',
            dataType: 'json',
            data: payload,
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                dispatcher.dispatch(C.ROUTINE_LOADED, data);
                callback();
            },
            error: function (response) {
                alert(response.errors);
            }
        });
    },

    getDateForRoutine() {
        var year, month, day;
        var urlArray = location.pathname.split('/');
        var today;
        if (urlArray.length > 3) {
            today = new Date(urlArray[2], urlArray[3] - 1, urlArray[4]);
        } else {
            today = new Date();
        }
        year = today.getFullYear();
        month = today.getMonth() + 1;
        day = today.getDate();
        return {year: year, month: month, day: day};
    },

    userWeightChanged: function(userWeight) {
        dispatcher.dispatch(C.USER_WEIGHT_CHANGED, userWeight);
    },

    saveChanges: function() {
        dispatcher.dispatch(C.SAVE_CHANGES);
    }

};

export default RoutineActions;