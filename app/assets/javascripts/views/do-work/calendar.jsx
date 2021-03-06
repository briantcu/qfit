import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import RoutineActions from 'actions/routine_actions';

require('views/do-work/calendar.scss');

class CalendarCell extends React.Component {
    constructor(props) {
        super(props);
        this.click = this.click.bind(this);
        this.state = {
            date: new Date(this.props.dayObj.year, this.props.dayObj.month - 1, this.props.dayObj.day_of_month)
        };
    }

    componentDidMount() {
        this.setState({date: new Date(this.props.dayObj.year, this.props.dayObj.month - 1, this.props.dayObj.day_of_month) });
    }

    componentWillReceiveProps(nextProps) {
        this.setState({date: new Date(nextProps.dayObj.year, nextProps.dayObj.month - 1, nextProps.dayObj.day_of_month) });
    }

    click() {
        var url = '/workout/' + this.props.dayObj.year + '/' + this.props.dayObj.month + '/' + this.props.dayObj.day_of_month;
        browserHistory.push(url);
    }

    render() {
        var days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
        ];

       var classes = ((this.props.dayObj.day_of_month == this.props.day) && (this.props.dayObj.year == this.props.year) &&
       (this.props.dayObj.month == this.props.month)) ? "col-xs-3 col-sm-2 col-md-2 calendar-cell selected" : "col-xs-3 col-sm-2 col-md-2  calendar-cell";

        classes += (this.state.date.getMonth()) ? '' : ' no-cursor';

        classes += (this.props.hiddenSm ? ' hidden-sm' : '');
        classes += (this.props.hiddenXs ? ' hidden-xs' : '');
        classes += (this.props.offsetSm ? ' col-sm-offset-1 col-md-offset-0' : '');

        if (this.props.border) {
            classes += ' border'
        }
        return <div>
            <If condition={this.state.date.getMonth() || this.state.date.getMonth() === 0 }>
            {
                <div className={classes} onClick={ () => this.click() } >
                    <div className="cal-subtext">{days[this.props.dayObj.day_of_week]}</div>
                    <div className="cal-text">{monthNames[this.state.date.getMonth()] + ', ' + this.props.dayObj.day_of_month}</div>
                    <div className="cal-subtext cal-day">{this.props.dayObj.workout_status}</div>
                </div>
            }
            </If>
            <If condition={!this.state.date.getMonth() && this.state.date.getMonth() !== 0 } >
                {
                    <div className={classes} >
                        <div className="cal-subtext"></div>
                        <div className="cal-text"></div>
                        <div className="cal-subtext"></div>
                    </div>
                }
            </If>
        </div>
    }
}

class Calendar extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            loaded: false,
            daysToShow: [],
            leftArrowEnabled: true,
            rightArrowEnabled: true
        };
        this.rowSize = 5;
        this.scrollRightAmount = 5;
        this.scrollLeftAmount = 5;
    }

    componentWillReceiveProps(nextProps) {
        this.getRowToShow(nextProps);
    }

    getRowToShow(props) {
        var daysToShow = [];
        var index = props.day - 1;
        if (props.calendar && props.calendar.attributes &&
            props.prev_calendar && props.prev_calendar.attributes &&
            props.next_calendar && props.next_calendar.attributes && !this.state.loaded) {
            var days = _.filter(props.calendar.attributes.calendar_month.days, function(day) {return day.day_of_month != 0; });
            var prevDays = _.filter(props.prev_calendar.attributes.calendar_month.days, function(day) {return day.day_of_month != 0; });
            var nextDays = _.filter(props.next_calendar.attributes.calendar_month.days, function(day) {return day.day_of_month != 0; });

            index += prevDays.length;
            var allDays = prevDays.concat(days).concat(nextDays);
            daysToShow = allDays.slice(index - 1, index + this.rowSize - 1);
            this.setState({loaded: true, daysToShow: daysToShow, current_index: index, allDays: allDays});
        }
    }

    getFlowAmount() {
        this.scrollRightAmount = 5;
        this.scrollLeftAmount = 5;
        if ($(window).width() < 992 ) {
            this.scrollRightAmount = 4;
            this.scrollLeftAmount = 4;
        }

        if ($(window).width() < 769 ) {
            this.scrollRightAmount = 3;
            this.scrollLeftAmount = 3;
        }
    }


    flowLeft() {
        this.getFlowAmount();
        if (this.state.leftArrowEnabled) {
            var index = this.state.current_index - (this.scrollLeftAmount);
            var leftArrowEnabled = index > 0;
            if (index <= 0) {
                var newIndex = index + this.scrollLeftAmount - 1;
                var daysToShow = this.state.allDays.slice(0, newIndex);
                var padCount = Math.abs(index) + 1;
                for (var i = 0; i < padCount; i++) {
                    daysToShow.unshift({day_of_month: "padday" + i, month: "paddmonth" + i});
                }
            } else {
                var daysToShow = this.state.allDays.slice(index - 1, index + this.rowSize - 1);
            }
            this.setState({
                daysToShow: daysToShow,
                current_index: index,
                leftArrowEnabled: leftArrowEnabled,
                rightArrowEnabled: true
            });
        }
    }

    flowRight() {
        this.getFlowAmount();
        if (this.state.rightArrowEnabled) {
            var index = this.state.current_index + (this.scrollRightAmount);
            var rightArrowEnabled = ((index + this.scrollRightAmount) < this.state.allDays.length);
            var daysToShow = this.state.allDays.slice(index - 1, index + this.rowSize - 1);
            this.setState({
                daysToShow: daysToShow,
                current_index: index,
                rightArrowEnabled: rightArrowEnabled,
                leftArrowEnabled: true
            });
        }
    }

    render() {
        var leftArrowClasses = this.state.leftArrowEnabled ? "left-arr col-xs-1" : "left-arr col-xs-1 disabled";
        var rightArrowClasses = this.state.rightArrowEnabled ? "right-arr col-xs-1" : "right-arr col-xs-1 disabled";
        return <div className="row calendar no-margin">
            <div className="cal-container">

                <div className="row cal-days">
                    <span className={leftArrowClasses} onClick={ () => this.flowLeft() } />
                    {
                        this.state.daysToShow.map(function(e, index) {
                            return <CalendarCell
                                {...this.props}
                                dayObj={e}
                                dayMonth={e.month}
                                key={e.day_of_month + '' + e.month}
                                border={index != 0}
                                hiddenSm={index > 3}
                                hiddenXs={index > 2}
                                offsetSm={index == 0}
                            />
                        }.bind(this))
                    }
                    <span className={rightArrowClasses} onClick={ () => this.flowRight() } />
                 </div>
            </div>
        </div>
    }
}

export default Calendar;