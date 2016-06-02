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

import UserStore from 'stores/user_store';
import FitnessAssessmentStore from 'stores/fitness_assessment_store';
import ProgramStore from 'stores/program_store';
import UserActions from 'actions/user_actions';
import FitnessAssessmentActions from 'actions/fitness_assessment_actions';

var C = require('constants/fitness_assessment_constants.js');

require('pages/setup.scss');

class App extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {},
            goal: C.MASS,
            program: {}
        };
        this.nextPage = this.nextPage.bind(this);
        this.onChange = this.onChange.bind(this);
        this.fitnessSubmitted = this.fitnessSubmitted.bind(this);
    }

    nextPage(childView) {
        //Sees which child view called, evaluates the state, and calls to route to the next page
        if (childView == "GOAL") {
            browserHistory.push('/get-started/quads');
        } else if (childView == "QUADS") {
            browserHistory.push('/fitness');
        } else if (childView == "COMMITMENT") {
            browserHistory.push('/program');
        } else if (childView == "PROGRAM") {
            browserHistory.push('/schedule');
        }
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        ProgramStore.addChangeListener(this.onChange);
        FitnessAssessmentStore.addChangeListener(this.onChange);
        UserActions.getUser(gon.current_user_id);
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        ProgramStore.removeChangeListener(this.onChange);
        FitnessAssessmentStore.removeChangeListener(this.onChange);
    }

    onChange () {
        var data = UserStore.getData();
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
            program: program
        });
        if (fitness.complete) {
            FitnessAssessmentActions.submit(this.state, this.fitnessSubmitted);
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
            (child) => React.cloneElement(child, Object.assign({}, this.state, {next: this.nextPage}))
        );

        return <div>
            <Header user={this.state.user} />
            <Subnav  />
            {childrenWithProps}
        </div>
    }
}

render((
    <Router history={browserHistory}>
        <Route path="/" component={App}>
            <Route path="get-started" >
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