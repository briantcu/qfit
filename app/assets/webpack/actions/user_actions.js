var dispatcher = require('global_dispatcher.js');
var C = require('constants/tote_constants.js');
var $ = require('jquery');

var ToteActions = {

    getTote: function(toteId) {
        $.ajax({
            url: '/api/customers/'+gon.customerId+'/totes/'+toteId+'?simple=true',
            success: function(results) {
                dispatcher.dispatch(C.ACTIVE_TOTE, results)
            },
            error: function(request) {
                alert(JSON.parse(request.responseText).message);
            }
        });
    }
};

module.exports = ToteActions;