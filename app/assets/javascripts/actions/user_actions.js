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
            },
            error: function(results) {
                alert('Something went wrong!');
            }
        });
    }

};

export default UserActions;