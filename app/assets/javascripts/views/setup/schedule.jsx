import {render} from 'react-dom';

import SquareCheck from 'views/common/square_check';
import Button from 'views/common/button';
import UserActions from 'actions/user_actions';

require('views/setup/schedule.scss');

class Schedule extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            errors: [],
            schedule: this.props.user_schedule.schedule
        };

        this.submit = this.submit.bind(this);
        this.changed = this.changed.bind(this);
    }

    componentWillReceiveProps (props) {
        this.state = {
            errors: [],
            schedule: this.props.user_schedule.schedule
        };
    }

    submit () {
        var countWeightDays = 0;
        var countPlyoDays = 0;
        var countSprintDays = 0;
        var days = [];
        var errors = [];
        for (var i = 0; i < 7; i++) {
            var checked = false;
            var day = {day: i};
            var wId = 'w' + i;
            var pId = 'p' + i;
            var sId = 's' + i;
            var w = this.refs[wId];
            checked = w.getValue();
            if (checked){
                countWeightDays++;
                day["weights"] = true;
            } else {
                day["weights"] = false;
            }

            var p = this.refs[pId];
            checked = p.getValue();
            if (checked){
                countPlyoDays++;
                day["plyometrics"] = true;
            } else {
                day["plyometrics"] = false;
            }

            var s = this.refs[sId];
            checked = s.getValue();
            if (checked){
                countSprintDays++;
                day["sprinting"] = true;
            } else {
                day["sprinting"] = false;
            }
            day["stretching"] = (day.weights || day.plyometrics || day.sprinting);
            days.push(day);
        }
        if (countWeightDays != this.props.suggested_schedule.num_weight_days) {
            errors.push(`Please choose ${this.props.suggested_schedule.num_weight_days} strength training days`);
        }
        if (countPlyoDays < this.props.suggested_schedule.num_plyo_days) {
            errors.push(`Please choose at least ${this.props.suggested_schedule.num_plyo_days} plyometric days`);
        }
        if (countSprintDays < this.props.suggested_schedule.num_sprint_days) {
            errors.push(`Please choose at least ${this.props.suggested_schedule.num_sprint_days} sprinting days`);
        }
        if (errors.length > 0) {
            this.setState({errors: errors});
        } else {
            this.state.schedule.weekly_schedule_days = days;
            this.state.schedule.user_id = this.props.user.id;
            this.state.schedule.program_type_id = this.props.suggested_schedule.program_type;
            this.state.schedule.program_id = this.props.suggested_schedule.program_id;
            UserActions.setSchedule((this.state.schedule));
        }
    }

    changed (e) {
        var check = this.refs[e.props.id];
        var day = Number(check.props.id.charAt(1));
        var quad = check.props.id.charAt(0);
        var key = 'sprinting';
        if (quad == 'w') {
            key = 'weights';
        } else if (quad == 'p') {
            key = 'plyometrics';
        }
        this.state.schedule.weekly_schedule_days[day][key] = check.getValue();
    }

    render () {
        var errors = this.state.errors.map(function(error) {
            return (
                <div>{error}</div>
            );
        });
        return <div className="schedule">
            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4 text-center">
                            Weekly Planner
                        </div>
                    </div>
                    <If condition={this.props.quads.strength || this.state.schedule.weights}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4 text-center">
                                Which days will you lift?<br/>
                                The program you chose has {this.props.suggested_schedule.num_weight_days} lifting days.
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-2 col-xs-offset-1">
                                <SquareCheck ref="w0" checked={this.state.schedule.weekly_schedule_days[0].weights}
                                             id="w0" change={ this.changed } label="Sunday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w1" checked={this.state.schedule.weekly_schedule_days[1].weights}
                                             id="w1" change={ this.changed } label="Monday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w2" checked={this.state.schedule.weekly_schedule_days[2].weights}
                                             id="w2" change={ this.changed } label="Tuesday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w3" checked={this.state.schedule.weekly_schedule_days[3].weights}
                                             id="w3" change={ this.changed } label="Wednesday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w4" checked={this.state.schedule.weekly_schedule_days[4].weights}
                                             id="w4" change={ this.changed } label="Thursday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w5" checked={this.state.schedule.weekly_schedule_days[5].weights}
                                             id="w5" change={ this.changed } label="Friday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="w6" checked={this.state.schedule.weekly_schedule_days[6].weights}
                                             id="w6" change={ this.changed } label="Saturday" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.quads.plyos || this.state.schedule.plyos}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4 text-center">
                                Which days will you do plyometric exercises?<br/>
                                To meet your goals, we recommend at least {this.props.suggested_schedule.num_plyo_days} plyometric days.
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-2 col-xs-offset-1">
                                <SquareCheck ref="p0" checked={this.state.schedule.weekly_schedule_days[0].plyometrics}
                                             id="p0" change={ this.changed } label="Sunday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p1" checked={this.state.schedule.weekly_schedule_days[1].plyometrics}
                                             id="p1" change={ this.changed } label="Monday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p2" checked={this.state.schedule.weekly_schedule_days[2].plyometrics}
                                             id="p2" change={ this.changed } label="Tuesday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p3" checked={this.state.schedule.weekly_schedule_days[3].plyometrics}
                                             id="p3" change={ this.changed } label="Wednesday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p4" checked={this.state.schedule.weekly_schedule_days[4].plyometrics}
                                             id="p4" change={ this.changed } label="Thursday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p5" checked={this.state.schedule.weekly_schedule_days[5].plyometrics}
                                             id="p5" change={ this.changed } label="Friday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="p6" checked={this.state.schedule.weekly_schedule_days[6].plyometrics}
                                             id="p6" change={ this.changed } label="Saturday" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.quads.sprinting || this.state.schedule.sprinting}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4 text-center">
                                Which days will you sprint?<br/>
                                To meet your goals, we recommend at least {this.props.suggested_schedule.num_sprint_days} sprinting days.
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-2 col-xs-offset-1">
                                <SquareCheck ref="s0" checked={this.state.schedule.weekly_schedule_days[0].sprinting}
                                             id="s0" change={ this.changed } label="Sunday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="s1" checked={this.state.schedule.weekly_schedule_days[1].sprinting}
                                             id="s1" change={ this.changed } label="Monday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="s2" checked={this.state.schedule.weekly_schedule_days[2].sprinting}
                                             id="s2" change={ this.changed } label="Tuesday" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="s3" checked={this.state.schedule.weekly_schedule_days[3].sprinting}
                                             id="s3" change={ this.changed } label="Wednesday" />
                            </div>
                            <div className="col-xs-2 ">
                                <SquareCheck ref="s4" checked={this.state.schedule.weekly_schedule_days[4].sprinting}
                                             id="s4" change={ this.changed } label="Thursday" />
                            </div>
                            <div className="col-xs-2 ">
                                <SquareCheck ref="s5" checked={this.state.schedule.weekly_schedule_days[5].sprinting}
                                             id="s5" change={ this.changed } label="Friday" />
                            </div>
                            <div className="col-xs-2 ">
                                <SquareCheck ref="s6" checked={this.state.schedule.weekly_schedule_days[6].sprinting}
                                             id="s6" change={ this.changed } label="Saturday" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.state.errors.length > 0}>
                        <div className="row">
                            <div className="col-xs-6 col-xs-offset-3 text-center buttonRow">
                                {errors}
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
