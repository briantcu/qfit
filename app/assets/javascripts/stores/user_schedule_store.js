var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/user_constants.js');

var UserScheduleStore = new Store({
    schedule: {
        schedule_days: [
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
    week_days: [false, false, false, false, false, false, false],

    setSchedule: function(data){
        var weightsCount = 0;
        var plyosCount = 0;
        var sprintsCount = 0;

        data.weekly_schedule_days.forEach(function(day, i) {
            if (day.weights) {
                this.weights = true;
                weightsCount++;
                this.week_days[i] = true;
            }
            if (day.plyometrics) {
                this.plyos = true;
                plyosCount++;
                this.week_days[i] = true;
            }
            if (day.sprinting) {
                this.sprinting = true;
                sprintsCount++;
                this.week_days[i] = true;
            }

        }.bind(this));
        data.schedule_days = data.weekly_schedule_days;
        this.schedule = data;
        this.schedule.weightsCount = weightsCount;
        this.schedule.plyosCount = plyosCount;
        this.schedule.sprintsCount = sprintsCount;
    },

    getData: function(){
        return {
            schedule: this.schedule,
            weights: this.weights,
            plyos: this.plyos,
            sprinting: this.sprinting,
            week_days: this.week_days
        };
    }
});

dispatcher.register(C.SCHEDULE_LOADED, function(data) {
    if(data){
        UserScheduleStore.setSchedule(data);
        UserScheduleStore.change();
    }
});


export default UserScheduleStore;