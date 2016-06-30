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
        history.pushState({id: 'Do Work'}, '', url);
        RoutineActions.getRoutine(this.props.year, this.props.month, this.props.day.day_of_month, gon.current_user_id);
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
        if (props.calendar && props.calendar.attributes && !this.state.loaded) {
            var days = props.calendar.attributes.calendar_month.days;
            var day = props.day;
            _.each(days, function (elem, indx, list) {
                if (elem.day_of_month == day) {
                    index = indx;
                    return;
                }
            });
            daysToShow = days.slice(index, index + 5);
            this.setState({loaded: true, daysToShow: daysToShow});
        }
    }

    render() {
        return <div className="row calendar">
            <div className="container">
                <div className="row">
                    {
                        this.state.daysToShow.map(function(e, index) {
                            return <CalendarCell {...this.props} day={e} key={e.day_of_month + '' + this.props.month} />
                        }.bind(this))
                    }
                </div>
            </div>

        </div>
    }
}

export default Calendar;