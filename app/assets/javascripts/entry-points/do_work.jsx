import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import RoutineStore from 'stores/routine_store';
import UserStore from 'stores/user_store';
import ExerciseStore from 'stores/exercise_store';
import RoutineActions from 'actions/routine_actions';
import UserActions from 'actions/user_actions';
import ExerciseActions from 'actions/exercise_actions';
import Header from 'views/common/header';
import Calendar from 'views/do-work/calendar';
import Stretch from 'views/do-work/stretch';
import Strength from 'views/do-work/strength';
import Plyo from 'views/do-work/plyo';
import Sprint from 'views/do-work/sprint';
import C from 'constants/routine_constants';
import MenuModal from 'views/do-work/menu_modal';
import Button from 'views/common/button';
import Comment from 'views/do-work/comment';

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
            routine: { comments: []},
            user: {},
            loading: true,
            date: today,
            exercises: {},
            showAddEx: false,
            exercise_type: undefined
        };
        this.onChange = this.onChange.bind(this);
        this.addEx = this.addEx.bind(this);
        this.closeAddEx = this.closeAddEx.bind(this);
    }

    componentDidMount () {
        RoutineStore.addChangeListener(this.onChange.bind(this));
        UserStore.addChangeListener(this.onChange);
        ExerciseStore.addChangeListener(this.onChange);
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
        ExerciseStore.removeChangeListener(this.onChange);
        RoutineStore.removeChangeListener(this.onChange.bind(this));
    }

    load() {
        UserActions.getUser(gon.current_user_id);
        ExerciseActions.getExercises();
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
        var exercises = ExerciseStore.getData();
        this.setState(
            {
                calendar: data.calendar,
                prev_calendar: data.prev_calendar,
                next_calendar: data.next_calendar,
                routine: data.routine,
                loading: data.loading,
                user: user.user,
                exercises: exercises
            }
        )
    }

    addEx(e) {
        RoutineActions.addExercise(this.state.routine.id, this.state.exercise_type, e);
        this.setState({showAddEx: false});
    }

    closeAddEx() {
        this.setState({showAddEx: false});
    }

    showAddEx(type) {
        this.setState({showAddEx: true, exercise_type: type});
    }

    submit() {

    }

    reset() {
        var r=confirm("Are you sure you want to reset this workout?");
        if (r==true) {
            RoutineActions.resetRoutine(this.state.routine.id);
        }
    }

    leaveComment() {
        var commentText = this.refs.leaveComment.value;
        if (commentText) {
            alert(commentText);
        }
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
                                <div className="col-xs-12 sec-header">Stretching/Warmup
                                    <span className="add-ex" onClick={ () => this.showAddEx('warmups')}>Add Exercise</span></div>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.state.routine && this.state.routine.performed_warm_ups && this.state.routine.performed_warm_ups.length > 0}>
                                        {
                                            this.state.routine.performed_warm_ups.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Stretch exercises={this.state.exercises} exercise={e} key={e.id} border={index != 0}/>
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.state.loading} >
                                        <span>No Stretching</span>
                                    </When>
                                </Choose>
                            </div>
                        </div>

                        <div className="strength sec container">
                            <div className="row">
                                <div className="col-xs-12 sec-header">Strength Training
                                    <span className="add-ex" onClick={ () => this.showAddEx('weights')}>Add Exercise</span>
                                </div>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.state.routine && this.state.routine.performed_exercises && this.state.routine.performed_exercises.length > 0}>
                                        {
                                            this.state.routine.performed_exercises.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Strength exercises={this.state.exercises} exercise={e} key={e.id} border={index != 0}/>
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.state.loading} >
                                        <span>No Strength</span>
                                    </When>
                                </Choose>
                            </div>
                        </div>

                        <div className="plyos sec container">
                            <div className="row">
                                <div className="col-xs-12 sec-header">Plyometrics
                                    <span className="add-ex" onClick={ () => this.showAddEx('plyos')}>Add Exercise</span>
                                </div>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.state.routine && this.state.routine.performed_plyometrics && this.state.routine.performed_plyometrics.length > 0}>
                                        {
                                            this.state.routine.performed_plyometrics.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Plyo exercises={this.state.exercises} exercise={e} key={e.id} border={index != 0}/>
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.state.loading} >
                                        <span>No Plyos</span>
                                    </When>
                                </Choose>
                            </div>
                        </div>

                        <div className="sprinting sec container">
                            <div className="row">
                                <div className="col-xs-12 sec-header">Sprinting
                                    <span className="add-ex" onClick={ () => this.showAddEx('sprinting')}>Add Exercise</span>
                                </div>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.state.routine && this.state.routine.performed_sprints && this.state.routine.performed_sprints.length > 0}>
                                        {
                                            this.state.routine.performed_sprints.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Sprint exercises={this.state.exercises} exercise={e} key={e.id} border={index != 0}/>
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.state.loading} >
                                        <span>No sprinting</span>
                                    </When>
                                </Choose>
                            </div>
                            <div className="row last-row">
                                <div className="col-xs-3">
                                    <input type="text" className="user-weight"/>
                                    <span className="standard-text white ">Your Weight (lbs)</span>
                                </div>
                                <div className="col-xs-6 col-xs-offset-3 text-right">
                                    <span className="reset-link" onClick={() => this.reset()}>Reset Workout</span>
                                    <Button ref="completeWorkout" buttonText="Complete Workout" onClick={ () => this.submit() }
                                            disabled={false} inverse={true}/>
                                </div>
                            </div>
                        </div>

                        <div className="comments sec container">
                            <div className="row">
                                <div className="col-xs-12 sec-header">Leave a comment</div>
                            </div>
                            <If condition={this.state.routine} >
                            {
                                this.state.routine.comments.map(function(e, index) {
                                    return <Comment comment={e} key={e.id} />
                                }.bind(this))
                            }
                            </If>
                            <div className="row comment-row">
                                <div className="col-xs-12">
                                    <textarea className="leave-comment" rows="10" cols="80"></textarea>
                                    <Button ref="leaveComment" buttonText="Submit" onClick={ () => this.leaveComment() }
                                            disabled={false} />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <MenuModal show={this.state.showAddEx} close={this.closeAddEx} click={this.addEx} exercises={this.state.exercises} type={this.state.exercise_type}/>
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
