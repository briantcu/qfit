import {render} from 'react-dom';

import SimpleInput from 'views/common/simple_input';
import Button from 'views/common/button';

import ProgramActions from 'actions/program_actions';

require('views/setup/commitment.scss');

class Commitment extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            commitmentNextDisabled: true
        };
    }

    inputChanged() {
        var disabled = this.refs.frequency.getValue().length == 0 || this.refs.length.getValue().length == 0;
        this.setState({commitmentNextDisabled: disabled});
    }

    commitmentSubmitted() {
        ProgramActions.setCommitment({days: this.refs.frequency.getValue(), minutes: this.refs.length.getValue()});
        this.next('COMMITMENT');
    }

    render () {
        return <div className="row commitment">
            <div className="container">
                <div className="row">
                    <div className="col-xs-6 col-xs-offset-3 text-center">
                        <div className="question">How many days per week can you exercise? The more you work, the easier it'll be to reach your goals!</div>
                        <SimpleInput ref="frequency" onChange={ () => this.inputChanged() } label="" value={this.props.program.days} />
                    </div>
                </div>
                <div className="row">
                    <div className="col-xs-6 col-xs-offset-3 text-center">
                        <div className="question">How much time do you have to exercise per day?</div>
                        <SimpleInput ref="length" onChange={ () => this.inputChanged() } label="minutes" value={this.props.program.minutes} />
                    </div>
                </div>
                <div className="row">
                    <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                        <Button ref="commitmentNext" buttonText="Continue" onClick={ () => this.commitmentSubmitted() }
                                disabled={this.state.commitmentNextDisabled} />
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Commitment;
