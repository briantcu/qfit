var dispatcher = require('global_dispatcher.js');
var C = require('constants/coach_constants.js');

var CoachActions = {

    getAccount: function(id) {
        $.ajax({
            type: 'get',
            url: '/coach_accounts/'+ id + '.json',
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.ACCOUNT_LOADED, data)
            }
        });

    },

    createTempTeam: function(forTeam) {
        var data = {group: {is_template: true, for_team: forTeam}};
        data = JSON.stringify(data);
        $.ajax({
            type: 'post',
            url: '/groups.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: data,
            success: function() {
                if (forTeam) {
                    location.href = '/setup/quads'
                } else {
                    location.href = '/setup/goal'
                }
            }
        });
    },

    sendInvite: function(send_to, group_id, sign_up_type, callback) {
        var data = {send_to: send_to, sign_up_type: sign_up_type, template_id: group_id};
        data = JSON.stringify(data);
        $.ajax({
            type: 'post',
            url: '/coach_accounts/' + gon.coach_account_id + '/send_invite.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: data,
            success: function(response) {
                callback(response);
            }
        });
    },

    updateTeam: function(id, name, callback) {
        var payload = {group: {name: name, is_template: false}};
        var data = JSON.stringify(payload);
        $.ajax({
            type: 'put',
            data: data,
            url: '/groups/'+ id + '.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(results) {
                callback(results);
            },
            error: function(results) {
                var payload = results.responseJSON;
                payload.success = false;
                dispatcher.dispatch(C.PROFILE_SAVED, payload);
            }
        });
    },

    viewTeam: function(id) {
        var data = {group_id: id};
        data = JSON.stringify(data);
        $.ajax({
            type: 'post',
            url: '/view/groups.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: data,
            success: function(response) {
                location.href = '/workout';
            }
        });
    },

    viewAthlete: function(id) {
        var data = {user_id: id};
        data = JSON.stringify(data);
        $.ajax({
            type: 'post',
            url: '/view/users.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: data,
            success: function(response) {
                location.href = '/workout';
            }
        });
    },

    changeTeam: function(newTeam, athleteId) {
        var data = {user_id: athleteId};
        data = JSON.stringify(data);
        $.ajax({
            type: 'post',
            url: '/groups/'+ newTeam + '.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: data,
            success: function(response) {
                this.getAccount(gon.coach_account_id);
            }.bind(this)
        });
    },

    deleteTeam: function(teamId) {
        $.ajax({
            type: 'delete',
            url: '/groups/'+ teamId + '.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                this.getAccount(gon.coach_account_id);
            }.bind(this)
        });
    },

    deleteUser: function(userId) {
        $.ajax({
            type: 'delete',
            url: '/coach_accounts/' + gon.coach_account_id + '/users/'+userId +'.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data) {
                dispatcher.dispatch(C.ACCOUNT_LOADED, data)
            }
        });
    }

};

export default CoachActions;