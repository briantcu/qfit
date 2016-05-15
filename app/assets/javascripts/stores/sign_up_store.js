var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/sign_up_constants.js');

var SignUpStore = new Store({
    signUpStatus: {status: '', errors: []},
    isUsernameUnique: true,

    setSignUpStatus: function(params){
        this.signUpStatus = params;
    },

    setIsUsernameUnique: function(isUnique) {
        this.isUsernameUnique = isUnique;
    },

    getData: function(){
        return {
            signUpStatus: this.signUpStatus,
            isUsernameUnique: this.isUsernameUnique
        };
    }
});

dispatcher.register(C.SIGN_UP, function(data) {
    if(data){
        SignUpStore.setSignUpStatus(data);
        SignUpStore.change();
    }
});

dispatcher.register(C.UNIQUE_USERNAME, function(data) {
    if(data){
        SignUpStore.setIsUsernameUnique(data.isUnique);
        SignUpStore.change();
    }
});

export default SignUpStore;