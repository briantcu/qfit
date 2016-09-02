var dispatcher = require('global_dispatcher');
var C = require('constants/profile_constants');

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
                dispatcher.dispatch(C.PROFILE_SAVED, payload);
            },
            error: function(results) {
                var payload = results.responseJSON;
                payload.success = false;
                dispatcher.dispatch(C.PROFILE_SAVED, payload);
            }
        });
    },

    checkout: function(token, type) {
        var data = {checkout_type: type, token: token};
        data = JSON.stringify(data);
        $.ajax({
            type: 'post',
            data: data,
            url: '/checkout.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(results) {
                var payload = results;
                payload.success = true;
            },
            error: function(results) {
                var payload = results.responseJSON;
                payload.success = false;
            }
        });
    }
};

export default ProfileActions;