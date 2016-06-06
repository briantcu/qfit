var dispatcher = require('global_dispatcher.js');
var C = require('constants/program_constants.js');

var ProgramActions = {

    setCommitment: function(data) {
        dispatcher.dispatch(C.COMMITMENT, data);
    },

    setStrengthProgram: function(program) {
        dispatcher.dispatch(C.PROGRAM , program);
    },

    getSuggestedSchedule: function(programType, weightSchedule) {
        var program = 3;
        if (programType == C.LEAN) {
            program = 1;
        } else if (programType == C.MASS) {
            program = 2;
        }
        $.ajax({
            type: 'get',
            url: '/schedule/program_type/'+program+'/weight_schedule/'+weightSchedule+'.json',
            dataType: 'json',
            success: function(data) {
                dispatcher.dispatch(C.SUGGESTED_LOADED, data)
            },
            error: function(response) {
                alert(JSON.parse(response.responseJSON));
            }
        });
    }

};

export default ProgramActions;