import {render} from 'react-dom';
import CircleCheck from 'views/common/circle_check';
import Button from 'views/common/button';

import ProgramActions from 'actions/program_actions';

require('views/setup/program.scss');

class Program extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            valid: true
        };
        this.change = this.change.bind(this);
    }

    change (elem) {
        var check = this.refs[elem.target.id];
        if (check.getValue()) {
            ProgramActions.setStrengthProgram(Number(check.props.id.slice(-1)));
        }
    }

    submit () {
        this.props.next('Program');
    }

    render () {
        return <div className="program metal-bg">
            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-10 col-xs-offset-1">
                            <h1>Pick a Strength Training Schedule</h1>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-10 col-xs-offset-1 header-text">
                            The schedules are listed in order from easiest to most difficult.<br/>
                            You can change your schedule at any time.
                        </div>
                    </div>
                    <If condition={this.props.program.days == 2}>
                        <div className="row">
                            <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 purple-bot-container purple-top-container full">
                                <CircleCheck ref="pro1" checked={this.props.program.strengthProgram == 1}  id={'pro1'}
                                             label={'Two 30 minute days per week'} change={ this.change }/>
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 3}>
                        <div className="row">
                            <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 purple-bot-container purple-top-container full">
                                <CircleCheck ref="pro2" checked={this.props.program.strengthProgram == 2} id={'pro2'}
                                             label={'Three 30 minute days per week'} change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 2 && this.props.program.long}>
                        <div className="row">
                            <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 purple-bot-container full">
                                <CircleCheck ref="pro3" checked={this.props.program.strengthProgram == 3}  id={'pro3'}
                                             label={'Two 45 minute days per week'}  change={ this.change }/>
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 3 && this.props.program.long}>
                        <div className="row">
                            <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 purple-bot-container full">
                                <CircleCheck ref="pro4" checked={this.props.program.strengthProgram == 4} id={'pro4'}
                                             label={'Two 30 minute days per week, and one 45 minute day per week'} change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 4}>
                        <div className="row">
                            <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 purple-bot-container purple-top-container full">
                                <CircleCheck ref="pro5" checked={this.props.program.strengthProgram == 5} id={'pro5'}
                                             label={'Four 30 minute days per week'} change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 3 && this.props.program.long}>
                        <div className="row">
                            <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 purple-bot-container full">
                                <CircleCheck ref="pro6" checked={this.props.program.strengthProgram == 6} id={'pro6'}
                                             label={'Three 45 minute days per week'}  change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 4 && this.props.program.long }>
                        <div className="row">
                            <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 purple-bot-container full">
                                <CircleCheck ref="pro7" checked={this.props.program.strengthProgram == 7} id={'pro7'}
                                             label={'Two 30 minute days per week, and two 45 minute days per week'} change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 4 && this.props.program.long }>
                        <div className="row">
                            <div className="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 purple-bot-container full">
                                <CircleCheck ref="pro8" checked={this.props.program.strengthProgram == 8} id={'pro8'}
                                             label={'Four 45 minute days per week'} change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <div className="row button-row">
                        <div className="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-10 col-xs-offset-1">
                            <If condition={this.state.valid == false}>
                                <span>You must choose a schedule.</span>
                            </If>
                            <Button ref="programNext" buttonText="Continue" onClick={ () => this.submit() }
                                    disabled={!this.props.program || !this.props.program.strengthProgram} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-10 col-xs-offset-1 back-link">
                            <span onClick={ () => this.props.previousPage('PROGRAM') } className="small-link">Back</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Program;
