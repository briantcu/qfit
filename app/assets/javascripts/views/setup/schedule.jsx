import {render} from 'react-dom';

import SquareCheck from 'views/common/square_check';

require('views/setup/schedule.scss');

class Schedule extends React.Component {
    constructor(props) {
        super(props);
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
                                The program you chose has {this.props.suggested_schedule.num_weight_days} lifting days.
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-2 col-xs-offset-1">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[0].weights}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[1].weights}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[2].weights}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[3].weights}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[4].weights}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[5].weights}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[6].weights}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.quads.plyos || this.props.user_schedule.plyos}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4 text-center">
                                Which days will you do plyometric exercises?<br/>
                                To meet your goals, we recommend at least {this.props.suggested_schedule.num_plyo_days} plyometric days.
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-2 col-xs-offset-1">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[0].plyometrics}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[1].plyometrics}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[2].plyometrics}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[3].plyometrics}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[4].plyometrics}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[5].plyometrics}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[6].plyometrics}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.quads.sprinting || this.props.user_schedule.sprinting}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4 text-center">
                                Which days will you sprint?<br/>
                                To meet your goals, we recommend at least {this.props.suggested_schedule.num_sprint_days} sprinting days.
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-2 col-xs-offset-1">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[0].sprinting}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[1].sprinting}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[2].sprinting}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[3].sprinting}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2 ">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[4].sprinting}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2 ">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[5].sprinting}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                            <div className="col-xs-2 ">
                                <SquareCheck ref="4" checked={this.props.user_schedule.schedule.weekly_schedule_days[6].sprinting}
                                             id="4" change={ this.frequencyChanged } label="4" />
                            </div>
                        </div>
                    </If>
                </div>
            </div>
        </div>
    }

}

export default Schedule;
