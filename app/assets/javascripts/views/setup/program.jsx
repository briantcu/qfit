import {render} from 'react-dom';
import CircleCheck from 'views/common/circle_check';
import Button from 'views/common/button';

import ProgramActions from 'actions/program_actions';

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
                        <div className="col-xs-6 col-xs-offset-4">
                            <h1 className="purple">Choose a Strength Training Program</h1>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-4 header-text">
                            Based on your goal, we'll be putting you on the {this.props.module} module.
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-4 header-text">
                            Help us put together your weight training program.
                            The schedules are listed in order from easiest to most difficult. More difficult schedules will
                            yield more explosive results. You can change your schedule at any time.
                        </div>
                    </div>
                    <If condition={this.props.program.days == 2}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="pro1" checked={this.props.program.strengthProgram == 1}  id={'pro1'}
                                             label={'2 30 minute days per week'} change={ this.change }/>
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 3}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="pro2" checked={this.props.program.strengthProgram == 2} id={'pro2'}
                                             label={'3 30 minute days per week'} change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 2 && this.props.program.long}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="pro3" checked={this.props.program.strengthProgram == 3}  id={'pro3'}
                                             label={'2 45 minute days per week'}  change={ this.change }/>
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 3 && this.props.program.long}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="pro4" checked={this.props.program.strengthProgram == 4} id={'pro4'}
                                             label={'2 30 minute days per week, and 1 45 minute day per week'} change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 4}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="pro5" checked={this.props.program.strengthProgram == 5} id={'pro5'}
                                             label={'4 30 minute days per week'} change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 3 && this.props.program.long}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="pro6" checked={this.props.program.strengthProgram == 6} id={'pro6'}
                                             label={'3 45 minute days per week'}  change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 4 && this.props.program.long }>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="pro7" checked={this.props.program.strengthProgram == 7} id={'pro7'}
                                             label={'2 30 minute days per week, and 2 45 minute days per week'} change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 4 && this.props.program.long }>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="pro8" checked={this.props.program.strengthProgram == 8} id={'pro8'}
                                             label={'4 45 minute days per week'} change={ this.change } />
                            </div>
                        </div>
                    </If>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <If condition={this.state.valid == false}>
                                <span>You must choose a schedule.</span>
                            </If>
                            <Button ref="programNext" buttonText="Continue" onClick={ () => this.submit() }
                                    disabled={!this.props.program || !this.props.program.strengthProgram} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-2 col-xs-offset-5 back-link text-center">
                            <span onClick={ () => this.props.previousPage('PROGRAM') } className="small-link">Back</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Program;
