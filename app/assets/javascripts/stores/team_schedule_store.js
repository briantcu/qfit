var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/team_constants.js');

var TeamScheduleStore = new Store({
    schedule: {
        group_schedule_days: [
            {weights: false, plyos: false, sprinting: false},
            {weights: false, plyos: false, sprinting: false},
            {weights: false, plyos: false, sprinting: false},
            {weights: false, plyos: false, sprinting: false},
            {weights: false, plyos: false, sprinting: false},
            {weights: false, plyos: false, sprinting: false},
            {weights: false, plyos: false, sprinting: false}
        ]
    },
    weights: false,
    plyos: false,
    sprinting: false,

    setSchedule: function(data){
        data.group_schedule_days.forEach(function(day, i) {
            if (day.weights) {
                this.weights = true;
            }
            if (day.plyometrics) {
                this.plyos = true;
            }
            if (day.sprinting) {
                this.sprinting = true;
            }

        }.bind(this));
        this.schedule = data;
    },

    getData: function(){
        return {
            schedule: this.schedule,
            weights: this.weights,
            plyos: this.plyos,
            sprinting: this.sprinting
        };
    }
});

dispatcher.register(C.TEAM_SCHEDULE_LOADED, function(data) {
    if(data){
        TeamScheduleStore.setSchedule(data);
        TeamScheduleStore.change();
    }
});


export default TeamScheduleStore;