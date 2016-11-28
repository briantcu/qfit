var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/sign_up_constants.js');

var SignUpStore = new Store({
    signUpStatus: {status: '', errors: []},
    isUsernameUnique: true,
    loginStatus: {status: '', errors: []},
    pwResetStatus: {status: '', errors: []},
    sub_user: false,

    setSignUpStatus: function(params){
        if (params.success) {
            this.sub_user = params.sub_user
            this.signUpStatus.status = C.SUCCESS;
        } else {
            this.signUpStatus.status = C.FAILURE;
            this.signUpStatus.errors = params.errors;
        }
    },

    setIsUsernameUnique: function(isUnique) {
        this.isUsernameUnique = isUnique;
    },

    setLoginStatus: function(params) {
        if (params.success) {
            this.loginStatus.status = C.SUCCESS;
            this.loginStatus.location = params.location;
        } else {
            this.loginStatus.status = C.FAILURE;
            this.loginStatus.errors = params.errors;
        }
    },
    setResetStatus: function(params) {
        if (params.success) {
            this.pwResetStatus.status = C.SUCCESS;
        } else {
            this.pwResetStatus.status = C.FAILURE;
            this.pwResetStatus.errors = params.errors;
        }
    },

    getData: function(){
        return {
            signUpStatus: this.signUpStatus,
            isUsernameUnique: this.isUsernameUnique,
            loginStatus: this.loginStatus,
            pwResetStatus: this.pwResetStatus,
            sub_user: this.sub_user
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

dispatcher.register(C.PW_RESET, function(data) {
    if(data){
        SignUpStore.setResetStatus(data);
        SignUpStore.change();
    }
});

export default SignUpStore;