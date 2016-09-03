var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/sign_up_constants.js');

var SignUpStore = new Store({
    signUpStatus: {status: '', errors: []},
    isUsernameUnique: true,
    loginStatus: {status: '', errors: []},

    setSignUpStatus: function(params){
        if (params.success) {
            this.signUpStatus.status = C.SUCCESS;
        } else {
            this.signUpStatus.status = C.FAILURE;
            this.signUpStatus.errors = params;
        }
    },

    setIsUsernameUnique: function(isUnique) {
        this.isUsernameUnique = isUnique;
    },

    setLoginStatus: function(params) {
        if (params.success) {
            this.loginStatus.status = C.SUCCESS;
        } else {
            this.loginStatus.status = C.FAILURE;
            this.loginStatus.errors = params;
        }
    },

    getData: function(){
        return {
            signUpStatus: this.signUpStatus,
            isUsernameUnique: this.isUsernameUnique,
            loginStatus: this.loginStatus
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
dispatcher.register(C.LOGIN_ATTEMPT, function(data) {
    if(data){
        SignUpStore.setLoginStatus(data);
        SignUpStore.change();
    }
});

export default SignUpStore;