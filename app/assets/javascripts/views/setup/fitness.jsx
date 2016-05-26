import {render} from 'react-dom';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';
import SimpleInput from 'views/common/simple_input';
import Button from 'views/common/button';

require('views/setup/fitness.scss');

class Fitness extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            step: 1,
            userWeightNextDisabled: true
        };
    }

    changeStep(step) {
        this.setState({step: step});
    }

    evalUserWeightInput() {
        this.setState({
            userWeightNextDisabled: this.refs.userWeight.getValue().length <= 1
        });
    }

    userWeightSubmitted() {
        FitnessAssessmentActions.setUserWeight(this.refs.userWeight.getValue());
        this.changeStep(2);
    }

    render () {
        return <div className="row fitness">
            <div className="container">
                <If condition={this.state.step == 1}>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center">
                            <div className="question">How much do you weigh?</div>
                            <SimpleInput ref="userWeight" onChange={ () => this.evalUserWeightInput() } label="lbs." />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                            <Button ref="userWeightNext" buttonText="Next" onClick={ () => this.userWeightSubmitted() }
                                disabled={this.state.userWeightNextDisabled} />
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 2}>
                    <div className="col-xs-6 col-xs-offset-3">
                        Bench
                    </div>
                </If>

                <If condition={this.state.step == 3}>
                    <div className="col-xs-6 col-xs-offset-3">
                        Push Ups
                    </div>
                </If>

                <If condition={this.state.step == 4}>
                    <div className="col-xs-6 col-xs-offset-3">
                        Assisted Push Ups
                    </div>
                </If>

                <If condition={this.state.step == 5}>
                    <div className="col-xs-6 col-xs-offset-3">
                        Pull Ups
                    </div>
                </If>

                <If condition={this.state.step == 6}>
                    <div className="col-xs-6 col-xs-offset-3">
                        Squats
                    </div>
                </If>
            </div>
        </div>
    }

}

export default Fitness;