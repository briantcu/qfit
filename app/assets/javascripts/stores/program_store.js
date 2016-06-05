var dispatcher = require('global_dispatcher.js');
var Store = require('./store.js');
var C = require('constants/program_constants.js');

var ProgramStore = new Store({
    days: undefined,
    minutes: undefined,

    setCommitment: function(commitment) {
        this.days = commitment.days;
        this.long = commitment.minutes >= 45;
    },

    getData: function(){
        return {
            days: this.days,
            minutes: this.minutes
        };
    }
});

dispatcher.register(C.COMMITMENT, function(data) {
    ProgramStore.setCommitment(data);
    ProgramStore.change();
});

export default ProgramStore;