import {render} from 'react-dom';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';
var C = require('constants/fitness_assessment_constants.js');
import CircleCheck from 'views/common/circle_check';

require('views/setup/goal.scss');

class Goal extends React.Component {
    constructor(props) {
        super(props);
        this.change = this.change.bind(this);
    }

    next () {
        this.props.next("GOAL");
    }

    change (elem) {
        var check = this.refs[elem.target.id];
        if (check.getValue()) {
            this.setState({nextDisabled: false});
            FitnessAssessmentActions.setGoal(check.props.id);
        }
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
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck checked={this.props.goal == C.MASS} id={C.MASS} ref={C.MASS}
                                         label={'Add Muscle'} change={ this.change } />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck checked={this.props.goal == C.RIP} id={C.RIP} ref={C.RIP}
                                         label={'Moderate muscle gains, while lowering body fat percentage'}  change={ this.change }/>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck checked={this.props.goal == C.LEAN} id={C.LEAN} ref={C.LEAN}
                                         label={'Lose Weight, Build Endurance'} change={ this.change } />
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-xs-2 col-xs-offset-5">
                            <span onClick={ () => this.next()} className="continue-button purple-text">Continue</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Goal;
