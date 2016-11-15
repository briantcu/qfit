import {render} from 'react-dom';

import SquareCheck from 'views/common/square_check';
import Button from 'views/common/button';
import UserActions from 'actions/user_actions';
import TeamActions from 'actions/team_actions';

require('views/setup/schedule.scss');

class Schedule extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            errors: [],
            loading: false,
            schedule: this.props.user_schedule.schedule,
            weights: this.props.user_schedule.weights,
            plyos: this.props.user_schedule.plyos,
            sprinting: this.props.user_schedule.sprinting
        };

        this.submit = this.submit.bind(this);
        this.changed = this.changed.bind(this);
    }

    componentWillReceiveProps (props) {
        this.setState({
            errors: [],
            schedule: props.user_schedule.schedule,
            weights: props.user_schedule.weights,
            plyos: props.user_schedule.plyos,
            sprinting: props.user_schedule.sprinting
        });
    }

    submit (button) {
        $('.qfButton').button('loading');
        this.setState({loading: true});
        var countWeightDays = 0;
        var countPlyoDays = 0;
        var countSprintDays = 0;
        var days = [];
        var errors = [];
        for (var i = 0; i < 7; i++) {
            var id;
            if (this.state.schedule.schedule_days) {
                id =  this.state.schedule.schedule_days[i].id
            }
            var checked = false;
            var day = {day: i, id: id};
            var wId = 'w' + i;
            var pId = 'p' + i;
            var sId = 's' + i;

            if (this.props.quads.strength || this.state.weights) {
                var w = this.refs[wId];
                checked = w.getValue();
                if (checked){
                    countWeightDays++;
                    day["weights"] = true;
                } else {
                    day["weights"] = false;
                }

            } else {
                day["weights"] = false;
            }

            if (this.props.quads.plyos || this.state.plyos) {
                var p = this.refs[pId];
                checked = p.getValue();
                if (checked){
                    countPlyoDays++;
                    day["plyometrics"] = true;
                } else {
                    day["plyometrics"] = false;
                }
            } else {
                day["plyometrics"] = false;
            }

            if (this.props.quads.sprinting || this.state.sprinting) {
                var s = this.refs[sId];
                checked = s.getValue();
                if (checked){
                    countSprintDays++;
                    day["sprinting"] = true;
                } else {
                    day["sprinting"] = false;
                }
            } else {
                day["sprinting"] = false;
            }

            day["stretching"] = !!(day.weights || day.plyometrics || day.sprinting);
            days.push(day);
        }
        if (this.props.quads.strength || this.state.weights) {
            if (countWeightDays != this.props.num_weights_days) {
                errors.push(`Please choose ${this.props.num_weights_days} strength training days`);
            }
        }

        if (this.props.quads.plyos || this.state.plyos) {
            if (countPlyoDays < this.props.num_plyos_days) {
                errors.push(`Please choose at least ${this.props.num_plyos_days} plyometric days`);
            }
        }

        if (this.props.quads.sprinting || this.state.sprinting) {
            if (countSprintDays < this.props.num_sprint_days) {
                errors.push(`Please choose at least ${this.props.num_sprint_days} sprinting days`);
            }
        }

        if (errors.length > 0) {
            this.setState({errors: errors, loading: false});
            $('.qfButton').button('reset');
        } else {
            this.state.schedule.schedule_days = days;
            if (this.props.suggested_schedule.program_type) {
                this.state.schedule.program_type_id = this.props.suggested_schedule.program_type;
            }
            if (this.props.suggested_schedule.program_id) {
                this.state.schedule.program_id = this.props.suggested_schedule.program_id;
            }
            if (gon.viewing == 'user') {
                this.state.schedule.user_id = this.props.user.id;
                UserActions.setSchedule(this.state.schedule);
            } else {
                this.state.schedule.group_id = this.props.team.id;
                TeamActions.setSchedule(this.state.schedule);
            }
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
        this.state.schedule.schedule_days[day][key] = check.getValue();
    }

    render () {
        var errors = this.state.errors.map(function(error, i) {
            return (
                <div key={i}>{error}</div>
            );
        });
        return <div className="schedule metal-bg no-margin">
            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-10 col-xs-offset-1 text-center title">
                            Weekly Planner
                        </div>
                    </div>
                    <If condition={this.props.quads.strength || this.state.weights}>
                        <div className="row details">
                            <div className="col-xs-10 col-xs-offset-1 text-center">
                                <span className="question">Which days will you lift?</span><br/>
                                <span className="context">The program you chose has {this.props.num_weights_days} lifting days.</span>
                            </div>
                        </div>
                        <div className="row days">
                            <div className="col-xs-12 col-sm-12 col-md-10 col-md-offset-1 col-lg-12 col-lg-offset-0  text-center">
                                <SquareCheck ref="w0" checked={this.state.schedule.schedule_days[0].weights}
                                             id="w0" change={ this.changed } label="Sunday" />
                                <SquareCheck ref="w1" checked={this.state.schedule.schedule_days[1].weights}
                                             id="w1" change={ this.changed } label="Monday" />
                                <SquareCheck ref="w2" checked={this.state.schedule.schedule_days[2].weights}
                                             id="w2" change={ this.changed } label="Tuesday" />
                                <SquareCheck ref="w3" checked={this.state.schedule.schedule_days[3].weights}
                                             id="w3" change={ this.changed } label="Wednesday" />
                                <SquareCheck ref="w4" checked={this.state.schedule.schedule_days[4].weights}
                                             id="w4" change={ this.changed } label="Thursday" />
                                <SquareCheck ref="w5" checked={this.state.schedule.schedule_days[5].weights}
                                             id="w5" change={ this.changed } label="Friday" />
                                <SquareCheck ref="w6" checked={this.state.schedule.schedule_days[6].weights}
                                             id="w6" change={ this.changed } label="Saturday" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.quads.plyos || this.state.plyos}>
                        <div className="row details">
                            <div className="col-xs-10 col-xs-offset-1 text-center">
                                <span className="question">Which days will you do plyometric exercises?</span><br/>
                                <span className="context">To meet your goals, we recommend at least {this.props.num_plyos_days} plyometric days.</span>
                            </div>
                        </div>
                        <div className="row days">
                            <div className="col-xs-12 col-sm-12 col-md-10 col-md-offset-1 col-lg-12 col-lg-offset-0 text-center">
                                <SquareCheck ref="p0" checked={this.state.schedule.schedule_days[0].plyometrics}
                                             id="p0" change={ this.changed } label="Sunday" />
                                <SquareCheck ref="p1" checked={this.state.schedule.schedule_days[1].plyometrics}
                                             id="p1" change={ this.changed } label="Monday" />
                                <SquareCheck ref="p2" checked={this.state.schedule.schedule_days[2].plyometrics}
                                             id="p2" change={ this.changed } label="Tuesday" />
                                <SquareCheck ref="p3" checked={this.state.schedule.schedule_days[3].plyometrics}
                                             id="p3" change={ this.changed } label="Wednesday" />
                                <SquareCheck ref="p4" checked={this.state.schedule.schedule_days[4].plyometrics}
                                             id="p4" change={ this.changed } label="Thursday" />
                                <SquareCheck ref="p5" checked={this.state.schedule.schedule_days[5].plyometrics}
                                             id="p5" change={ this.changed } label="Friday" />
                                <SquareCheck ref="p6" checked={this.state.schedule.schedule_days[6].plyometrics}
                                             id="p6" change={ this.changed } label="Saturday" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.quads.sprinting || this.state.sprinting}>
                        <div className="row details">
                            <div className="col-xs-10 col-xs-offset-1 text-center">
                                <span className="question">Which days will you sprint?</span><br/>
                                <span className="context">To meet your goals, we recommend at least {this.props.num_sprint_days} sprinting days.</span>
                            </div>
                        </div>
                        <div className="row days">
                            <div className="col-xs-12 col-sm-12 col-md-10 col-md-offset-1 col-lg-12 col-lg-offset-0 text-center">
                                <SquareCheck ref="s0" checked={this.state.schedule.schedule_days[0].sprinting}
                                             id="s0" change={ this.changed } label="Sunday" />
                                <SquareCheck ref="s1" checked={this.state.schedule.schedule_days[1].sprinting}
                                             id="s1" change={ this.changed } label="Monday" />
                                <SquareCheck ref="s2" checked={this.state.schedule.schedule_days[2].sprinting}
                                             id="s2" change={ this.changed } label="Tuesday" />
                                <SquareCheck ref="s3" checked={this.state.schedule.schedule_days[3].sprinting}
                                             id="s3" change={ this.changed } label="Wednesday" />
                                <SquareCheck ref="s4" checked={this.state.schedule.schedule_days[4].sprinting}
                                             id="s4" change={ this.changed } label="Thursday" />
                                <SquareCheck ref="s5" checked={this.state.schedule.schedule_days[5].sprinting}
                                             id="s5" change={ this.changed } label="Friday" />
                                <SquareCheck ref="s6" checked={this.state.schedule.schedule_days[6].sprinting}
                                             id="s6" change={ this.changed } label="Saturday" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.state.errors.length > 0}>
                        <div className="row">
                            <div className="col-xs-10 col-xs-offset-1 text-center errors">
                                {errors}
                            </div>
                        </div>
                    </If>
                    <div className="row">
                        <div className="col-xs-10 col-xs-offset-1 text-center buttonRow">
                            <Button ref="next" buttonText="Continue" onClick={ this.submit }
                                    disabled={false} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-3 back-link text-center">
                            <span onClick={ () => this.props.previousPage('SCHEDULE') } className="small-link">Back</span>
                        </div>
                    </div>
                </div>
            </div>
            <If condition={this.state.loading} >
                <div className="loading-overlay"><img src="https://s3.amazonaws.com/quadfit/loading-ring-164.gif" /></div>
            </If>
        </div>
    }

}

export default Schedule;
