import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import UserStore from 'stores/user_store';
import UserActions from 'actions/user_actions';
import Header from 'views/common/header';
import Footer from 'views/common/footer';
import Button from 'views/common/button';
import FancyInput from 'views/common/fancy_input';
import Slider from 'views/common/slider';
import C from 'constants/sign_up_constants';

require('pages/profile.scss');

class Profile extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            signUpStatus: {status: '', errors: []},
            isUsernameUnique: true,
            usernameErrors: [],
            firstNameErrors: [],
            lastNameErrors: [],
            emailErrors: [],
            passwordErrors: [],
            user: {}
        };
        this.onChange = this.onChange.bind(this);
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        this.load();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
    }

    load() {
        UserActions.getUser(gon.current_user_id);
    }

    onChange () {
        var user = UserStore.getData();
        this.setState(
            {
                user: user.user
            }
        );
    }

    changeAccount() {

    }

    render () {

        return <div>
            <Header user={this.state.user} showWorkoutNav={true} active={''} trueLinks={true} />
            <div className="profile">
                <div className="row main">
                    <div className="container">
                        <div className="row">
                            <div className="col-xs-12">
                                <div className="p-header">
                                    Your Profile
                                </div>
                                <div className="p-sub">
                                    Change your personal settings or upgrade your account!
                                </div>
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">Your Personal Settings</div>
                                    <div className="sec-main">
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.firstNameErrors.length > 0 ? 'error' : null}`}>
                                                    <FancyInput ref="firstName" name="first_name" placeholder="First Name" type="text"
                                                                errors={this.state.firstNameErrors} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.lastNameErrors.length > 0 ? 'error' : null}`}>
                                                    <FancyInput ref="lastName" name="last_name" placeholder="Last Name" type="text"
                                                                errors={this.state.lastNameErrors} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.emailErrors.length > 0 ? 'error' : null}`}>
                                                    <FancyInput ref="email" name="email" placeholder="Email Address" type="text"
                                                                errors={this.state.emailErrors} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.passwordErrors.length > 0 ? 'error' : null}`}>
                                                    <FancyInput ref="password" name="password" placeholder="Password" type="password"
                                                                errors={this.state.passwordErrors} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className="purple-bot-container">
                                                    <Slider ref="sex" checked="female" unchecked="male"/>
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row submit-row">
                                            <div className="col-md-12">
                                                <If condition={this.state.signUpStatus.status == C.FAILURE}>
                                                    <div>{this.state.signUpStatus.errors.join(', ')}</div>
                                                </If>
                                                <Button onClick={ () => this.submit()} buttonText={"Submit"} />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">Premium Account</div>
                                    <div className="sec-main">
                                        <div>Get access to even more exercises and unlimited reporting on workout progress
                                        for only $9.99 a month!</div>
                                        <div className="button-wrap">
                                            <Button onClick={this.changeAccount} buttonText={"Get Premium"} />
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
