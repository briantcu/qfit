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

            <div className="row no-margin">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-10 col-xs-offset-1 text-center">
                            <h1>What's Your Main Goal?</h1>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-10 col-xs-offset-1 header-text text-center">
                            This will help us build your customized program.
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-sm-4 col-xs-10 col-xs-offset-1 col-sm-offset-0 text-center">
                            <div className="img-container hidden-xs"><img className="first-img" src="https://s3.amazonaws.com/quadfit/add+muscle.png" /></div>
                            <div className="check-container first-check"><VCircleCheck checked={this.props.goal == C.MASS} id={C.MASS} ref={C.MASS}
                                         label={'Add Muscle'} change={ this.change } /></div>
                        </div>

                        <div className="col-sm-4 col-xs-10 col-xs-offset-1 col-sm-offset-0 text-center">
                            <div className="img-container hidden-xs"><img className="second-img" src="https://s3.amazonaws.com/quadfit/moderate+gains.png" /></div>
                            <div className="check-container"><VCircleCheck checked={this.props.goal == C.RIP} id={C.RIP} ref={C.RIP}
                                         label={'Moderate Muscle Gains, Reduce Fat'}  change={ this.change }/></div>
                        </div>

                        <div className="col-sm-4 col-xs-10 col-xs-offset-1 col-sm-offset-0 text-center">
                            <div className="img-container hidden-xs"><img className="last-img" src="https://s3.amazonaws.com/quadfit/loose+weight.png" /></div>
                            <div className="check-container"><VCircleCheck checked={this.props.goal == C.LEAN} id={C.LEAN} ref={C.LEAN}
                                         label={'Lose Weight, Build Endurance'} change={ this.change } /></div>
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 button-row">
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
