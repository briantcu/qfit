import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import RoutineStore from 'stores/routine_store';
import UserStore from 'stores/user_store';
import RoutineActions from 'actions/routine_actions';
import UserActions from 'actions/user_actions';
import Header from 'views/common/header';
import Calendar from 'views/do-work/calendar';
import Stretch from 'views/do-work/stretch';
import Strength from 'views/do-work/strength';
import Plyo from 'views/do-work/plyo';
import Sprint from 'views/do-work/sprint';
import C from 'constants/routine_constants';

require('pages/do_work.scss');

class DoWork extends React.Component {
    constructor(props) {
        super(props);
        var year, month, day;
        var urlArray = location.pathname.split('/');
        var today;
        if (urlArray.length > 2) {
            today = new Date(this.props.params.year, this.props.params.month - 1, this.props.params.day);
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
        lastMonth.setMonth(lastMonth.getMonth() - 1);
        var nextMonth = new Date(this.state.date.getTime());
        nextMonth.setMonth(nextMonth.getMonth() + 1);
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
                <div className="container">
                    <div className="row">
                        <div className="col-xs-10 col-xs-offset-1 text-center">
                            <span>Complete this Workout</span>
                            <span>Skip this Workout</span>
                            <span>Change Schedule</span>
                            <span>Change Program</span>
                            <span>Share Workout</span>
                        </div>
                    </div>
                </div>
            </div>

            <div className="row main">
                <div className="container">
                    <div className={this.state.loading ? 'loading row' : 'row'}>

                        <div className="stretching sec container">
                            <div className="row">
                                <div className="col-xs-12 sec-header">Stretching/Warmup</div>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.state.routine && this.state.routine.performed_warm_ups && this.state.routine.performed_warm_ups.length > 0}>
                                        {
                                            this.state.routine.performed_warm_ups.map(function(e, index) {
                                                return <Stretch {...this.props} exercise={e} key={e.id} />
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.state.loading} >
                                        <span>No Stretching</span>
                                    </When>
                                    <Otherwise><span></span></Otherwise>
                                </Choose>
                            </div>
                        </div>

                        <div className="strength sec container">
                            <div className="row">
                                <div className="col-xs-12 sec-header">Strength Training</div>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.state.routine && this.state.routine.performed_exercises && this.state.routine.performed_exercises.length > 0}>
                                        {
                                            this.state.routine.performed_exercises.map(function(e, index) {
                                                return <Strength {...this.props} exercise={e} key={e.id} />
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.state.loading} >
                                        <span>No Strength</span>
                                    </When>
                                    <Otherwise><span></span></Otherwise>
                                </Choose>
                            </div>
                        </div>

                        <div className="plyos sec container">
                            <div className="row">
                                <div className="col-xs-12 sec-header">Plyometrics</div>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.state.routine && this.state.routine.performed_plyometrics && this.state.routine.performed_plyometrics.length > 0}>
                                        {
                                            this.state.routine.performed_plyometrics.map(function(e, index) {
                                                return <Plyo {...this.props} exercise={e} key={e.id} />
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.state.loading} >
                                        <span>No Plyos</span>
                                    </When>
                                    <Otherwise><span></span></Otherwise>
                                </Choose>
                            </div>
                        </div>

                        <div className="sprinting sec container">
                            <div className="row">
                                <div className="col-xs-12 sec-header">Sprinting</div>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.state.routine && this.state.routine.performed_sprints && this.state.routine.performed_sprints.length > 0}>
                                        {
                                            this.state.routine.performed_sprints.map(function(e, index) {
                                                return <Sprint {...this.props} exercise={e} key={e.id} />
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.state.loading} >
                                        <span>No sprinting</span>
                                    </When>
                                    <Otherwise><span></span></Otherwise>
                                </Choose>
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
