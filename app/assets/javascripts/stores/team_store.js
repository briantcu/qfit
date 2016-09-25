var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/team_constants.js');

var TeamStore = new Store({
    team: {},

    setTeam: function(data){
        this.team = data;
    },

    getData: function(){
        return {
            team: this.team
        };
    }
});

dispatcher.register(C.TEAM_LOADED, function(data) {
    if(data){
        TeamStore.setTeam(data);
        TeamStore.change();
    }
});

export default TeamStore;