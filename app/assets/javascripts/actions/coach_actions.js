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

    }
};

export default CoachActions;