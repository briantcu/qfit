var dispatcher = require('global_dispatcher.js');
var C = require('constants/social_constants.js');

var SocialActions = {

    getLeaders: function () {
        $.ajax({
            type: 'get',
            url: '/leaders.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (leaders) {
                dispatcher.dispatch(C.LEADERS_LOADED, leaders);
            }.bind(this),
            error: function (results) {
                if(results.status==401) {
                    location.reload();
                } else {
                    console.log(results);
                }
            }
        });
    }

};

export default SocialActions;
