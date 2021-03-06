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
                this.props.next("Quads");
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
        return <div className="row quads no-margin">
            <div className="col-xs-12">
                <div className="container">
                    <div className="row">
                        <div className="col-sm-7 col-sm-offset-4 col-md-6 col-md-offset-4 col-xs-12 title">
                            <h1>Let's Get Started</h1>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-7 col-sm-offset-4 col-md-6 col-md-offset-4 col-xs-12 header-text">
                            Which Quads of the Quadfit program would you like to add to your program?
                            (Preparation will be added automatically)
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-6 col-sm-offset-4 col-md-5 col-md-offset-4 col-xs-12 purple-bot-container purple-top-container">
                            <CircleCheck ref="strength" defaultChecked={this.props.quads.strength} id={'strength'}
                                         label={'Strength Training'} change={ this.change } />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-6 col-sm-offset-4 col-md-5 col-md-offset-4 col-xs-12 purple-bot-container">
                            <CircleCheck ref="plyos" id={'plyos'} defaultChecked={this.props.quads.plyos} label={'Plyometrics'}
                                         change={ this.change } />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-6 col-sm-offset-4 col-md-5 col-md-offset-4 col-xs-12 purple-bot-container">
                            <CircleCheck ref="sprinting" defaultChecked={this.props.quads.sprinting} id={'sprinting'} label={'Sprinting'}
                                         change={ this.change } />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-6 col-sm-offset-4 col-md-5 col-md-offset-4 col-xs-12 purple-bot-container">
                            <CircleCheck id={'stretching'} label={'Preparation'} disabled={true} checked={true}/>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-6 col-sm-offset-4 col-md-5 col-md-offset-4 col-xs-12 continue-row">
                            <If condition={this.state.valid == false}>
                                <div className="error-text">You must choose at least one Quad.</div>
                            </If>
                            <Button ref="continue" buttonText="Continue" onClick={ () => this.submit() }
                                    disabled={false} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-6 col-sm-offset-4 col-md-5 col-md-offset-4 col-xs-10 col-xs-offset-0 back-link">
                           <span onClick={ () => this.props.previousPage('QUADS') } className="small-link">Back</span>
                        </div>
                    </div>
                </div>
            </div>
            </div>
    }

}
Quads.displayName = 'Quads';

export default Quads;