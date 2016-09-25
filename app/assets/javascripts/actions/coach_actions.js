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
    }

};

export default CoachActions;