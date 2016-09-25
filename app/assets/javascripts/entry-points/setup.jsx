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
        this.state = {
            user: {},
            goal: C.MASS,
            program: {},
            quads: {},
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
        this.defineRoutes = this.defineRoutes.bind(this);
    }

    nextPage(childView, skipProgram) {
        _.each(this.state.routes, function(route, index) {
            if (route.name == childView) {
                var nextRoute = this.state.routes[index + 1];
                if (nextRoute.name == 'Program' && skipProgram) {
                    nextRoute = this.state.routes[index + 2];
                }
                if (nextRoute.name == 'Schedule') {
                    this.fetchSuggestedSchedule();
                }
                browserHistory.push(nextRoute.route);
            }
        });
    }

    previousPage() {
        browserHistory.goBack();
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        UserScheduleStore.addChangeListener(this.onChange);
        ProgramStore.addChangeListener(this.onChange);
        FitnessAssessmentStore.addChangeListener(this.onChange);
        UserActions.getUser(gon.current_user_id);
        this.defineRoutes();
        this.defineActions();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        UserScheduleStore.removeChangeListener(this.onChange);
        ProgramStore.removeChangeListener(this.onChange);
        FitnessAssessmentStore.removeChangeListener(this.onChange);
    }

    componentWillReceiveProps (nextProps) {
        this.defineRoutes();
        this.defineActions();
    }

    defineRoutes() {
        var navElements = [];
        var routes = [];

        if (this.props.children.type.name != 'Coach') {
            if (gon.setup_context == 'user' || gon.setup_context == 'coach_sub') {
                navElements.push({class: this.getNavClass(['Goal']), label: 'Goal'});
                routes.push({route: '/setup/goal', name: 'Goal'});
            }

            if (gon.setup_context && gon.setup_context != 'sub_user') {
                navElements.push({class: this.getNavClass(['Quads']), label: 'Quads'});
                routes.push({route: '/setup/quads', name: 'Quads'});
            }

            if ((gon.onboarding && gon.setup_context == 'user') || (gon.setup_context == 'sub_user')) {
                navElements.push({class: this.getNavClass(['Fitness']), label: 'Fitness Assessment'});
                routes.push({route: '/fitness', name: 'Fitness'});
            }

            if (gon.setup_context && gon.setup_context != 'sub_user') {
                navElements.push({class: this.getNavClass(['Program, Commitment, Schedule']), label: 'Schedule'});
                routes.push({route: '/commitment', name: 'Commitment'});
                routes.push({route: '/program', name: 'Program'});
                routes.push({route: '/schedule', name: 'Schedule'});
            }
        }

        this.setState({navElements: navElements, routes: routes});
    }

    defineActions() {

    }

    getNavClass(names) {
        return (names.indexOf(this.props.children.type.name) > -1) ? 'bold-text' : '';
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
            // @TODO this doesn't look right
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
            <Subnav elements={this.state.navElements} />
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