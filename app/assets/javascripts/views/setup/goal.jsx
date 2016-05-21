import {render} from 'react-dom';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';
var C = require('constants/fitness_assessment_constants.js');

require('views/setup/goal.scss');

class Goal extends React.Component {
    constructor(props) {
        super(props);
        this.onClick = this.onClick.bind(this);
    }

    next () {
        this.props.next("GOAL");
    }

    onClick (e) {
        console.log(e.target.value);
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
                        <div className="col-xs-10 col-xs-offset-1">
                            <input onChange={this.onClick} type="radio" name="goal" value="MASS" defaultChecked={this.props.goal == C.MASS}/> Add Muscle
                            <input onChange={this.onClick} type="radio" name="goal" value="RIP" defaultChecked={this.props.goal == C.RIP} /> Moderate muscle gains, while lowering body fat percentage
                            <input onChange={this.onClick} type="radio" name="goal" value="LEAN" defaultChecked={this.props.goal == C.LEAN} /> Lose Weight, Build Endurance
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
