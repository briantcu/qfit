import {render} from 'react-dom';

require('views/do-work/calendar.scss');

class CalendarCell extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <div className="col-xs-2 calendar-cell">
            <div className="cal-subtext">Monday</div>
            <div className="cal-text">April, 4th</div>
            <div className="cal-subtext">Workout</div>
        </div>
    }
}

class Calendar extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <div className="row calendar">
            <div className="container">
                <div className="row">
                    <CalendarCell />
                    <CalendarCell />
                    <CalendarCell />
                    <CalendarCell />
                    <CalendarCell />
                    <CalendarCell />
                </div>
            </div>

        </div>
    }
}

export default Calendar;