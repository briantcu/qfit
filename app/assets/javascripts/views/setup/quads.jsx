import {render} from 'react-dom';
import CircleCheck from 'views/common/circle_check';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';
import Button from 'views/common/button';

require('views/setup/quads.scss');

class Quads extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            valid: true
        };
        this.change = this.change.bind(this);
    }

    submit () {
        if (!this.state.formSubmitted) {
            this.state.formSubmitted = true;
            var strength = this.refs.strength.getValue();
            var plyos = this.refs.plyos.getValue();
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
                this.props.next("QUADS");
            } else {
                this.setState({valid: false, formSubmitted: false});
            }
        }

    }

    change (elem) {
        var check = this.refs[elem.target.id];
        var obj = {};
        obj[check.props.id] = check.getValue();
        FitnessAssessmentActions.setQuads(obj);
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
                            Which of the Quads of the Quadfit program would you like to add to<br/> your program?
                            (Stretching will be added automatically)
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4 purple-bot-container purple-top-container">
                            <CircleCheck ref="strength" checked={this.props.quads.strength} id={'strength'}
                                         label={'Strength Training'} change={ this.change } />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4 purple-bot-container">
                            <CircleCheck ref="plyos" id={'plyos'} checked={this.props.quads.plyos} label={'Plyometrics'}
                                         change={ this.change } />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4 purple-bot-container">
                            <CircleCheck ref="sprinting" checked={this.props.quads.sprinting} id={'sprinting'} label={'Sprinting'}
                                         change={ this.change } />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4 purple-bot-container">
                            <CircleCheck id={'stretching'} label={'Stretching (Default)'} disabled={true} checked={true}/>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4 continue-row">
                            <If condition={this.state.valid == false}>
                                <span>You must choose at least one Quad.</span>
                            </If>
                            <Button ref="continue" buttonText="Continue" onClick={ () => this.submit() }
                                    disabled={false} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-2 col-xs-offset-4 back-link">
                           <span onClick={ () => this.props.previousPage('QUADS') } className="small-link">Back</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Quads;