import {render} from 'react-dom';

require('views/do-work/calendar.scss');

class CalendarCell extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        var days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        return <div className="col-xs-2 calendar-cell">
            <div className="cal-subtext">{days[this.props.day.day_of_week]}</div>
            <div className="cal-text">{this.props.day.day_of_month}</div>
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
                            return <CalendarCell day={e} key={e.day_of_month}/>
                        })
                    }
                </div>
            </div>

        </div>
    }
}

export default Calendar;