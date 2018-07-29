var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/program_constants.js');

var ProgramStore = new Store({
    days: undefined,
    minutes: undefined,
    long: undefined,
    strengthProgram: undefined,
    suggested_schedule: {},

    setCommitment: function(commitment) {
        this.days = commitment.days;
        this.long = commitment.minutes >= 45;
        this.minutes = commitment.minutes;
    },

    setStrengthProgram: function(program) {
        this.strengthProgram = program;
    },

    setSuggestedSchedule: function(data) {
        this.suggested_schedule = data;
    },

    getData: function(){
        return {
            days: this.days,
            minutes: this.minutes,
            long: this.long,
            strengthProgram: this.strengthProgram,
            suggested_schedule: this.suggested_schedule
        };
    }
});

dispatcher.register(C.COMMITMENT, function(data) {
    ProgramStore.setCommitment(data);
    ProgramStore.change();
});

dispatcher.register(C.PROGRAM, function(data) {
    ProgramStore.setStrengthProgram(data);
    ProgramStore.change();
});

dispatcher.register(C.SUGGESTED_LOADED, function(data) {
    ProgramStore.setSuggestedSchedule(data);
    ProgramStore.change();
});

export default ProgramStore;