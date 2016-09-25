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
import UserScheduleStore from 'stores/user_schedule_store';
import FitnessAssessmentStore from 'stores/fitness_assessment_store';
import ProgramStore from 'stores/program_store';
import UserActions from 'actions/user_actions';
import ProgramActions from 'actions/program_actions';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';

var C = require('constants/fitness_assessment_constants.js');

require('pages/setup.scss');

class App extends React.Component {
    constructor(props) {
        super(props);
        var url = window.location.pathname;
        var activeNav = 'setup';
        if (url == '/schedule') {
            activeNav = 'schedule';
        }

        this.state = {
            user: {},
            goal: C.MASS,
            program: {},
            quads: {},
            activeNav: activeNav,
            user_schedule: {schedule: {}},
            suggested_schedule: {},
            isConfigured: false,
            navElements: []
        };
        this.nextPage = this.nextPage.bind(this);
        this.onChange = this.onChange.bind(this);
        this.fitnessSubmitted = this.fitnessSubmitted.bind(this);
        this.fetchSuggestedSchedule = this.fetchSuggestedSchedule.bind(this);
        this.previousPage = this.previousPage.bind(this);
        this.configure = this.configure.bind(this);
    }

    nextPage(childView, additionalData) {
        //Sees which child view called, evaluates the state, and calls to route to the next page
        if (childView == "GOAL") {
            browserHistory.push('/setup/quads');
        } else if (childView == "QUADS") {

            if (this.state.user.hor_push_max > 0) {
                this.setState({activeNav: 'schedule'});
                browserHistory.push('/commitment');
            } else {
                this.setState({activeNav: 'fitness'});
                browserHistory.push('/fitness');
            }

        } else if (childView == "COMMITMENT") {

            this.setState({activeNav: 'schedule'});
            if (additionalData) {
                this.fetchSuggestedSchedule();
                browserHistory.push('/schedule');
            } else {
                browserHistory.push('/program');
            }

        } else if (childView == "PROGRAM") {
            this.fetchSuggestedSchedule();
            browserHistory.push('/schedule');
        }
    }

    previousPage(childView) {
        if (childView == "QUADS") {
            this.setState({activeNav: 'setup'});
        } else if (childView == "FITNESS") {
            this.setState({activeNav: 'setup'});
        } else if (childView == "COMMITMENT") {
            this.setState({activeNav: 'fitness'});
        }
        browserHistory.goBack();
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        UserScheduleStore.addChangeListener(this.onChange);
        ProgramStore.addChangeListener(this.onChange);
        FitnessAssessmentStore.addChangeListener(this.onChange);
        UserActions.getUser(gon.current_user_id);
        this.configure();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        UserScheduleStore.removeChangeListener(this.onChange);
        ProgramStore.removeChangeListener(this.onChange);
        FitnessAssessmentStore.removeChangeListener(this.onChange);
    }

    componentWillReceiveProps (nextProps) {
        // Does routing map exist? If not, set it
        // Does sub nav exist? If not, set it
        // Set actions for actions being passed down to child components via props
        this.configure();
    }

    configure() {
        if (!this.state.isConfigured) {
            // Check gon for onboarding, viewing, team_id, user_id, context
            this.defineRoutes();
            this.defineActions();
        }
    }

    defineRoutes() {
        var navElements = [];
        if (gon.setup_context == 'user') {
            navElements.push({class: '', label: 'Goal'});
            navElements.push({class: '', label:'Quads'});
            if (gon.setup_context.onboarding) {
                navElements.push({class: '', label:'Fitness Assessment'});
            }
            navElements.push({class: '', label: 'Commitment'});
            navElements.push({class: '', label: 'Schedule'});
        } else if (gon.setup_context == 'sub_user') {
            if (gon.setup_context.onboarding) {
                navElements.push({class: '', label: 'Fitness Assessment'});
            }
        } else if (gon.setup_context == 'coach_sub') {
            navElements.push({class: '', label: 'Goal'});
            navElements.push({class: '', label: 'Quads'});
            navElements.push({class: '', label: 'Commitment'});
            navElements.push({class: '', label: 'Schedule'});
        } else if (gon.setup_context == 'coach_team') {
            navElements.push({class: '', label: 'Quads'});
            navElements.push({class: '', label: 'Commitment'});
            navElements.push({class: '', label: 'Schedule'});
        }

        if (navElements.length == 0) {
            location.href = '/workout';
        } else {
            this.setState({navElements: navElements});
        }
    }

    defineActions() {

    }

    onChange () {
        var data = UserStore.getData();
        var schedule = UserScheduleStore.getData();
        var fitness = FitnessAssessmentStore.getData();
        var program = ProgramStore.getData();
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
            program: program,
            suggested_schedule: program.suggested_schedule,
            user_schedule: schedule
        });
        if (fitness.complete) {
            FitnessAssessmentActions.submit(this.state, this.fitnessSubmitted);
        }
    }

    fetchSuggestedSchedule() {
        if (this.state.user_schedule.schedule.id) {
            var goal = this.state.user_schedule.schedule.program_type_id;
            var strengthProgram = this.state.user_schedule.schedule.program_id;
            ProgramActions.getSuggestedSchedule(goal, strengthProgram);
        } else {
            ProgramActions.getSuggestedSchedule(this.state.goal, this.state.program.strengthProgram);
        }
    }

    fitnessSubmitted() {
        if (FitnessAssessmentStore.getData().quads.strength) {
            browserHistory.push('/commitment');
        } else {
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

        return <div>
            <Header user={this.state.user} />
            <Subnav activeNav={this.state.activeNav} elements={this.state.navElements} />
            {childrenWithProps}
        </div>
    }
}

render((
    <Router history={browserHistory}>
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