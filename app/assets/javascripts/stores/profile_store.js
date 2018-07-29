var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/profile_constants.js');

var ProfileStore = new Store({
    data: {},
    saveStatus: {status: '', errors: []},
    checkout: {},

    setData: function(data){
        this.data = data;
    },

    setSaveStatus: function(data) {
        if (data.success) {
            this.saveStatus.status = C.PROFILE_SUCCESS;
        } else {
            this.saveStatus.status = C.PROFILE_FAILURE;
            this.saveStatus.errors = data;
        }
    },

    getData: function(){
        return {
            data: this.data,
            saveStatus: this.saveStatus,
            checkout: this.checkout
        };
    },

    setCheckoutData: function(data) {
        this.checkout = data;
    }
});

dispatcher.register(C.LOADED, function(data) {
    if(data){
        ProfileStore.setData(data);
        ProfileStore.change();
    }
});

dispatcher.register(C.PROFILE_SAVED, function(data) {
    if(data){
        ProfileStore.setSaveStatus(data);
        ProfileStore.change();
    }
});

dispatcher.register(C.CHECKOUT_COMPLETED, function(data) {
    if(data){
        ProfileStore.setCheckoutData(data);
        ProfileStore.change();
    }
});


export default ProfileStore;