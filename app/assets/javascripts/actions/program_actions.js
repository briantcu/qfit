var dispatcher = require('global_dispatcher.js');
var C = require('constants/program_constants.js');

var ProgramActions = {

    setCommitment: function(data) {
        dispatcher.dispatch(C.COMMITMENT, data);
    }

};

export default ProgramActions;