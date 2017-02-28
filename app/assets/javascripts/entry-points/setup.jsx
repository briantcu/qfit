import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';

import Header from 'views/common/header';
import Subnav from 'views/setup/subnav';
import Goal from 'views/setup/goal';
import Quads from 'views/setup/quads';
import Fitness from 'views/setup/fitness';
import Schedule from 'views/setup/schedule';
import Program from 'views/setup/program';
import Commitment from 'views/setup/commitment';
import Coach from 'views/setup/coach';

import UserStore from 'stores/user_store';
import TeamStore from 'stores/team_store';
import TeamScheduleStore from 'stores/team_schedule_store';
import UserScheduleStore from 'stores/user_schedule_store';
import FitnessAssessmentStore from 'stores/fitness_assessment_store';
import ProgramStore from 'stores/program_store';
import UserActions from 'actions/user_actions';
import TeamActions from 'actions/team_actions';
import ProgramActions from 'actions/program_actions';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';

var C = require('constants/fitness_assessment_constants.js');

require('pages/setup.scss');

class App extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {},
            loggedInUser: {},
            goal: C.MASS,
            program: {},
            quads: {},
            user_schedule: {schedule: {}},
            suggested_schedule: {},
            isConfigured: false,
            navElements: [],
            num_weights_days: undefined,
            num_plyos_days: undefined,
            num_sprint_days: undefined
        };
        this.nextPage = this.nextPage.bind(this);
        this.onChange = this.onChange.bind(this);
        this.fitnessSubmitted = this.fitnessSubmitted.bind(this);
        this.fetchSuggestedSchedule = this.fetchSuggestedSchedule.bind(this);
        this.previousPage = this.previousPage.bind(this);
        this.defineRoutes = this.defineRoutes.bind(this);
    }

    nextPage(childView, skipProgram) {
        _.each(this.state.routes, function(route, index) {
            if (route.name == childView) {
                var nextRoute = this.state.routes[index + 1];
                if (nextRoute.name == 'Program' && skipProgram) {
                    nextRoute = this.state.routes[index + 2];
                }
                if (nextRoute.name == 'Commitment' && !FitnessAssessmentStore.getData().quads.strength) {
                    nextRoute = this.state.routes[index + 3]; //skip commitment/program if you're not doing strength
                }
                if (nextRoute.name == 'Schedule') {
                    this.fetchSuggestedSchedule();
                }
                browserHistory.push(nextRoute.route);
            }
        }.bind(this));
        $('html, body').animate({
            scrollTop: $(".subnav").offset().top
        }, 200);
    }

    previousPage() {
        browserHistory.goBack();
    }

    componentDidMount () {
        var userAgent = navigator.userAgent.toLowerCase();
        if (userAgent .indexOf('safari')!=-1){
            if(userAgent .indexOf('chrome')  > -1){
                //browser is chrome
            }else if((userAgent .indexOf('opera')  > -1)||(userAgent .indexOf('opr')  > -1)){
                //browser is opera
            }else{
                if (window.innerHeight <= document.body.clientHeight) {
                    $('html').css('height', 'auto');
                }
            }
        }

        UserStore.addChangeListener(this.onChange);
        if (gon.viewing == 'user') {
            if (gon.current_user_id != gon.user_id) {
                UserActions.getUser(gon.user_id, true);
                UserActions.getUser(gon.current_user_id);
            } else {
                UserActions.getUser(gon.current_user_id, true);
            }
            UserScheduleStore.addChangeListener(this.onChange);
        } else {
            UserActions.getUser(gon.user_id, true);
            TeamStore.addChangeListener(this.onChange);
            TeamScheduleStore.addChangeListener(this.onChange);
            TeamActions.getTeam(gon.team_id);
        }

        ProgramStore.addChangeListener(this.onChange);
        FitnessAssessmentStore.addChangeListener(this.onChange);
        this.defineRoutes(this.props.children.type.displayName);
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        TeamStore.removeChangeListener(this.onChange);
        TeamScheduleStore.removeChangeListener(this.onChange);
        UserScheduleStore.removeChangeListener(this.onChange);
        ProgramStore.removeChangeListener(this.onChange);
        FitnessAssessmentStore.removeChangeListener(this.onChange);
    }

    componentWillReceiveProps (nextProps) {
        this.defineRoutes(nextProps.children.type.displayName);
    }

    defineRoutes(currentView) {
        var navElements = [];
        var routes = [];

        if (this.props.children.type.displayName != 'Coach') {
            if (gon.setup_context == 'user' || gon.setup_context == 'coach_sub') {
                navElements.push({class: this.getNavClass(['Goal'], currentView), label: 'Goal'});
                routes.push({route: '/setup/goal', name: 'Goal'});
            }

            if (gon.setup_context && gon.setup_context != 'sub_user') {
                navElements.push({class: this.getNavClass(['Quads'], currentView), label: 'Quads'});
                routes.push({route: '/setup/quads', name: 'Quads'});
            }

            if ((gon.onboarding && gon.setup_context == 'user') || (gon.setup_context == 'sub_user')) {
                navElements.push({class: this.getNavClass(['Fitness'], currentView), label: 'Fitness Assessment'});
                routes.push({route: '/fitness', name: 'Fitness'});
            }

            if (gon.setup_context && gon.setup_context != 'sub_user') {
                navElements.push({class: this.getNavClass(['Program', 'Commitment', 'Schedule'], currentView), label: 'Schedule'});
                routes.push({route: '/commitment', name: 'Commitment'});
                routes.push({route: '/program', name: 'Program'});
                routes.push({route: '/schedule', name: 'Schedule'});
            }
        }

        this.setState({navElements: navElements, routes: routes});
    }

    getNavClass(names, currentView) {
        return (names.indexOf(currentView) > -1) ? 'bold-text' : '';
    }

    onChange () {
        var data = UserStore.getData();
        var schedule = UserScheduleStore.getData();
        var team = TeamStore.getData();
        var teamSchedule = TeamScheduleStore.getData();

        var fitness = FitnessAssessmentStore.getData();
        var program = ProgramStore.getData();
        if (gon.viewing == 'user') {
            var user_schedule = schedule;
        } else {
            var user_schedule = teamSchedule;
        }

        var numDays = this.getNumDays(user_schedule.schedule, program.suggested_schedule);
        this.setState({
            user: data.user,
            goal: fitness.goal,
            quads: fitness.quads,
            userWeight: fitness.userWeight,
            benchWeight: fitness.benchWeight,
            benchReps: fitness.benchReps,
            pushups: fitness.pushups,
            pullups: fitness.pullups,
            assistedPushups: fitness.assistedPushups,
            squatWeight: fitness.squatWeight,
            squatReps: fitness.squatReps,
            module: fitness.module,
            loggedInUser: data.loggedInUser,
            program: program,
            suggested_schedule: program.suggested_schedule,
            user_schedule: user_schedule,
            team: team.team,
            num_weights_days: numDays.num_weights_days,
            num_plyos_days: numDays.num_plyos_days,
            num_sprint_days: numDays.num_sprint_days,
            experienceLevel: fitness.experienceLevel
        });
        if (fitness.complete) {
            FitnessAssessmentActions.submit(fitness, data.user, this.fitnessSubmitted);
        }
    }

    getNumDays(schedule, suggested_schedule) {
        var numDays = {};
        numDays.num_weights_days = (suggested_schedule.num_weight_days >= 0) ?
            suggested_schedule.num_weight_days : schedule.weightsCount;
        numDays.num_plyos_days = (suggested_schedule.num_plyo_days >= 0) ?
            suggested_schedule.num_plyo_days : schedule.plyosCount;
        numDays.num_sprint_days = (suggested_schedule.num_sprint_days >= 0) ?
            suggested_schedule.num_sprint_days : schedule.sprintsCount;
        return numDays;
    }

    fetchSuggestedSchedule() {
        var fitness = FitnessAssessmentStore.getData();
        var program = ProgramStore.getData();
        if (gon.viewing == 'user') {
            var schedule = UserScheduleStore.getData();
            if (program.strengthProgram) {
                var strengthProgram = program.strengthProgram;
            } else {
                var strengthProgram = schedule.schedule.program_id;
            }
            if (!fitness.goal) {
                var goal = schedule.schedule.program_type_id;
            } else {
                var goal = fitness.goal;
            }
        } else {
            var schedule = TeamScheduleStore.getData();
            if (program.strengthProgram) {
                var strengthProgram = program.strengthProgram;
            } else {
                var strengthProgram = schedule.schedule.program_id;
            }
            var goal = fitness.goal;
        }
        ProgramActions.getSuggestedSchedule(goal, strengthProgram);
    }

    fitnessSubmitted() {
        if (FitnessAssessmentStore.getData().quads.strength) {
            browserHistory.push('/commitment');
        } else {
            this.fetchSuggestedSchedule();
            browserHistory.push('/schedule');
        }
    }

    render () {
        const childrenWithProps = React.Children.map(this.props.children,
            (child) => React.cloneElement(child, Object.assign({}, this.state, {
                next: this.nextPage,
                previousPage: this.previousPage
            }))
        );

        return <div className="hundo-height">
            <Header user={this.state.loggedInUser} hideAvatar={true}/>
            { this.props.children.type.displayName !== 'Coach'
                ?
                <Subnav elements={this.state.navElements}/>
                :
                null
            }
            {childrenWithProps}
        </div>
    }
}

const trackPage = () => {
    analytics.page(location.pathname);
};

render((
    <Router history={browserHistory} onUpdate={trackPage}>
        <Route path="/" component={App}>
            <Route path="setup" >
                <Route path="coach" component={Coach} />
                <Route path="goal" component={Goal} />
                <Route path="quads" component={Quads} />
            </Route>
            <Route path="fitness" component={Fitness} />
            <Route path="commitment" component={Commitment} />
            <Route path="program" component={Program} />
            <Route path="schedule" component={Schedule} />
        </Route>
    </Router>
), document.getElementById('app'));