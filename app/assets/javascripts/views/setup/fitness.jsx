import {render} from 'react-dom';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';

require('views/setup/fitness.scss');

class Fitness extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            step: 1
        }
    }

    changeStep(step) {
        this.setState({step: step});
    }

    componentDidMount() {
        $(this.refs.userWeightNext).prop("disabled", "disabled");
    }

    evalUserWeightInput() {
        this.refs.userWeightNext.disabled = this.refs.userWeight.value.length <= 1;
    }

    render () {
        return <div className="row fitness">
            <div className="container">
                <If condition={this.state.step == 1}>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 ">
                            How much do you weigh? <input ref="userWeight" type="text" onChange={ () => this.evalUserWeightInput() } /> lbs.
                        </div>
                    </div>
                    <div className="row">
                        <button ref="userWeightNext" type="submit" className="btn btn-default" onClick={ () => this.changeStep(2) }>Next</button>
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