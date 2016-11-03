import {render} from 'react-dom';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';
var C = require('constants/fitness_assessment_constants.js');
import VCircleCheck from 'views/common/vert_circle_check';
import Button from 'views/common/button';

require('views/setup/goal.scss');

class Goal extends React.Component {
    constructor(props) {
        super(props);
        this.change = this.change.bind(this);
    }

    change (elem) {
        var check = this.refs[elem.target.id];
        if (check.getValue()) {
            this.setState({nextDisabled: false});
            FitnessAssessmentActions.setGoal(check.props.id);
        }
    }

    render () {
        return <div className="goal metal-bg">

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
                        <div className="col-xs-4 text-center">
                            <VCircleCheck checked={this.props.goal == C.MASS} id={C.MASS} ref={C.MASS}
                                         label={'Add Muscle'} change={ this.change } />
                        </div>

                        <div className="col-xs-4 text-center">
                            <VCircleCheck checked={this.props.goal == C.RIP} id={C.RIP} ref={C.RIP}
                                         label={'Moderate muscle gains, while lowering body fat percentage'}  change={ this.change }/>
                        </div>

                        <div className="col-xs-4 text-center">
                            <VCircleCheck checked={this.props.goal == C.LEAN} id={C.LEAN} ref={C.LEAN}
                                         label={'Lose Weight, Build Endurance'} change={ this.change } />
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-xs-2 col-xs-offset-5 button-row">
                            <Button ref="next" buttonText="Continue" onClick={ () => this.props.next('Goal') }
                                    disabled={false} />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Goal;
