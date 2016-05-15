var dispatcher = require('global_dispatcher.js');
var C = require('constants/sign_up_constants.js');

var SignUpActions = {

    signUp: function(params) {
        console.log(params);
        $.ajax({
            type: 'post',
            data: params,
            url: '/users.json',
            dataType: 'json',
            success: function(results) {
                dispatcher.dispatch(C.ACTIVE_TOTE, results)
            },
            error: function(request) {
                alert(JSON.parse(request.responseText).message);
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
                    alert(JSON.parse(response.responseText).message);
                }
            }
        });
    }
};

export default SignUpActions;