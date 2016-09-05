var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/user_constants.js');
var PC = require('constants/profile_constants.js');

var UserStore = new Store({
    user: {},
    chart: {},

    setUser: function(data){
        this.user = data;
    },

    getData: function(){
        return {
            user: this.user,
            chart: this.chart
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


export default UserStore;