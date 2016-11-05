import {render} from 'react-dom';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';
import SimpleInput from 'views/common/simple_input';
import Button from 'views/common/button';
import VideoModal from 'views/do-work/video_modal';

require('views/setup/fitness.scss');

class Fitness extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            step: 0,
            userWeightNextDisabled: true,
            benchNextDisabled: false,
            squatNextDisabled: false,
            pushupsNextDisabled: false,
            assistedNextDisabled: true,
            pullupsNextDisabled: false,
            showVideo: false
        };
        this.stepStack = [0];
        this.showVideo = this.showVideo.bind(this);
        this.closeVideo = this.closeVideo.bind(this);
    }

    componentWillReceiveProps(nextProps) {
        if (nextProps.userWeight) {
            this.setState({userWeightNextDisabled: false});
        }
    }

    changeStep(step) {
        this.stepStack.push(step);
        this.setState({step: step});
    }

    showVideo() {
        this.setState({showVideo: true});
    }

    closeVideo() {
        this.setState({showVideo: false});
    }

    back() {
        this.stepStack.pop();
        var step = this.stepStack[this.stepStack.length - 1];
        this.setState({step: step});
    }

    experienceLevelSubmitted() {
        FitnessAssessmentActions.setExperienceLevel(Number(this.refs.experienceLevel.value));
        this.changeStep(1);
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
        var benchWeight = this.refs.benchWeight.getValue();
        var benchReps = this.refs.benchReps.getValue();
        if (benchWeight && benchReps) {
            FitnessAssessmentActions.setBench(benchWeight, benchReps);
            this.changeStep(5);
        } else {
            this.changeStep(3);
        }
    }

    squatChanged() {
        this.setState({
            squatNextDisabled: (this.refs.squatWeight.getValue().length == 0) || (this.refs.squatReps.getValue().length == 0)
        });
    }
    squatSubmitted() {
        FitnessAssessmentActions.setSquat(this.refs.squatWeight.getValue(), this.refs.squatReps.getValue());
    }

    pushupsChanged() {
        this.setState({
            pushupsNextDisabled: this.refs.pushups.getValue().length == 0
        });
    }
    pushupsSubmitted() {
        FitnessAssessmentActions.setPushUps(this.refs.pushups.getValue());
        if (this.refs.pushups.getValue() == 0) {
            this.changeStep(4);
        } else {
            this.changeStep(5);
        }
    }

    assistedChanged() {
        this.setState({
            assistedNextDisabled: this.refs.assisted.getValue().length == 0
        });
    }
    assistedSubmitted() {
        FitnessAssessmentActions.setAssistedPushUps(this.refs.assisted.getValue());
        this.changeStep(5);
    }

    pullupsChanged() {
        this.setState({
            pushupsNextDisabled: this.refs.pullups.getValue().length == 0
        });
    }
    pullupsSubmitted() {
        FitnessAssessmentActions.setPullUps(this.refs.pullups.getValue());
        this.changeStep(6);
    }

    render () {
        return <div className="row fitness">
            <div className="container">
                <div className="row">
                    <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center">
                        <h1>Fitness Assessment</h1>
                    </div>
                </div>
                <div className="row">
                    <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center standard-text">
                        Answer these questions as well as you can.<br/>Feel free to skip a question if you don't know the answer.
                    </div>
                </div>
                <If condition={this.state.step == 0}>
                    <div className="row">
                        <div className="col-sm-10 col-sm-offset-1 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center">
                            <div className="question">What's your level of experience?</div>
                            <select ref="experienceLevel" className="form-control select">
                                <option value="1">Beginner</option>
                                <option value="2">Intermediate</option>
                                <option value="3">Advanced</option>
                            </select>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center buttonRow">
                            <Button buttonText="Continue" onClick={ () => this.experienceLevelSubmitted() } />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 back-link text-center">
                            <span onClick={ () => this.props.previousPage('FITNESS') } className="small-link">Back</span>
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 1}>
                    <div className="row">
                        <div className="col-sm-10 col-sm-offset-1 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center">
                            <div className="question">How much do you weigh?</div>
                            <div className="input-wrapper">
                                <SimpleInput ref="userWeight" onChange={ () => this.userWeightChanged() } label="lbs" value={this.props.userWeight} />
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center buttonRow">
                            <Button ref="userWeightNext" buttonText="Continue" onClick={ () => this.userWeightSubmitted() }
                                disabled={this.state.userWeightNextDisabled} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 back-link text-center">
                            <span onClick={ () => this.back() } className="small-link">Back</span>
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 2}>
                    <div className="row">
                        <div className="col-sm-10 col-sm-offset-1 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center">
                            <div className="question">How much can you bench press?</div>
                            <div className="input-wrapper">
                                <SimpleInput ref="benchWeight" onChange={ () => this.benchChanged() } label="lbs" value={this.props.benchWeight} />
                                <span className="input-buffer" />
                                <SimpleInput ref="benchReps" onChange={ () => this.benchChanged() } label="times" value={this.props.benchReps} />
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center idk">
                            <span onClick={ () => this.benchSubmitted() } className="small-link">I don't know</span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center idk-buttonRow">
                            <Button ref="benchNext" buttonText="Continue" onClick={ () => this.benchSubmitted() }
                                    disabled={this.state.benchNextDisabled} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 back-link text-center">
                            <span onClick={ () => this.back() } className="small-link">Back</span>
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 3}>
                    <div className="row">
                        <div className="col-sm-10 col-sm-offset-1 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center">
                            <div className="question">How many push ups can you do?</div>
                            <div className="input-wrapper">
                                <SimpleInput ref="pushups" onChange={ () => this.pushupsChanged() } label="" value={this.props.pushups} />
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center idk">
                            <span onClick={ () => this.pushupsSubmitted() } className="small-link">I can't do any</span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center idk-buttonRow">
                            <Button ref="pushupsNext" buttonText="Continue" onClick={ () => this.pushupsSubmitted() }
                                    disabled={this.state.pushupsNextDisabled} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 back-link text-center">
                            <span onClick={ () => this.back() } className="small-link">Back</span>
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 4}>
                    <div className="row">
                        <div className="col-sm-10 col-sm-offset-1 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center">
                            <div className="question">How many assisted push ups can you do? <span onClick={ () => this.showVideo() } className="small-link">See it</span></div>
                            <div className="input-wrapper">
                                <SimpleInput ref="assisted" onChange={ () => this.assistedChanged() } label="" value={this.props.assistedPushups} />
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center buttonRow">
                            <Button ref="assistedNext" buttonText="Continue" onClick={ () => this.assistedSubmitted() }
                                    disabled={this.state.assistedNextDisabled} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 back-link text-center">
                            <span onClick={ () => this.back() } className="small-link">Back</span>
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 5}>
                    <div className="row">
                        <div className="col-sm-10 col-sm-offset-1 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center">
                            <div className="question">How many pull ups can you do?</div>
                            <div className="input-wrapper">
                                <SimpleInput ref="pullups" onChange={ () => this.pullupsChanged() } label="" value={this.props.pullups} />
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center idk">
                            <span onClick={ () => this.pullupsSubmitted() } className="small-link">I don't know</span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center idk-buttonRow">
                            <Button ref="pullupsNext" buttonText="Continue" onClick={ () => this.pullupsSubmitted() }
                                    disabled={this.state.pullupsNextDisabled} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 back-link text-center">
                            <span onClick={ () => this.back() } className="small-link">Back</span>
                        </div>
                    </div>
                </If>

                <If condition={this.state.step == 6}>
                    <div className="row">
                        <div className="col-sm-10 col-sm-offset-1 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center">
                            <div className="question">How much can you squat?</div>
                            <div className="input-wrapper">
                                <SimpleInput ref="squatWeight" onChange={ () => this.squatChanged() } label="lbs" value={this.props.squatWeight} />
                                <span className="input-buffer" />
                                <SimpleInput ref="squatReps" onChange={ () => this.squatChanged() } label="times" value={this.props.squatReps} />
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center idk">
                            <span onClick={ () => this.squatSubmitted() } className="small-link">I don't know</span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 text-center idk-buttonRow">
                            <Button ref="benchNext" buttonText="Continue" onClick={ () => this.squatSubmitted() }
                                    disabled={this.state.squatNextDisabled} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 back-link text-center">
                            <span onClick={ () => this.back() } className="small-link">Back</span>
                        </div>
                    </div>
                </If>
            </div>
            <VideoModal show={this.state.showVideo} link={'176550405'} close={this.closeVideo} />
        </div>
    }

}

export default Fitness;