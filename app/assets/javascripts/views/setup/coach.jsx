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

    buttonClicked(option) {

    }

    render () {
        return <div className="coach">

            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-12 text-center">
                            <h1 className="purple">Let's Create a Workout Plan</h1>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 header-text text-center">
                            Make a Selection
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 header-text text-center">
                            <Button buttonText="Create a Team Plan" onClick={ () => this.buttonClicked('team') } />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 header-text text-center">
                            <hr className="hr-left" />
                            <span className="text-uppercase info-text">or</span>
                            <hr className="hr-right" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 header-text text-center">
                            <Button buttonText="Create a Plan for an Individual" onClick={ () => this.buttonClicked('individual') } />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Coach;
