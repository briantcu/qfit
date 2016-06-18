import {render} from 'react-dom';

import SquareCheck from 'views/common/square_check';
import Button from 'views/common/button';

require('views/setup/schedule.scss');

class Schedule extends React.Component {
    constructor(props) {
        super(props);
        this.weightsDayChanged = this.weightsDayChanged.bind(this);
        this.submit = this.submit.bind(this);

        var minPlyoDays = this.props.suggested_schedule.num_plyo_days;
        var minSprintingDays = this.props.suggested_schedule.num_sprint_days;
        var weightDays = this.props.suggested_schedule.num_weight_days;

        this.state = {
            errors: [],
            minPlyoDays: minPlyoDays,
            minSprintingDays: minSprintingDays,
            weightDays: weightDays
        }
    }

    weightsDayChanged(e) {
        var check = this.refs[e.props.id];
        var day = Number(check.props.id.slice(-1));
        //this.setState({time: Number(check.props.id), commitmentNextDisabled: !(this.state.frequency > 0)});
    }

    submit() {

    }

    render () {
        return <div className="schedule">
            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4 text-center">
                            Weekly Planner
                        </div>
                    </div>
                    <If condition={this.props.quads.strength || this.props.user_schedule.weights}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4 text-center">
                                Which days will you lift?<br/>
                                The program you chose has {this.state.weightDays} lifting days.
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-2 col-xs-offset-1">
                                <SquareCheck ref="w0" checked={this.props.user_schedule.schedule.weekly_schedule_days[0].weights}
                                             id="w0" change={ this.weightsDayChanged } label="Sunday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w1" checked={this.props.user_schedule.schedule.weekly_schedule_days[1].weights}
                                             id="w1" change={ this.weightsDayChanged } label="Monday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w2" checked={this.props.user_schedule.schedule.weekly_schedule_days[2].weights}
                                             id="w2" change={ this.weightsDayChanged } label="Tuesday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w3" checked={this.props.user_schedule.schedule.weekly_schedule_days[3].weights}
                                             id="w3" change={ this.weightsDayChanged } label="Wednesday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w4" checked={this.props.user_schedule.schedule.weekly_schedule_days[4].weights}
                                             id="w4" change={ this.weightsDayChanged } label="Thursday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w5" checked={this.props.user_schedule.schedule.weekly_schedule_days[5].weights}
                                             id="w5" change={ this.weightsDayChanged } label="Friday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w6" checked={this.props.user_schedule.schedule.weekly_schedule_days[6].weights}
                                             id="w6" change={ this.weightsDayChanged } label="Saturday" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.quads.plyos || this.props.user_schedule.plyos}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4 text-center">
                                Which days will you do plyometric exercises?<br/>
                                To meet your goals, we recommend at least {this.state.minPlyoDays} plyometric days.
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-2 col-xs-offset-1">
                                <SquareCheck ref="p0" checked={this.props.user_schedule.schedule.weekly_schedule_days[0].plyometrics}
                                             id="p0" change={ this.plyosDayChanged } label="Sunday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p1" checked={this.props.user_schedule.schedule.weekly_schedule_days[1].plyometrics}
                                             id="p1" change={ this.plyosDayChanged } label="Monday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p2" checked={this.props.user_schedule.schedule.weekly_schedule_days[2].plyometrics}
                                             id="p2" change={ this.plyosDayChanged } label="Tuesday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p3" checked={this.props.user_schedule.schedule.weekly_schedule_days[3].plyometrics}
                                             id="p3" change={ this.plyosDayChanged } label="Wednesday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p4" checked={this.props.user_schedule.schedule.weekly_schedule_days[4].plyometrics}
                                             id="p4" change={ this.plyosDayChanged } label="Thursday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p5" checked={this.props.user_schedule.schedule.weekly_schedule_days[5].plyometrics}
                                             id="p5" change={ this.plyosDayChanged } label="Friday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p6" checked={this.props.user_schedule.schedule.weekly_schedule_days[6].plyometrics}
                                             id="p6" change={ this.plyosDayChanged } label="Saturday" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.quads.sprinting || this.props.user_schedule.sprinting}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4 text-center">
                                Which days will you sprint?<br/>
                                To meet your goals, we recommend at least {this.state.minSprintingDays} sprinting days.
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-2 col-xs-offset-1">
                                <SquareCheck ref="s0" checked={this.props.user_schedule.schedule.weekly_schedule_days[0].sprinting}
                                             id="s0" change={ this.sprintingDayChanged } label="Sunday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="s1" checked={this.props.user_schedule.schedule.weekly_schedule_days[1].sprinting}
                                             id="s1" change={ this.sprintingDayChanged } label="Monday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="s2" checked={this.props.user_schedule.schedule.weekly_schedule_days[2].sprinting}
                                             id="s2" change={ this.sprintingDayChanged } label="Tuesday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="s3" checked={this.props.user_schedule.schedule.weekly_schedule_days[3].sprinting}
                                             id="s3" change={ this.sprintingDayChanged } label="Wednesday" />
                            </div>
                            <div className="col-xs-2 ">
                                <SquareCheck ref="s4" checked={this.props.user_schedule.schedule.weekly_schedule_days[4].sprinting}
                                             id="s4" change={ this.sprintingDayChanged } label="Thursday" />
                            </div>
                            <div className="col-xs-2 ">
                                <SquareCheck ref="s5" checked={this.props.user_schedule.schedule.weekly_schedule_days[5].sprinting}
                                             id="s5" change={ this.sprintingDayChanged } label="Friday" />
                            </div>
                            <div className="col-xs-2 ">
                                <SquareCheck ref="s6" checked={this.props.user_schedule.schedule.weekly_schedule_days[6].sprinting}
                                             id="s6" change={ this.sprintingDayChanged } label="Saturday" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.state.errors.length > 0}>
                        <div className="row">
                            <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">

                            </div>
                        </div>
                    </If>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                            <Button ref="commitmentNext" buttonText="Continue" onClick={ this.submit }
                                    disabled={false} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-2 col-xs-offset-5 back-link text-center">
                            <span onClick={ () => this.props.previousPage('SCHEDULE') } className="small-link">Back</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Schedule;
