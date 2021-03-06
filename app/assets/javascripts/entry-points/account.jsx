import { Router, Route, Link, browserHistory } from 'react-router';
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
import Subscription from 'views/account/subscription';

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
            user: {},
            checkoutStatus: {}
        };
        this.onChange = this.onChange.bind(this);
        this.evalUsername = this.evalUsername.bind(this);
        this.onDrop = this.onDrop.bind(this);
        this.updateBilling = this.updateBilling.bind(this);
        this.premiumCheckout = this.premiumCheckout.bind(this);
        this.bronzeCheckout = this.bronzeCheckout.bind(this);
        this.silverCheckout = this.silverCheckout.bind(this);
        this.goldCheckout = this.goldCheckout.bind(this);
        this.profileChanged = this.profileChanged.bind(this);
    }

    premiumCheckout (token)  {
        this.checkout(token, C.PREMIUM_CHECKOUT);
    }

    bronzeCheckout (token)  {
        this.checkout(token, C.BRONZE_CHECKOUT);
    }
    silverCheckout (token)  {
        this.checkout(token, C.SILVER_CHECKOUT);
    }
    goldCheckout (token)  {
        this.checkout(token, C.GOLD_CHECKOUT);
    }
    
    checkout (token, type){
        ProfileActions.checkout(token, type);        
    }

    changeAccount(type) {
        ProfileActions.updateSubscription(type);
    }

    deleteSubscription() {
        ProfileActions.deleteSubscription();
    }

    updateBilling (token) {
        ProfileActions.updateBilling(token);
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
        UserStore.addChangeListener(this.onChange);
        ProfileStore.addChangeListener(this.profileChanged);
        SignUpStore.addChangeListener(this.onChange);
        this.load();
    }

    componentWillUnmount () {
        ProfileStore.removeChangeListener(this.profileChanged);
        UserStore.removeChangeListener(this.onChange);
        SignUpStore.removeChangeListener(this.onChange);
    }

    load() {
        UserActions.getUser(gon.user_id);
    }

    profileChanged() {
        this.onChange();
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
                saveStatus: data.saveStatus,
                checkoutStatus: data.checkout
            }
        );

        if (isUsernameUnique) {
            this.setState({usernameErrors: []});
        } else {
            this.setState({usernameErrors: ["Username isn't available."]});
        }

        this.state.formSubmitted = false;
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
        user['bio'] = this.refs.bioBox.value.trim();
        if (this.refs.password.getValue()) {
            user['password'] = this.refs.password.getValue();
            user['password_confirmation'] = this.refs.password.getValue();
        }
        user['user_name'] = this.refs.username.getValue();
        user['experience_level'] = this.refs.experienceLevel.value;
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

    imagePath() {
        var path = "https://dwx350bwdtt59.cloudfront.net/blank-avi.png";
        if (this.state.user && this.state.user.avatar) {
            path = this.state.user.avatar;
        }
        return path;
    }

    onDrop(files) {
        UserActions.uploadAvatar(files);
    }

    render () {

        return <div>
            <Header user={this.state.user} showWorkoutNav={true} active={''} trueLinks={true} />
            <If condition={this.state.checkoutStatus.status} >
                <div className="row banner-row no-margin fixed">
                    <div className="container">
                        <div className="row">
                            {this.state.checkoutStatus.message}
                        </div>
                    </div>
                </div>
            </If>
            <div className="account">
                <div className="row main no-margin">
                    <div className="container">
                        <div className="row">
                            <div className="col-xs-12">
                                <h1 className="p-header">
                                    Your Account
                                </h1>
                                <div className="p-sub standard-text">
                                    Change your personal settings or upgrade your account!
                                </div>
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-12 col-sm-8 col-md-6 content">
                                <div className="p-section">
                                    <div className="sec-header">Your Personal Settings</div>
                                    <div className="sec-main">
                                        <div className="row avi-row">
                                            <div className="col-md-12 text-center">
                                                <span className="dropzone-wrapper">
                                                    <Dropzone ref={(node) => { this.dropzone = node; }} onDrop={this.onDrop} multiple={false} maxSize={4000000} accept={'image/*'}>
                                                        <img src={this.imagePath()} alt={this.state.user.user_name}
                                                             className="img-circle hover" width="100" height="100"/>
                                                    </Dropzone>
                                                </span>
                                            </div>
                                        </div>

                                        <If condition={this.state.user.first_name}>
                                            <div className="row">
                                                <div className="col-md-12">
                                                    <span className={`purple-bot-container border-top ${this.state.usernameErrors.length > 0 ? 'error' : ''}`}>
                                                        <FancyInput ref="username" name="user_name" placeholder="Username" type="text"
                                                                    changedCallback={this.evalUsername} errors={this.state.usernameErrors}
                                                                    value={this.state.user.user_name} />
                                                    </span>
                                                </div>
                                            </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.firstNameErrors.length > 0 ? 'error' : ''}`}>
                                                    <FancyInput ref="firstName" name="first_name" placeholder="First Name" type="text"
                                                                errors={this.state.firstNameErrors} value={this.state.user.first_name} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.lastNameErrors.length > 0 ? 'error' : ''}`}>
                                                    <FancyInput ref="lastName" name="last_name" placeholder="Last Name" type="text"
                                                                errors={this.state.lastNameErrors} value={this.state.user.last_name} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className={`purple-bot-container ${this.state.emailErrors.length > 0 ? 'error' : ''}`}>
                                                    <FancyInput ref="email" name="email" placeholder="Email Address" type="text"
                                                                errors={this.state.emailErrors} value={this.state.user.email} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row input-row">
                                            <div className="col-md-12 input-row">
                                                <span className={`purple-bot-container ${this.state.passwordErrors.length > 0 ? 'error' : ''}`}>
                                                    <FancyInput ref="password" name="password" placeholder="New Password" type="password"
                                                                errors={this.state.passwordErrors} />
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                                <span className="purple-bot-container standard-text experience-row">
                                                    Experience level
                                                    <select ref="experienceLevel" defaultValue={this.state.user.experience_level} className="form-control select">
                                                        <option value="1">Beginner</option>
                                                        <option value="2">Intermediate</option>
                                                        <option value="3">Advanced</option>
                                                    </select>
                                                </span>
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-md-12">
                                            <span className='purple-bot-container bio-section standard-text'>
                                                About Me
                                                <textarea ref="bioBox" className="bio-box" maxLength="150" rows="10" defaultValue={this.state.user.bio} />
                                            </span>
                                            </div>
                                        </div>
                                        <div className="row submit-row">
                                            <div className="col-md-12">
                                                <If condition={this.state.saveStatus.status == C.PROFILE_FAILURE}>
                                                    <div>{this.state.saveStatus.errors.join(', ')}</div>
                                                </If>
                                                <Button onClick={ () => this.submit()}
                                                        buttonText={this.state.saveStatus.status == C.PROFILE_SUCCESS ? 'SAVED!' : 'Save'} />
                                            </div>
                                        </div>
                                        </If>
                                    </div>
                                </div>
                            </div>
                            <Subscription {...this.state}
                                premiumCheckout={this.premiumCheckout}
                                changeAccount={this.changeAccount}
                                deleteSubscription={this.deleteSubscription}
                                updateBilling={this.updateBilling}
                                bronzeCheckout={this.bronzeCheckout}
                                silverCheckout={this.silverCheckout}
                                goldCheckout={this.goldCheckout}
                            />
                        </div>
                    </div>
                </div>
            </div>
            <Footer />
        </div>
    }
}

render(<Account />, document.getElementById('app'));
