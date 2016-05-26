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
            userWeightNextDisabled: true,
            benchNextDisabled: true,
            squatNextDisabled: true,
            pushupsNextDisabled: true
        };
        this.stepStack = [1];
    }

    changeStep(step) {
        this.stepStack.push(step);
        this.setState({step: step});
    }

    back() {
        this.stepStack.pop();
        var step = this.stepStack[this.stepStack.length - 1];
        this.setState({step: step});
    }

    userWeightChanged() {
        this.setState({
            userWeightNextDisabled: this.refs.userWeight.getValue().length <= 1
        });
    }
    userWeightSubmitted() {
        FitnessAssessmentActions.setUserWeight(this.refs.userWeight.getValue());
        this.changeStep(2);
    }

    benchChanged() {
        this.setState({
            benchNextDisabled: (this.refs.benchWeight.getValue().length == 0) || (this.refs.benchReps.getValue().length == 0)
        });
    }
    benchSubmitted() {
        FitnessAssessmentActions.setBench(this.refs.benchWeight.getValue(), this.refs.benchReps.getValue());
        this.changeStep(5);
    }

    squatChanged() {
        this.setState({
            squatNextDisabled: (this.refs.squatWeight.getValue().length == 0) || (this.refs.squatReps.getValue().length == 0)
        });
    }
    squatSubmitted() {
        FitnessAssessmentActions.setSquat(this.refs.squatWeight.getValue(), this.refs.squatReps.getValue());
        this.done();
    }

    pushupsChanged() {
        this.setState({
            pushupsNextDisabled: this.refs.pushups.getValue().length == 0
        });
    }
    pushupsSubmitted() {
        FitnessAssessmentActions.setPushUps(this.refs.pushups.getValue());
        this.changeStep(5);
    }

    done() {

    }

    render () {
        return <div className="row fitness">
            <div className="container">
                <If condition={this.state.step == 1}>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center">
                            <div className="question">How much do you weigh?</div>
                            <SimpleInput ref="userWeight" onChange={ () => this.userWeightChanged() } label="lbs." />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                            <Button ref="userWeightNext" buttonText="Continue" onClick={ () => this.userWeightSubmitted() }
                                disabled={this.state.userWeightNextDisabled} />
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 2}>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center">
                            <div className="question">How much can you bench press?</div>
                            <SimpleInput ref="benchWeight" onChange={ () => this.benchChanged() } label="lbs." />
                            <SimpleInput ref="benchReps" onChange={ () => this.benchChanged() } label="times" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                            <Button buttonText="Back" onClick={ () => this.back() }
                                    disabled={false} />
                            <Button ref="benchSkip" buttonText="Skip" onClick={ () => this.changeStep(3) }
                                    disabled={false} />
                            <Button ref="benchNext" buttonText="Continue" onClick={ () => this.benchSubmitted() }
                                    disabled={this.state.benchNextDisabled} />
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 3}>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center">
                            <div className="question">How many push ups can you do?</div>
                            <SimpleInput ref="pushups" onChange={ () => this.pushupsChanged() } label="" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                            <Button buttonText="Back" onClick={ () => this.back() }
                                    disabled={false} />
                            <Button buttonText="I can't do any" onClick={ () => this.changeStep(4) }
                                    disabled={false} />
                            <Button ref="pushupsNext" buttonText="Continue" onClick={ () => this.pushupsSubmitted() }
                                    disabled={this.state.pushupsNextDisabled} />
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 4}>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center">
                            <div className="question">How many assisted push ups can you do?</div>
                            <SimpleInput ref="pushups" onChange={ () => this.pushupsChanged() } label="" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                            <Button buttonText="Back" onClick={ () => this.back() }
                                    disabled={false} />
                            <Button ref="pushupsNext" buttonText="Continue" onClick={ () => this.pushupsSubmitted() }
                                    disabled={this.state.pushupsNextDisabled} />
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 5}>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center">
                            <div className="question">How many pull ups can you do?</div>
                            <SimpleInput ref="pushups" onChange={ () => this.pushupsChanged() } label="" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                            <Button buttonText="Back" onClick={ () => this.back() }
                                    disabled={false} />
                            <Button buttonText="I can't do any" onClick={ () => this.changeStep(6) }
                                    disabled={false} />
                            <Button ref="pushupsNext" buttonText="Continue" onClick={ () => this.pushupsSubmitted() }
                                    disabled={this.state.pushupsNextDisabled} />
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 6}>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center">
                            <div className="question">How much can you squat?</div>
                            <SimpleInput ref="squatWeight" onChange={ () => this.squatChanged() } label="lbs." />
                            <SimpleInput ref="squatReps" onChange={ () => this.squatChanged() } label="times" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                            <Button buttonText="Back" onClick={ () => this.back() }
                                    disabled={false} />
                            <Button buttonText="Skip" onClick={ () => this.done() }
                                    disabled={false} />
                            <Button ref="benchNext" buttonText="Continue" onClick={ () => this.squatSubmitted() }
                                    disabled={this.state.squatNextDisabled} />
                        </div>
                    </div>
                </If>
            </div>
        </div>
    }

}

export default Fitness;