import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import RoutineStore from 'stores/routine_store';
import UserStore from 'stores/user_store';
import ExerciseStore from 'stores/exercise_store';
import QuadPodStore from 'stores/quad_pod_store';
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
import QuadPod from 'views/quad-pod/quad-pod';
import Footer from 'views/common/footer';
import Progress from 'views/do-work/progress';
import TeamActions from 'actions/team_actions';
import TeamStore from 'stores/team_store';

require('pages/do_work.scss');

class App extends React.Component {
    constructor(props) {
        super(props);
        var year, month, day;
        var urlArray = location.pathname.split('/');
        var today;
        if (urlArray.length > 3) {
            today = new Date(this.props.params.year, this.props.params.month - 1, this.props.params.day);
            year = this.props.params.year;
            month = this.props.params.month;
            day = this.props.params.day;
        } else if (gon.routine) {
            var dateArray = gon.routine.day_performed.split('-');
            today = new Date(dateArray[0], dateArray[1] - 1, dateArray[2]);
            year = today.getFullYear();
            month = today.getMonth() + 1;
            day = today.getDate();
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
            routine: { comments: [], weight: undefined},
            user: {},
            loading: true,
            date: today,
            exercises: {},
            showAddEx: false,
            exercise_type: undefined,
            invites: {},
            conversation: {}
        };
        this.onChange = this.onChange.bind(this);
    }

    componentWillReceiveProps(nextProps) {
        //@TODO need to handle this so that if you're on a particular workout, go to progress, and come back, you
        //see the same workout
        var year, month, day;
        year = nextProps.params.year;
        if (year) {
            month = nextProps.params.month;
            day = nextProps.params.day;
        } else {
            var today = new Date();
            year = today.getFullYear();
            month = today.getMonth() + 1;
            day = today.getDate();
        }
        this.setState({year: year, month: month, day: day});
        RoutineActions.getRoutine(year, month, day, gon.current_user_id);
    }

    componentDidMount () {
        RoutineStore.addChangeListener(this.onChange.bind(this));
        UserStore.addChangeListener(this.onChange);
        TeamStore.addChangeListener(this.onChange);
        ExerciseStore.addChangeListener(this.onChange);
        QuadPodStore.addChangeListener(this.onChange);
        this.load();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        TeamStore.removeChangeListener(this.onChange);
        ExerciseStore.removeChangeListener(this.onChange);
        RoutineStore.removeChangeListener(this.onChange.bind(this));
        QuadPodStore.removeChangeListener(this.onChange.bind(this));
    }

    load() {
        UserActions.getUser(gon.current_user_id);
        if (gon.viewing == 'team') {
            TeamActions.getTeam(gon.team_id);
        }
        if (gon.viewing == 'user') {
            var id = gon.current_user_id;
        } else {
            var id = gon.team_id;
        }

        ExerciseActions.getExercises();

        var lastMonth = new Date(this.state.date.getTime());
        lastMonth.setMonth(lastMonth.getMonth() - 1);
        var nextMonth = new Date(this.state.date.getTime());
        nextMonth.setMonth(nextMonth.getMonth() + 1);

        RoutineActions.getCalendar(this.state.year, this.state.month, id, C.CALENDAR, (gon.viewing == 'user'));
        RoutineActions.getCalendar(lastMonth.getFullYear(), lastMonth.getMonth() + 1, id, C.PREV_CALENDAR, (gon.viewing == 'user'));
        RoutineActions.getCalendar(nextMonth.getFullYear(), nextMonth.getMonth() + 1, id, C.NEXT_CALENDAR, (gon.viewing == 'user'));
        if (gon.routine) {
            RoutineActions.getById(gon.routine.id);
        } else {
            RoutineActions.getRoutine(this.state.year, this.state.month, this.state.day, id);
        }

        UserActions.getFeed();
        UserActions.getPod();
    }

    onChange () {
        var data = RoutineStore.getData();
        data.routine = data.routine || this.state.routine;
        var user = UserStore.getData();
        var exercises = ExerciseStore.getData();
        var qpData = QuadPodStore.getData();
        this.setState(
            {
                calendar: data.calendar,
                prev_calendar: data.prev_calendar,
                next_calendar: data.next_calendar,
                routine: data.routine,
                loading: data.loading,
                user: user.user,
                exercises: exercises,
                feed: qpData.feed,
                quad_pod: qpData.pod,
                invites: qpData.invites,
                conversation: qpData.conversation
            }
        );
    }

    render () {
        var active = location.pathname.split('/')[1];

        const childrenWithProps = React.Children.map(this.props.children,
            (child) => React.cloneElement(child, Object.assign({}, this.state))
        );

        return <div>
            <Header user={this.state.user} showWorkoutNav={true} active={active} />
            {childrenWithProps}
            <Footer />
        </div>
    }
}

class DoWork extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            showAddEx: false
        };
        this.addEx = this.addEx.bind(this);
        this.closeAddEx = this.closeAddEx.bind(this);
        this.weightChanged = this.weightChanged.bind(this);
    }

    weightChanged() {
        //@TODO set weight on the model, not directly. Use actions.
        this.state.routine.weight = this.refs.userWeight.value;
    }

    addEx(e) {
        RoutineActions.addExercise(this.props.routine.id, this.state.exercise_type, e);
        this.setState({showAddEx: false});
    }

    closeAddEx() {
        this.setState({showAddEx: false});
    }

    showAddEx(type) {
        this.setState({showAddEx: true, exercise_type: type});
    }

    submit() {
        var userWeight = this.refs.userWeight.value;
        if ((!userWeight) || isNaN(userWeight)) {
            alert('enter a valid weight!');
        } else {
            //@TODO disable submit button, handle user weight
            this.state.routine.weight = userWeight;
            RoutineActions.completeWorkout(this.props.routine);
        }
    }

    reset() {
        var r=confirm("Are you sure you want to reset this workout?");
        if (r==true) {
            RoutineActions.resetRoutine(this.props.routine.id);
        }
    }

    leaveComment() {
        var commentText = this.refs.commentBox.value;
        if (commentText) {
            RoutineActions.postComment(this.props.routine.id, commentText);
        }
    }

    render () {
        return <div className="do-work">
            <Calendar {...this.props} />

            <div className="row subnav">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-10 col-xs-offset-1 text-center">
                            <If condition={gon.viewing != 'team'} >
                                <span onClick={ () => this.submit()} >Complete this Workout</span>
                            </If>
                            <span>Change Schedule</span>
                            <span>Change Program</span>
                            <span>Share Workout</span>
                        </div>
                    </div>
                </div>

            </div>

            <div className="row main">
                <div className="container">
                    <div className={this.props.loading ? 'loading row' : 'row'}>

                        <div className="stretching sec container">
                            <div className="row">
                                <div className="col-xs-12 sec-header">Stretching/Warmup
                                    <span className="add-ex" onClick={ () => this.showAddEx('warmups')}>Add Exercise</span></div>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.props.routine && this.props.routine.performed_warm_ups && this.props.routine.performed_warm_ups.length > 0}>
                                        {
                                            this.props.routine.performed_warm_ups.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Stretch exercises={this.props.exercises} exercise={e} key={e.id} border={index != 0}
                                                closed={this.props.routine.closed} />
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.props.loading} >
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
                                    <When condition={this.props.routine && this.props.routine.performed_exercises && this.props.routine.performed_exercises.length > 0}>
                                        {
                                            this.props.routine.performed_exercises.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Strength exercises={this.props.exercises} exercise={e} key={e.id} border={index != 0}
                                                                 closed={this.props.routine.closed} />
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.props.loading} >
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
                                    <When condition={this.props.routine && this.props.routine.performed_plyometrics && this.props.routine.performed_plyometrics.length > 0}>
                                        {
                                            this.props.routine.performed_plyometrics.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Plyo exercises={this.props.exercises} exercise={e} key={e.id} border={index != 0}
                                                             closed={this.props.routine.closed} />
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.props.loading} >
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
                                    <When condition={this.props.routine && this.props.routine.performed_sprints && this.props.routine.performed_sprints.length > 0}>
                                        {
                                            this.props.routine.performed_sprints.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Sprint exercises={this.props.exercises} exercise={e} key={e.id} border={index != 0}
                                                               closed={this.props.routine.closed} />
                                            }.bind(this))
                                        }
                                    </When>
                                    <When condition={!this.props.loading} >
                                        <span>No sprinting</span>
                                    </When>
                                </Choose>
                            </div>
                            <div className="row last-row">
                                <div className="col-xs-3">
                                    <If condition={this.props.routine.id && gon.viewing == 'user'} >
                                        <input ref="userWeight" type="text" className="user-weight" value={this.props.routine.weight} onChange={this.weightChanged}/>
                                        <span className="standard-text white ">Your Weight (lbs)</span>
                                    </If>
                                </div>
                                <div className="col-xs-6 col-xs-offset-3 text-right">
                                    <span className="reset-link" onClick={() => this.reset()}>Reset Workout</span>
                                    <If condition={this.props.routine.id && gon.viewing == 'user'} >
                                        <Button ref="completeWorkout" buttonText="Complete Workout" onClick={ () => this.submit() }
                                            disabled={false} inverse={true}/>
                                    </If>
                                </div>
                            </div>
                        </div>
                        <If condition={this.props.routine.id && gon.viewing == 'user'} >
                            <div className="comments sec container">
                                <div className="row">
                                    <div className="col-xs-12 sec-header">Leave a comment</div>
                                </div>
                                {
                                    this.props.routine.comments.map(function(e, index) {
                                        return <Comment comment={e} key={e.id} />
                                    }.bind(this))
                                }
                                <div className="row comment-row">
                                    <div className="col-xs-6 text-right">
                                        <textarea ref="commentBox" className="leave-comment" rows="10" cols="80"></textarea>
                                        <Button ref="leaveComment" buttonText="Submit" onClick={ () => this.leaveComment() }
                                                disabled={false} />
                                    </div>
                                </div>
                            </div>
                        </If>
                    </div>
                </div>
            </div>
            <MenuModal show={this.state.showAddEx} close={this.closeAddEx} click={this.addEx} exercises={this.props.exercises} type={this.state.exercise_type}/>
        </div>;
    }
}

render((
    <Router history={browserHistory}>
        <Route path="/" component={App}>
            <Route path="workout" component={DoWork}>
                <Route path=":year/:month/:day" component={DoWork}/>
                <Route path=":workout_id" component={DoWork}/>
            </Route>
            <Route path="quad-pod" component={QuadPod} />
            <Route path="progress" component={Progress} />
        </Route>
    </Router>
), document.getElementById('app'));
