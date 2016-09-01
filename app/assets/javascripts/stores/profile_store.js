var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/profile_constants.js');

var ProfileStore = new Store({
    data: {},
    saveStatus: {status: '', errors: []},

    setData: function(data){
        this.data = data;
    },

    setSaveStatus: function(data) {
        if (data.success) {
            this.saveStatus.status = C.SUCCESS;
        } else {
            this.saveStatus.status = C.FAILURE;
            this.saveStatus.errors = data;
        }
    },

    getData: function(){
        return {
            data: this.data,
            saveStatus: this.saveStatus
        };
    }
});

dispatcher.register(C.LOADED, function(data) {
    if(data){
        ProfileStore.setData(data);
        ProfileStore.change();
    }
});

dispatcher.register(C.SAVED, function(data) {
    if(data){
        ProfileStore.setSaveStatus(data);
        ProfileStore.change();
    }
});


export default ProfileStore;