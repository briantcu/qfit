var dispatcher = require('global_dispatcher.js');
var C = require('constants/user_constants.js');

var UserActions = {

    getUser: function(user_id) {
        $.ajax({
            type: 'get',
            url: '/users/'+user_id+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(user) {
                dispatcher.dispatch(C.LOADED, user);
                if (user.user_schedule) {
                    this.getSchedule(user.user_schedule.id);
                }
            }.bind(this),
            error: function(results) {
                alert('Something went wrong!');
            }
        });
    },

    getSchedule: function(schedule_id) {
        $.ajax({
            type: 'get',
            url: '/user_schedules/'+schedule_id+'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(schedule) {
                dispatcher.dispatch(C.SCHEDULE_LOADED, schedule);
            },
            error: function(results) {
                alert('Something went wrong!');
            }
        });
    },

    setSchedule: function(schedule) {
        schedule.weekly_schedule_days_attributes = schedule.weekly_schedule_days;
        delete schedule.weekly_schedule_days;

        var user_schedule = {user_schedule: schedule};
        var data = JSON.stringify(user_schedule);
        if (schedule.id) {
            $.ajax({
                type: 'put',
                data: data,
                url: '/user_schedules/'+ schedule.id +'.json',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function(results) {
                    location.href = '/workout';
                },
                error: function(results) {
                    alert(results);
                }
            });
        } else {
            $.ajax({
                type: 'post',
                data: data,
                url: '/user_schedules.json',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function(results) {
                    location.href = '/workout';
                },
                error: function(results) {
                    alert(results);
                }
            });
        }
    }

};

export default UserActions;