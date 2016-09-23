import {render} from 'react-dom';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';
var C = require('constants/fitness_assessment_constants.js');
import VCircleCheck from 'views/common/vert_circle_check';
import Button from 'views/common/button';

require('views/setup/coach.scss');

class Coach extends React.Component {
    constructor(props) {
        super(props);
        this.change = this.change.bind(this);
    }

    change (elem) {
    }

    render () {
        return <div className="goal">

            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center">
                            <h1 className="purple">What's Your Main Goal?</h1>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 header-text text-center">
                            This will help us build your customized workout program.
                        </div>
                    </div>

                    <div className="row">

                    </div>
                </div>
            </div>
        </div>
    }

}

export default Coach;
