import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import RoutineStore from 'stores/routine_store';
import UserStore from 'stores/user_store';
import UserScheduleStore from 'stores/user_schedule_store';
import ExerciseStore from 'stores/exercise_store';
import QuadPodStore from 'stores/quad_pod_store';
import RoutineActions from 'actions/routine_actions';
import UserActions from 'actions/user_actions';
import ExerciseActions from 'actions/exercise_actions';
import Header from 'views/common/header';
import Calendar from 'views/do-work/calendar';
import C from 'constants/routine_constants';
import MenuModal from 'views/do-work/menu_modal';
import Button from 'views/common/button';
import Comment from 'views/do-work/comment';
import QuadPod from 'views/quad-pod/quad-pod';
import Footer from 'views/common/footer';
import Progress from 'views/do-work/progress';
import TeamActions from 'actions/team_actions';
import TeamStore from 'stores/team_store';
import { Modal } from 'react-bootstrap';
import CoachActions from 'actions/coach_actions';
import validator from 'validator';
import DoWork from 'views/do-work/do-work';
import moment from 'moment';

require('pages/workout.scss');

class App extends React.Component {
    constructor(props) {
        super(props);
        var year, month, day;
        var urlArray = location.pathname.split('/');
        var today;
        if (urlArray.length > 3) {
            today = new Date(this.props.params.year, this.props.params.month - 1, this.props.params.day);
        } else if (gon.routine) {
            var dateArray = gon.routine.day_performed.split('-');
            today = new Date(dateArray[0], dateArray[1] - 1, dateArray[2]);

        } else {
            today = new Date();
        }
        year = today.getFullYear();
        month = today.getMonth() + 1;
        day = today.getDate();
        this.state = {
            year: year,
            month: month,
            day: day,
            day_index: today.getDay(),
            calendar: {},
            routine: { comments: [], weight: undefined, messages: []},
            user: {},
            loggedInUser: {},
            loading: true,
            date: today,
            exercises: {},
            showAddEx: false,
            exercise_type: undefined,
            invites: {},
            conversation: {},
            showBanner: false,
            context: gon.setup_context
        };
        this.onChange = this.onChange.bind(this);
        this.finishOnboarding = this.finishOnboarding.bind(this);
        this.inviteSent = this.inviteSent.bind(this);
        this.teamSaved = this.teamSaved.bind(this);
        this.showSuccess = this.showSuccess.bind(this);
        this.evalBanner = this.evalBanner.bind(this);
        this.viewingTeamBanner = this.viewingTeamBanner.bind(this);
        this.viewingUserBanner = this.viewingUserBanner.bind(this);
        this.loadCalendar = this.loadCalendar.bind(this);
        this.submitWorkout = this.submitWorkout.bind(this);
        this.getEntityId = this.getEntityId.bind(this);
        this.loadRoutine = this.loadRoutine.bind(this);
        this.updateCal = this.updateCal.bind(this);
    }

    submitWorkout(routine) {
        RoutineActions.completeWorkout(routine, this.updateCal);
    }

    updateCal() {
        $('.calendar-cell.selected .cal-day').html('completed');
    }

    componentWillReceiveProps(nextProps) {
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
        if (gon.viewing == 'user') {
            var id = gon.current_user_id;
        } else {
            var id = gon.team_id;
        }
        RoutineActions.getRoutine(year, month, day, id);
    }

    componentDidMount () {
        var scrollFn = function() {
            var bannerRow = $(".banner-row");
            if ($(window).scrollTop() > 100) {
                bannerRow.addClass("fixed");
            } else {
                bannerRow.removeClass("fixed");
            }
        };
        var debounced = _.debounce(scrollFn, 5);

        window.addEventListener('scroll', debounced);
        RoutineStore.addChangeListener(this.onChange.bind(this));
        UserStore.addChangeListener(this.onChange);
        UserScheduleStore.addChangeListener(this.onChange);
        TeamStore.addChangeListener(this.onChange);
        ExerciseStore.addChangeListener(this.onChange);
        QuadPodStore.addChangeListener(this.onChange);
        this.load();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        UserScheduleStore.removeChangeListener(this.onChange);
        TeamStore.removeChangeListener(this.onChange);
        ExerciseStore.removeChangeListener(this.onChange);
        RoutineStore.removeChangeListener(this.onChange.bind(this));
        QuadPodStore.removeChangeListener(this.onChange.bind(this));
    }

    finishOnboarding(name_or_invite_info) {
        if (this.state.context == 'coach_team') {
            CoachActions.updateTeam(this.state.team.id, name_or_invite_info, this.teamSaved);
        }

        if (this.state.context == 'coach_sub') {
            CoachActions.sendInvite(name_or_invite_info, this.state.team.id, 'member', this.inviteSent);
        }
    }

    inviteSent(response) {
        if (response.status == 'success') {
            this.setState({showActionModal: false, bannerContent: this.showSuccess, showBanner: true, context: null});
        } else {
            this.setState({finishErrors: response.message});
        }
    }

    showSuccess() {
        //@TODO Provide more details about how these workouts will continue to get created. Send to deep dive page
        return <div className="col-xs-12">
            Invite sent! You'll be notified once they sign up, and they'll show up in the members section on the <a href="/coach">Coach page</a>.
            In the meantime, you can modify this workout, or head over
            to <a href="/coach">Coach</a> to send more invites or create some teams.
        </div>;
    }

    teamSaved() {
        this.setState({showActionModal: false, bannerContent: this.showTeamSuccess, showBanner: true});
    }

    showTeamSuccess() {
        return <div className="col-xs-12">
            Team created!
            You can modify this workout, or head over
            to <a href="/coach">Coach</a> to invite people to join your team on Quadfit. They'll get a version of this workout
            customized to their fitness level and the goals you set for them. They won't be able to modify this workout, so
            you'll be in complete control.
        </div>;
    }

    getEntityId() {
        if (gon.viewing == 'user') {
            var id = gon.current_user_id;
        } else {
            var id = gon.team_id;
        }
        return id;
    }

    load() {
        if (gon.current_user_id != gon.user_id) {
            UserActions.getUser(gon.user_id, true);
            UserActions.getUser(gon.current_user_id);
        } else {
            UserActions.getUser(gon.current_user_id, true);
        }
        if (gon.viewing == 'team') {
            TeamActions.getTeam(gon.team_id);
        }

        ExerciseActions.getExercises();

        this.loadCalendar();
        this.loadRoutine();

        UserActions.getFeed();
        UserActions.getPod();
        UserActions.getInvites();
    }

    loadRoutine() {
        var id = this.getEntityId();
        if (gon.routine) {
            RoutineActions.getById(gon.routine.id);
        } else {
            RoutineActions.getRoutine(this.state.year, this.state.month, this.state.day, id);
        }
    }

    loadCalendar() {
        var id = this.getEntityId();

        var lastMonth = new moment(this.state.date);
        lastMonth.subtract(1, 'month');
        var nextMonth = new moment(this.state.date);
        nextMonth.add(1, 'month');

        RoutineActions.getCalendar(this.state.year, this.state.month, id, C.CALENDAR, (gon.viewing == 'user'));
        RoutineActions.getCalendar(lastMonth.year(), lastMonth.month() + 1, id, C.PREV_CALENDAR, (gon.viewing == 'user'));
        RoutineActions.getCalendar(nextMonth.year(), nextMonth.month() + 1, id, C.NEXT_CALENDAR, (gon.viewing == 'user'));
    }

    onChange () {
        var team = TeamStore.getData();
        var showActionModal = (team.team.is_template && this.state.context);
        var data = RoutineStore.getData();
        data.routine = data.routine || this.state.routine;
        var user = UserStore.getData();
        var exercises = ExerciseStore.getData();
        var qpData = QuadPodStore.getData();
        var schedule = UserScheduleStore.getData();
        this.setState(
            {
                calendar: data.calendar,
                prev_calendar: data.prev_calendar,
                next_calendar: data.next_calendar,
                routine: data.routine,
                loading: data.loading,
                loggedInUser: user.loggedInUser,
                user: user.user,
                exercises: exercises,
                feed: qpData.feed,
                quad_pod: qpData.pod,
                invites: qpData.invites,
                conversation: qpData.conversation,
                quad_pod_loading: qpData.loading,
                team: team.team,
                showActionModal: showActionModal,
                invites_received: qpData.invites_received,
                finishOnboarding: this.finishOnboarding,
                submitWorkout: this.submitWorkout,
                week_days: schedule.week_days
            }
        );
        this.evalBanner();
    }

    evalBanner() {
        if (!this.state.showBanner) {
            if (this.shouldShowTeamBanner()) {
                this.setState({showBanner: true, bannerContent: this.viewingTeamBanner});
            } else if (this.shouldShowUserBanner()) {
                this.setState({showBanner: true, bannerContent: this.viewingUserBanner});
            }
        }
    }

    shouldShowTeamBanner() {
        return (gon.is_coach && gon.viewing == 'team' && this.state.team && this.state.team.name && !gon.onboarding);
    }

    shouldShowUserBanner() {
        if (gon.is_coach) {
            return (gon.viewing == 'user' && this.state.user && this.state.user.first_name);
        } else {
            return ((gon.user_id != gon.current_user_id) && this.state.user && this.state.user.first_name);
        }
    }

    viewingUserBanner() {
        if (gon.is_coach) {
            return <div>
                <span className="col-xs-12 col-sm-offset-3 col-sm-6 text-center bold">Viewing workout for {this.state.user.first_name} {this.state.user.last_name}</span>
            </div>;
        } else {
            return <div>
                <span className="col-xs-12 col-sm-offset-3 col-sm-6 text-center bold">Viewing workout for {this.state.user.user_name}</span>
                <span className="col-xs-12 col-sm-3 text-right"><a className="link" href="/workout">View yours</a></span>
            </div>;
        }
    }

    viewingTeamBanner() {
        return <div>
            <span className="col-xs-12 col-sm-offset-3 col-sm-6 text-center bold">Viewing workout for {this.state.team.name}</span>
        </div>;
    }

    render () {
        var active = location.pathname.split('/')[1];

        const childrenWithProps = React.Children.map(this.props.children,
            (child) => React.cloneElement(child, Object.assign({}, this.state))
        );

        return <div>
            <Header user={this.state.loggedInUser} showWorkoutNav={true} active={active} />
            <If condition={this.state.showBanner} >
                <div className="row banner-row">
                    <div className="container">
                        <div className="row">
                            {this.state.bannerContent()}
                        </div>
                    </div>
                </div>
            </If>
            {childrenWithProps}
            <Footer />
        </div>
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
