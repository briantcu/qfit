import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import RoutineStore from 'stores/routine_store';
import UserStore from 'stores/user_store';
import RoutineActions from 'actions/routine_actions';
import UserActions from 'actions/user_actions';
import Header from 'views/common/header';
import Calendar from 'views/do-work/calendar';
import C from 'constants/routine_constants';

require('pages/do_work.scss');

class DoWork extends React.Component {
    constructor(props) {
        super(props);
        var year, month, day;
        var urlArray = location.pathname.split('/');
        var today;
        if (urlArray.length > 2) {
            today = new Date(this.props.params.year, this.props.params.month - 2, this.props.params.day);
            year = this.props.params.year;
            month = this.props.params.month;
            day = this.props.params.day;
        } else {
            today = new Date();
            year = today.getFullYear();
            month = today.getMonth() + 1;
            day = today.getDate();
        }
        this.state = {
            year: year,
            month: month,
            day: day,
            calendar: {},
            routine: {},
            user: {},
            loading: true,
            date: today
        };
        this.onChange = this.onChange.bind(this);
    }

    componentDidMount () {
        RoutineStore.addChangeListener(this.onChange.bind(this));
        UserStore.addChangeListener(this.onChange);
        this.load();
    }

    componentWillReceiveProps(nextProps) {
        var year = nextProps.params.year;
        var month = nextProps.params.month;
        var day = nextProps.params.day;
        this.setState({year: year, month: month, day: day});
        RoutineActions.getRoutine(year, month, day, gon.current_user_id);
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        RoutineStore.removeChangeListener(this.onChange.bind(this));
    }

    load() {
        UserActions.getUser(gon.current_user_id);
        var lastMonth = new Date(this.state.date.getTime());
        lastMonth.setMonth(lastMonth.getMonth());
        var nextMonth = new Date(this.state.date.getTime());
        nextMonth.setMonth(nextMonth.getMonth() + 2);
        RoutineActions.getCalendar(this.state.year, this.state.month, gon.current_user_id, C.CALENDAR);
        RoutineActions.getCalendar(lastMonth.getFullYear(), lastMonth.getMonth() + 1, gon.current_user_id, C.PREV_CALENDAR);
        RoutineActions.getCalendar(nextMonth.getFullYear(), nextMonth.getMonth() + 1, gon.current_user_id, C.NEXT_CALENDAR);
        RoutineActions.getRoutine(this.state.year, this.state.month, this.state.day, gon.current_user_id);
    }

    onChange () {
        var data = RoutineStore.getData();
        var user = UserStore.getData();
        this.setState(
            {
                calendar: data.calendar,
                prev_calendar: data.prev_calendar,
                next_calendar: data.next_calendar,
                routine: data.routine,
                loading: data.loading,
                user: user.user
            }
        )
    }

    render () {
        return <div className="do-work">
            <Header user={this.state.user} />
            <Calendar {...this.state} />
            <div className="row subnav">

            </div>
            <div className="row main">
                <div className="container">
                    <div className={this.state.loading ? 'loading row' : 'row'}>
                    <div className="stretching sec container">
                        <div className="row">
                            <div className="col-xs-12 sec-header">Stretching/Warmup</div>
                        </div>
                        <div className="row">
                            <div className="col-xs-12">ex one</div>
                        </div>
                        <div className="row">
                            <div className="col-xs-12">ex two</div>
                        </div>
                    </div>

                    <div className="strength sec container">
                        <div className="row">
                            <div className="col-xs-12 sec-header">Strength Training</div>
                        </div>
                    </div>

                    <div className="plyos sec container">
                        <div className="row">
                            <div className="col-xs-12 sec-header">Plyometrics</div>
                        </div>
                    </div>

                    <div className="sprinting sec container">
                        <div className="row">
                            <div className="col-xs-12 sec-header">Sprinting</div>
                        </div>
                    </div>

                    <div className="comments sec container">
                        <div className="row">
                            <div className="col-xs-12 sec-header">Comments</div>
                        </div>
                    </div>
                    </div>

                </div>
            </div>
        </div>;
    }
}

render((
    <Router history={browserHistory}>
        <Route path="/do-work" component={DoWork}>
            <Route path=":year/:month/:day" component={DoWork}/>
        </Route>
    </Router>
), document.getElementById('app'));
