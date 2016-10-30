var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/user_constants.js');
var PC = require('constants/profile_constants.js');

var UserStore = new Store({
    user: { recent_workouts: []},
    loggedInUser: {},
    chart: {},
    maxes: [],

    setUser: function(data){
        this.user = data;
    },

    setLoggedInUser: function(data) {
        this.loggedInUser = data;
    },

    setMaxes: function(data){
        this.maxes = data;
    },

    getData: function(){
        return {
            user: this.user,
            chart: this.chart,
            maxes: this.maxes,
            loggedInUser: this.loggedInUser
        };
    },
    setChart: function(data){
        this.chart = data;
    }
});

dispatcher.register(C.LOADED, function(data) {
    if(data){
        UserStore.setUser(data);
        UserStore.change();
    }
});

dispatcher.register(C.LOADED_LOGGED_IN, function(data) {
    if(data){
        UserStore.setLoggedInUser(data);
        UserStore.change();
    }
});

dispatcher.register(PC.PROFILE_SAVED, function(data) {
    if(data){
        UserStore.setUser(data);
        UserStore.change();
    }
});

dispatcher.register(C.CHART_LOADED, function(data) {
    if(data){
        UserStore.setChart(data);
        UserStore.change();
    }
});

dispatcher.register(C.MAXES_LOADED, function(data) {
    if(data){
        UserStore.setMaxes(data);
        UserStore.change();
    }
});


export default UserStore;