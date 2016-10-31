var dispatcher = require('global_dispatcher.js');
var C = require('constants/sign_up_constants.js');

var SignUpActions = {

    signUp: function(payload, more_info) {
        var url = '/users.json';
        if (more_info) {
            url = url + '?more=true';
        }

        var data = JSON.stringify(payload);
        $.ajax({
            type: 'post',
            data: data,
            url: url,
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
    },

    login: function(payload) {
        var data = JSON.stringify(payload);
        $.ajax({
            type: 'post',
            data: data,
            url: '/sign_in.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(results) {
                var payload = results;
                payload.success = true;
                dispatcher.dispatch(C.LOGIN_ATTEMPT, payload);
            },
            error: function(results) {
                var payload = results.responseJSON;
                payload.success = false;
                dispatcher.dispatch(C.LOGIN_ATTEMPT, payload);
            }
        });
    },

    forgotPassword: function(email) {
        var payload = {email: email};
        var data = JSON.stringify(payload);
        $.ajax({
            type: 'post',
            data: data,
            url: '/forgot_password.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(results) {
                var payload = {};
                payload.success = true;
                dispatcher.dispatch(C.PW_RESET, payload);
            },
            error: function(results) {
                var payload = results.responseJSON;
                payload.success = false;
                dispatcher.dispatch(C.PW_RESET, payload);
            }
        });
    }
};

export default SignUpActions;