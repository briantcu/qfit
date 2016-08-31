var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/profile_constants.js');

var ProfileStore = new Store({
    data: {},

    setData: function(data){
        this.data = data;
    },

    getData: function(){
        return {
            data: this.data
        };
    }
});

dispatcher.register(C.LOADED, function(data) {
    if(data){
        ProfileStore.setData(data);
        ProfileStore.change();
    }
});


export default ProfileStore;