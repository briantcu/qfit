var dispatcher = require('global_dispatcher.js');
var C = require('constants/team_constants.js');

var TeamActions = {

    getTeam: function (team_id) {
        $.ajax({
            type: 'get',
            url: '/groups/' + team_id + '.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (team) {
                dispatcher.dispatch(C.TEAM_LOADED, team);
                if (team.group_schedule) {
                    this.getSchedule(team.group_schedule.id);
                }
            }.bind(this),
            error: function (results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    getSchedule: function (schedule_id) {
        $.ajax({
            type: 'get',
            url: '/group_schedules/' + schedule_id + '.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (schedule) {
                dispatcher.dispatch(C.TEAM_SCHEDULE_LOADED, schedule);
            },
            error: function (results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    },

    setSchedule: function (schedule) {
        var schedule = JSON.parse(JSON.stringify( schedule ));
        schedule.group_schedule_days_attributes = schedule.schedule_days;
        delete schedule.schedule_days;

        var group_schedule = {group_schedule: schedule};
        var data = JSON.stringify(group_schedule);
        if (schedule.id) {
            $.ajax({
                type: 'put',
                data: data,
                url: '/group_schedules/' + schedule.id + '.json',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (results, status, xhr) {
                    location.href = xhr.getResponseHeader('Location');
                },
                error: function (results) {
                    if(results.status==401) {
                        location.reload();
                    } else {
                        console.log(results);
                    }
                }
            });
        } else {
            $.ajax({
                type: 'post',
                data: data,
                url: '/group_schedules.json',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (results, status, xhr) {
                    location.href = xhr.getResponseHeader('Location');
                },
                error: function (results) {
                    if(results.status==401) {
                        location.reload();
                    } else {
                        console.log(results);
                    }
                }
            });
        }
    }
};

export default TeamActions;