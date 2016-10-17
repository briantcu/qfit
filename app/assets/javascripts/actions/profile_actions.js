var dispatcher = require('global_dispatcher');
var C = require('constants/profile_constants');

var ProfileActions = {

    update: function(payload) {
        var data = JSON.stringify(payload);
        $.ajax({
            type: 'put',
            data: data,
            url: '/users/'+ gon.user_id + '.json',
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
        var data = {checkout_type: type, token: token.id};
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
                dispatcher.dispatch(C.CHECKOUT_COMPLETED, payload);
            },
            error: function(results) {
                var payload = results;
                payload.success = false;
                dispatcher.dispatch(C.CHECKOUT_COMPLETED, payload);
            }
        });
    },

    updateSubscription: function(type) {
        var data = {type: type};
        data = JSON.stringify(data);
        $.ajax({
            type: 'put',
            data: data,
            url: '/subscription.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(results) {
                var payload = results;
                payload.success = true;
                dispatcher.dispatch(C.CHECKOUT_COMPLETED, payload);
            },
            error: function(results) {
                var payload = results;
                payload.success = false;
                dispatcher.dispatch(C.CHECKOUT_COMPLETED, payload);
            }
        });
    },

    updateBilling: function(token) {
        var data = {token: token.id};
        data = JSON.stringify(data);
        $.ajax({
            type: 'put',
            data: data,
            url: '/billing.json',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(results) {
                var payload = results;
                payload.success = true;
                dispatcher.dispatch(C.CHECKOUT_COMPLETED, payload);
            },
            error: function(results) {
                var payload = results;
                payload.success = false;
                dispatcher.dispatch(C.CHECKOUT_COMPLETED, payload);
            }
        });
    }
};

export default ProfileActions;