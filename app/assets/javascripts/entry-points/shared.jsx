import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import RoutineStore from 'stores/routine_store';
import UserStore from 'stores/user_store';
import QuadPodStore from 'stores/quad_pod_store';
import RoutineActions from 'actions/routine_actions';
import UserActions from 'actions/user_actions';
import Header from 'views/common/header';
import C from 'constants/routine_constants';
import MenuModal from 'views/do-work/menu_modal';
import Button from 'views/common/button';
import Footer from 'views/common/footer';
import { Modal } from 'react-bootstrap';
import validator from 'validator';
import DoWork from 'views/do-work/do-work';
import Util from 'helpers/util';

require('pages/workout.scss');

class App extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            routine: {comments: []},
            user: {},
            loggedInUser: {},
            loading: true,
            user_name: gon.user_name,
            showAddEx: false,
            exercise_type: undefined,
            invites: {},
            conversation: {},
            showBanner: false
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
        this.load();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        RoutineStore.removeChangeListener(this.onChange.bind(this));
    }

    load() {
        if (gon.user_id) {
            UserActions.getUser(gon.user_id, true);
        }
        RoutineActions.getById(gon.routine.id, gon.token);
    }

    onChange () {
        var data = RoutineStore.getData();
        data.routine = data.routine || this.state.routine;
        var user = UserStore.getData();
        this.setState(
            {
                routine: data.routine,
                loading: data.loading,
                loggedInUser: user.loggedInUser
            }
        );
        this.evalBanner();
    }

    evalBanner() {
        if (!this.state.showBanner) {
            this.setState({showBanner: true, bannerContent: this.viewingUserBanner});
        }
    }

    viewingUserBanner() {
        return <div>
            <span className="col-xs-12 col-sm-offset-2 col-sm-8 text-center bold">Viewing {Util.formatDate(this.state.routine.day_performed +' 00:00:00 PST')} workout for {this.state.user_name}</span>
        </div>;
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
            <DoWork {...this.state} shared={true}/>
            <Footer />
        </div>
    }
}
render(<App />, document.getElementById('app'));
