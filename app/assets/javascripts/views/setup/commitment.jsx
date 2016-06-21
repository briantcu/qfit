import {render} from 'react-dom';

import SquareCheck from 'views/common/square_check';
import Button from 'views/common/button';

import ProgramActions from 'actions/program_actions';

require('views/setup/commitment.scss');

class Commitment extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            commitmentNextDisabled: true,
            frequency: undefined,
            time: undefined
        };
        this.frequencyChanged = this.frequencyChanged.bind(this);
        this.timeChanged = this.timeChanged.bind(this);
        this.commitmentSubmitted = this.commitmentSubmitted.bind(this);
        ProgramActions.setStrengthProgram(0);
    }

    frequencyChanged(elem) {
        var check = this.refs[elem.props.id];
        if (check.getValue()) {
            this.setState({frequency: Number(check.props.id), commitmentNextDisabled: !(this.state.time > 0)});
        } else {
            this.setState({frequency: undefined, commitmentNextDisabled: true})
        }
    }

    timeChanged(elem) {
        var check = this.refs[elem.props.id];
        if (check.getValue()) {
            this.setState({time: Number(check.props.id), commitmentNextDisabled: !(this.state.frequency > 0)});
        } else {
            this.setState({time: undefined, commitmentNextDisabled: true})
        }
    }

    commitmentSubmitted() {
        ProgramActions.setCommitment({days: this.state.frequency, minutes: this.state.time });
        this.props.next('COMMITMENT');
    }

    render () {
        return <div className="row commitment">
            <div className="container">
                <div className="row">
                    <div className="col-xs-6 col-xs-offset-3 text-center">
                        <span className="question">How many days per week can you strength train?</span>
                    </div>
                </div>
                <div className="row">
                    <div className="col-xs-2 col-xs-offset-3 text-center">
                        <SquareCheck ref="2" checked={this.state.frequency == 2} id="2" change={ this.frequencyChanged }
                                     label="2" />
                    </div>
                    <div className="col-xs-2 text-center">
                        <SquareCheck ref="3" checked={this.state.frequency == 3} id="3" change={ this.frequencyChanged }
                                     label="3"  />
                    </div>
                    <div className="col-xs-2 text-center">
                        <SquareCheck ref="4" checked={this.state.frequency == 4} id="4" change={ this.frequencyChanged }
                                     label="4" />
                    </div>
                </div>
                <div className="row">
                    <div className="col-xs-6 col-xs-offset-3 text-center">
                        <div className="question">How much time do you have for strength training?</div>
                    </div>
                </div>
                <div className="row">
                    <div className="col-xs-2 col-xs-offset-4 text-center">
                        <SquareCheck ref="30" change={ this.timeChanged } checked={this.state.time == 30} id="30"
                                     label="30 minutes" />
                    </div>
                    <div className="col-xs-2 text-center">
                        <SquareCheck ref="45" change={ this.timeChanged } checked={this.state.time == 45} id="45"
                                     label="45 minutes" />
                    </div>
                </div>
                <div className="row">
                    <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                        <Button ref="commitmentNext" buttonText="Continue" onClick={ this.commitmentSubmitted }
                                disabled={this.state.commitmentNextDisabled} />
                    </div>
                </div>
                <div className="row">
                    <div className="col-xs-2 col-xs-offset-5 back-link text-center">
                        <span onClick={ () => this.props.previousPage('COMMITMENT') } className="small-link">Back</span>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Commitment;
