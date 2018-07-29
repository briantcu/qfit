var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/coach_constants.js');

var CoachStore = new Store({
    account: {individuals: [], teams: [], sign_up_codes: []},

    setPlyos: function(data){
        this.plyometrics = data;
    },

    setAccount: function(data){
        this.account = data;
    },

    getData: function(){
        return {
            account: this.account
        };
    }
});

dispatcher.register(C.ACCOUNT_LOADED, function(data) {
    if(data){
        CoachStore.setAccount(data);
        CoachStore.change();
    }
});

export default CoachStore;