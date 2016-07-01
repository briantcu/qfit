import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import RoutineActions from 'actions/routine_actions';

require('views/do-work/calendar.scss');

class CalendarCell extends React.Component {
    constructor(props) {
        super(props);
        this.click = this.click.bind(this);
        this.state = {
            date: new Date(this.props.year, this.props.month - 1, this.props.day.day_of_month)
        };
    }

    click() {
        var url = '/do-work/' + this.props.year + '/' + this.props.month + '/' + this.props.day.day_of_month;
        browserHistory.push(url);
    }

    render() {
        var days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        var monthNames = ["Jan", "Feb", "March", "April", "May", "June",
            "July", "Aug", "Sep", "Oct", "Nov", "Dec"
        ];

        return <div className="col-xs-2 calendar-cell" onClick={ () => this.click() } >
            <div className="cal-subtext">{days[this.props.day.day_of_week]}</div>
            <div className="cal-text">{monthNames[this.state.date.getMonth()]}, {this.props.day.day_of_month}</div>
            <div className="cal-subtext">{this.props.day.workout_status}</div>
        </div>
    }
}

class Calendar extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            loaded: false,
            daysToShow: []
        }
    }

    componentWillReceiveProps(nextProps) {
        this.getRowToShow(nextProps);
    }

    getRowToShow(props) {
        var daysToShow = [];
        var index = 0;
        if (props.calendar && props.calendar.attributes &&
            props.prev_calendar && props.prev_calendar.attributes &&
            props.next_calendar && props.next_calendar.attributes &&!this.state.loaded) {
            var days = props.calendar.attributes.calendar_month.days;
            var day = props.day;
            _.each(days, function (elem, indx, list) {
                if (elem.day_of_month == day) {
                    index = indx;
                    return;
                }
            });
            var prevDays = _.filter(props.prev_calendar.attributes.calendar_month.days, function(day) {return day.day_of_month != 0; });
            var nextDays = _.filter(props.next_calendar.attributes.calendar_month.days, function(day) {return day.day_of_month != 0; });
            index += prevDays.length;
            var allDays = prevDays.concat(days).concat(nextDays);
            daysToShow = allDays.slice(index - 1, index + 5);
            this.setState({loaded: true, daysToShow: daysToShow, current_index: index, allDays: allDays});
        }
    }

    flowLeft() {
        var index = this.state.current_index - 6;
        var daysToShow = this.state.allDays.slice(index - 1, index + 5);
        this.setState({daysToShow: daysToShow, current_index: index});
    }

    flowRight() {
        var index = this.state.current_index + 6;
        var daysToShow = this.state.allDays.slice(index - 1, index + 5);
        this.setState({daysToShow: daysToShow, current_index: index});
    }

    render() {
        return <div className="row calendar">
            <div className="container">
                <span className="left" onClick={ () => this.flowLeft() }> left </span>
                    <div className="row">

                        {
                            this.state.daysToShow.map(function(e, index) {
                                return <CalendarCell {...this.props} day={e} key={e.day_of_month + '' + this.props.month} />
                            }.bind(this))
                        }

                    </div>
                <span className="right" onClick={ () => this.flowRight() }> right </span>
            </div>

        </div>
    }
}

export default Calendar;