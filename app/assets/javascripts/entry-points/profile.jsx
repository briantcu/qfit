import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import UserStore from 'stores/user_store';
import UserActions from 'actions/user_actions';
import Header from 'views/common/header';
import Footer from 'views/common/footer';
import Button from 'views/common/button';
import FancyInput from 'views/common/fancy_input';
import Slider from 'views/common/slider';
import C from 'constants/profile_constants';
import validator from 'validator';
import SignUpActions from 'actions/sign_up_actions';
import ProfileActions from 'actions/profile_actions';
import ProfileStore from 'stores/profile_store';
import SignUpStore from 'stores/sign_up_store';
import Dropzone from 'react-dropzone';

require('pages/profile.scss');


class Profile extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {}
        };
        this.onChange = this.onChange.bind(this);
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        ProfileStore.addChangeListener(this.onChange);
        this.load();
    }

    componentWillUnmount () {
        ProfileStore.removeChangeListener(this.onChange);
        UserStore.removeChangeListener(this.onChange);
    }

    load() {
        UserActions.getUser(gon.user_id);
    }

    onChange () {
        var user = UserStore.getData();
        var data = ProfileStore.getData();
        this.setState(
            {
                user: user.user
            }
        );

    }

    render () {

        return <div>
            <Header user={this.state.user} showWorkoutNav={true} active={''} trueLinks={true} />
            <div className="profile">
                <div className="row main">
                    <div className="container">
                        <div className="row profile-row">
                            <div className="col-xs-12">
                                <div className="p-section">
                                    <div className="sec-header">Profile</div>
                                    <div className="sec-main">
                                        <div className="row">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div className="row profile-row">
                            <div className="col-xs-6">
                                <div className="p-section">
                                    <div className="sec-header">Recent Workouts</div>
                                    <div className="sec-main">
                                        <div className="row">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div className="col-xs-6">
                                <div className="p-section">
                                    <div className="sec-header">Quad Pod</div>
                                    <div className="sec-main">
                                        <div className="row">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <Footer />
        </div>
    }
}

render(<Profile />, document.getElementById('app'));
