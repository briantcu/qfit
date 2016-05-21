import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';

import Header from 'views/common/header';
import Subnav from 'views/setup/subnav';
import Goal from 'views/setup/goal';
import Quads from 'views/setup/quads';
import Weight from 'views/setup/weight';

import UserStore from 'stores/user_store';
import FitnessAssessmentStore from 'stores/fitness_assessment_store';
import UserActions from 'actions/user_actions';

var C = require('constants/fitness_assessment_constants.js');

require('pages/setup.scss');

class App extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {},
            goal: C.MASS
        };
        this.nextPage = this.nextPage.bind(this);
        this.onChange = this.onChange.bind(this);

    }

    nextPage(childView) {
        //Sees which child view called, evaluates the state, and calls to route to the next page
        if (childView == "GOAL") {
            browserHistory.push('/get-started/quads');
        }
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        FitnessAssessmentStore.addChangeListener(this.onChange);
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        FitnessAssessmentStore.removeChangeListener(this.onChange);
    }

    onChange () {
        var data = UserStore.getData();
        var fitness = FitnessAssessmentStore.getData();
        this.setState({
            user: data.user,
            goal: fitness.goal,
            quads: fitness.quads
        });
    }

    componentWillReceiveProps () {
        UserActions.getUser(gon.current_user_id);
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
            <Route path="fitness" >
                <Route path="weight" component={Weight} />
                <Route path="bench" component={Weight} />
                <Route path="squat" component={Weight} />
            </Route>
            <Route path="program" >
                <Route path="module" component={Weight} />
                <Route path="strength" component={Weight} />
            </Route>
            <Route path="schedule" >
                <Route path="plyos" component={Weight} />
                <Route path="strength" component={Weight} />
                <Route path="sprinting" component={Weight} />
            </Route>
        </Route>
    </Router>
), document.getElementById('app'));