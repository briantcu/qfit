var dispatcher = require('global_dispatcher.js');
var C = require('constants/profile_constants.js');

var ProfileActions = {

    update: function(payload) {
        var data = JSON.stringify(payload);
        $.ajax({
            type: 'put',
            data: data,
            url: '/users/'+ gon.current_user_id + '.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(results) {
                var payload = results;
                payload.success = true;
                dispatcher.dispatch(C.SAVED, payload);
            },
            error: function(results) {
                var payload = results.responseJSON;
                payload.success = false;
                dispatcher.dispatch(C.SAVED, payload);
            }
        });
    }
};

export default ProfileActions;