var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/user_constants.js');

var UserStore = new Store({
    user: {},

    setUser: function(data){
        this.user = data;
    },

    getData: function(){
        return {
            user: this.user
        };
    }
});

dispatcher.register(C.LOADED, function(data) {
    if(data){
        UserStore.setUser(data);
        UserStore.change();
    }
});


export default UserStore;