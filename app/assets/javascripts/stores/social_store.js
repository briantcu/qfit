var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/social_constants.js');

var SocialStore = new Store({
    leaders: {
        male_power_index: [],
        female_power_index: [],
        male_power_index_ratio: [],
        female_power_index_ratio: [],
        sprints_performed: [],
        plyos_performed: [],
        sets_performed: [],
        reps_performed: []
    },

    setLeaders: function(data){
        this.leaders = data;
    },

    getData: function(){
        return {
            leaders: this.leaders
        };
    }
});

dispatcher.register(C.LEADERS_LOADED, function(data) {
    if(data){
        SocialStore.setLeaders(data);
        SocialStore.change();
    }
});


export default SocialStore;