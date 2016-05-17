var dispatcher = require('global_dispatcher.js');
var C = require('constants/sign_up_constants.js');

var SignUpActions = {

    signUp: function(payload) {
        var data = JSON.stringify(payload);
        $.ajax({
            type: 'post',
            data: data,
            url: '/users.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(results) {
                var payload = results;
                payload.success = true;
                dispatcher.dispatch(C.SIGN_UP, payload);
            },
            error: function(results) {
                var payload = results.responseJSON;
                payload.success = false;
                dispatcher.dispatch(C.SIGN_UP, payload);
            }
        });
    },

    usernameCheck: function(username) {
        $.ajax({
            type: 'get',
            url: '/username_exists/'+username+'.json',
            dataType: 'json',
            success: function(results) {
                dispatcher.dispatch(C.UNIQUE_USERNAME, {isUnique: false})
            },
            error: function(response) {
                if (response.status == 404) {
                    dispatcher.dispatch(C.UNIQUE_USERNAME, {isUnique: true})
                } else {
                    alert(JSON.parse(response.responseJSON));
                }
            }
        });
    }
};

export default SignUpActions;