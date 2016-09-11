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
import StripeCheckout from 'react-stripe-checkout';
require('pages/account.scss');


class Account extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            saveStatus: {status: '', errors: []},
            isUsernameUnique: true,
            usernameErrors: [],
            firstNameErrors: [],
            lastNameErrors: [],
            emailErrors: [],
            passwordErrors: [],
            user: {}
        };
        this.onChange = this.onChange.bind(this);
        this.evalUsername = this.evalUsername.bind(this);
    }

    onToken (token)  {
        ProfileActions.checkout(token, C.PREMIUM_CHECKOUT);
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        ProfileStore.addChangeListener(this.onChange);
        SignUpStore.addChangeListener(this.onChange);
        this.load();
    }

    componentWillUnmount () {
        ProfileStore.removeChangeListener(this.onChange);
        UserStore.removeChangeListener(this.onChange);
        SignUpStore.removeChangeListener(this.onChange);
    }

    load() {
        UserActions.getUser(gon.current_user_id);
    }

    onChange () {
        var user = UserStore.getData();
        var data = ProfileStore.getData();
        var isUsernameUnique = SignUpStore.getData().isUsernameUnique;
        isUsernameUnique = (isUsernameUnique || (this.state.user.user_name == this.refs.username.getValue()));
        this.setState(
            {
                user: user.user,
                isUsernameUnique: isUsernameUnique,
                saveStatus: data.saveStatus
            }
        );

        if (isUsernameUnique) {
            this.setState({usernameErrors: []});
        } else {
            this.setState({usernameErrors: ["Username isn't available."]});
        }

        this.state.formSubmitted = false;
    }

    changeAccount() {

    }

    submit () {
        if (!this.state.formSubmitted) {
            this.state.formSubmitted = true;
            if (!this.hasErrors()) {
                ProfileActions.update(this.packageData());
            } else {
                this.state.formSubmitted = false;
            }
        }
    }

    packageData () {
        var user = {};
        user['email'] = this.refs.email.getValue();
        user['first_name'] = this.refs.firstName.getValue();
        user['last_name'] = this.refs.lastName.getValue();
        if (this.refs.password.getValue()) {
            user['password'] = this.refs.password.getValue();
        }
        user['user_name'] = this.refs.username.getValue();
        return {user: user};
    }

    evalUsername(username) {
        if ((username.length > 4) && (username != this.state.user.user_name)) {
            SignUpActions.usernameCheck(username);
        }
    }

    hasErrors () {
        var hasErrors = false;
        var username = this.refs.username.getValue();
        if (!validator.isLength(username, {min: 5})) {
            this.setState({usernameErrors: ['Username must be at least 5 characters']});
            hasErrors = true;
        }

        var firstName = this.refs.firstName.getValue();
        if (!validator.isLength(firstName, {min: 2})) {
            this.setState({firstNameErrors: ['Please enter a valid first name']});
            hasErrors = true;
        }

        var lastName = this.refs.lastName.getValue();
        if (!validator.isLength(lastName, {min: 2})) {
            this.setState({lastNameErrors: ['Please enter a valid first name']});
            hasErrors = true;
        }

        var email = this.refs.email.getValue();
        if (!validator.isEmail(email)) {
            this.setState({emailErrors: ['Please enter a valid email']});
            hasErrors = true;
        }

        if (this.refs.password.getValue()) {
            var strength = this.refs.password.getStrength();
            if (strength < 2) {
                this.setState({passwordErrors: ['Your password is too weak']});
                hasErrors = true;
            }
        }
        return hasErrors;
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
                                    Your Account
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
                                        <If condition={this.state.user.first_name}>
                                            <div className="row">
                                                <div className="col-md-12">
                                                    <span className={`purple-bot-container border-top ${this.state.usernameErrors.length > 0 ? 'error' : null}`}>
                                                        <FancyInput ref="username" name="user_name" placeholder="Username" type="text"
                                                                    changedCallback={this.evalUsername} errors={this.state.usernameErrors}
                                                                    value={this.state.user.user_name} />
                                                    </span>
                                                </div>
                                            </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.firstNameErrors.length > 0 ? 'error' : null}`}>
                                                    <FancyInput ref="firstName" name="first_name" placeholder="First Name" type="text"
                                                                errors={this.state.firstNameErrors} value={this.state.user.first_name} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.lastNameErrors.length > 0 ? 'error' : null}`}>
                                                    <FancyInput ref="lastName" name="last_name" placeholder="Last Name" type="text"
                                                                errors={this.state.lastNameErrors} value={this.state.user.last_name} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.emailErrors.length > 0 ? 'error' : null}`}>
                                                    <FancyInput ref="email" name="email" placeholder="Email Address" type="text"
                                                                errors={this.state.emailErrors} value={this.state.user.email} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.passwordErrors.length > 0 ? 'error' : null}`}>
                                                    <FancyInput ref="password" name="password" placeholder="New Password" type="password"
                                                                errors={this.state.passwordErrors} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row submit-row">
                                            <div className="col-md-12">
                                                <If condition={this.state.saveStatus.status == C.PROFILE_FAILURE}>
                                                    <div>{this.state.saveStatus.errors.join(', ')}</div>
                                                </If>
                                                <If condition={this.state.saveStatus.status == C.PROFILE_SUCCESS}>
                                                    <div>SUCCESS!</div>
                                                </If>
                                                <Button onClick={ () => this.submit()} buttonText={"Save"} />
                                            </div>
                                        </div>
                                        </If>
                                    </div>
                                </div>
                            </div>
                            <If condition={this.state.user.paid_tier == 1}>
                                <div className="col-xs-12 col-sm-6">
                                    <div className="p-section">
                                        <div className="sec-header">Premium Account</div>
                                        <div className="sec-main">
                                            <div>Get access to even more exercises and unlimited reporting on workout progress
                                            for only <span className="purple">$9.99</span> a month!</div>
                                            <div className="button-wrap">
                                                <StripeCheckout
                                                    token={this.onToken}
                                                    stripeKey="pk_test_Qn7vO7ACSbGqKp7tBXget5Du"
                                                    amount={999}
                                                    name="Quadfit, LLC"
                                                    image="https://s3.amazonaws.com/quadfit/logo-1.jpg"
                                                    description="Premium Membership"
                                                    panelLabel="Get Premium"
                                                    label="Get Premium"
                                                    allowRememberMe={false}
                                                    email={this.state.user.email}
                                                    local="auto"
                                                />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </If>
                            <If condition={this.state.user.paid_tier == 2}>
                                <div className="col-xs-12 col-sm-6">
                                    <div className="p-section">
                                        <div className="sec-header">Your Account</div>
                                        <div className="sec-main">
                                            <div>You have a premium account, which gives you access to the complete Quadfit library of exercises
                                                and unlimited reporting for only
                                                <span className="purple">$9.99</span> a month!</div><br/>
                                                If you choose to downgrade your account you'll lose access to the complete Quadfit library,
                                                and you'll only be able to see your progress for the last month.
                                            <div className="button-wrap">
                                                <Button onClick={this.changeAccount} buttonText={"Downgrade"} />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </If>
                        </div>
                    </div>
                </div>
            </div>
            <Footer />
        </div>
    }
}

render(<Account />, document.getElementById('app'));