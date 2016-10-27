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

require('pages/workout.scss');

class App extends React.Component {
    constructor(props) {
        super(props);
        var year, month, day;
        var today;
        var dateArray = gon.routine.day_performed.split('-');
        today = new Date(dateArray[0], dateArray[1] - 1, dateArray[2]);
        year = today.getFullYear();
        month = today.getMonth() + 1;
        day = today.getDate();

        this.state = {
            year: year,
            month: month,
            day: day,
            calendar: {},
            routine: gon.routine,
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
        this.evalBanner = this.evalBanner.bind(this);
        this.viewingUserBanner = this.viewingUserBanner.bind(this);
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

        UserActions.getFeed();
        UserActions.getPod();
    }

    onChange () {
        var team = TeamStore.getData();
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
                loggedInUser: user.loggedInUser,
                user: user.user,
                exercises: exercises,
                feed: qpData.feed,
                quad_pod: qpData.pod,
                invites: qpData.invites,
                conversation: qpData.conversation,
                quad_pod_loading: qpData.loading,
                team: team.team,
                finishOnboarding: this.finishOnboarding,
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

    viewingUserBanner() {
        if (gon.is_coach) {
            return <div>
                <span className="col-xs-12 col-sm-offset-3 col-sm-6 text-center bold">Viewing workout for {this.state.user.first_name} {this.state.user.last_name}</span>
            </div>;
        } else {
            return <div>
                <span className="col-xs-12 col-sm-offset-3 col-sm-6 text-center bold">Viewing workout for {this.state.user.user_name}</span>
                <span className="col-xs-12 col-sm-3 text-right"><a className="link" href="/coach">View yours</a></span>
            </div>;
        }
    }

    render () {
        var active = location.pathname.split('/')[1];

        const childrenWithProps = React.Children.map(this.props.children,
            (child) => React.cloneElement(child, Object.assign({}, this.state))
        );

        return <div>
            <Header user={this.state.loggedInUser} showWorkoutNav={false} active={active} />
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
