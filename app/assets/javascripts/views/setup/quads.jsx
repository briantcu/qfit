import {render} from 'react-dom';
import CircleCheck from 'views/common/circle_check';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';

require('views/setup/quads.scss');

class Quads extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            valid: true
        }
    }

    submit () {
        if (!this.state.formSubmitted) {
            this.state.formSubmitted = true;
            var strength = this.refs.strength.getValue();
            var plyos = this.refs.plyo.getValue();
            var sprinting = this.refs.sprinting.getValue();
            var valid = strength || plyos || sprinting;
            if (valid) {
                FitnessAssessmentActions.setQuads(
                    {
                        strength: strength,
                        plyos: plyos,
                        sprinting: sprinting,
                        stretching: true
                    }
                );
                browserHistory.push('/fitness');
            } else {
                this.setState({valid: false, formSubmitted: false});
            }
        }

    }

    render () {
        return <div className="quads">
            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-4">
                            <h1 className="purple">Let's Get Started</h1>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-4 header-text">
                            Which of the Quads of the Quadfit program would you like to add to your program?
                            (Stretching will be added automatically)
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck ref="strength"  id={'strength'} label={'Strength Training'} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck ref="plyo" id={'plyo'} label={'Plyometrics'} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck ref="sprinting" id={'sprinting'} label={'Sprinting'} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck id={'stretching'} label={'Stretching (Default)'} disabled={true} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <If condition={this.state.valid == false}>
                                <span>You must choose at least one Quad.</span>
                            </If>
                            <span onClick={ () => this.submit()} className="continue-button purple-text">Continue</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Quads;