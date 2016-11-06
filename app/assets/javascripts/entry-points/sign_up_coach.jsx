import {render} from 'react-dom';
import FancyInput from 'views/common/fancy_input';
import Slider from 'views/common/slider';
import validator from 'validator';
import SignUpActions from 'actions/sign_up_actions';
import SignUpStore from 'stores/sign_up_store';
import C from 'constants/sign_up_constants';

require('pages/sign_up_coach.scss');

class CoachSignUp extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            signUpStatus: {status: '', errors: []},
            isUsernameUnique: true,
            usernameErrors: [],
            firstNameErrors: [],
            lastNameErrors: [],
            emailErrors: [],
            passwordErrors: []
        };
        this.evalFirstName = this.evalFirstName.bind(this);
        this.evalLastName = this.evalLastName.bind(this);
        this.evalEmail = this.evalEmail.bind(this);
        this.evalPassword = this.evalPassword.bind(this);
    }

    componentDidMount () {
        SignUpStore.addChangeListener(this.onChange.bind(this));
        var that = this;
        $(document).keypress(function(e) {
            if(e.which == 13) {
                that.submit();
            }
        });
    }

    componentWillUnmount () {
        SignUpStore.removeChangeListener(this.onChange.bind(this));
        $(document).off("keypress");
    }

    onChange () {
        var data = SignUpStore.getData();

        if (data.signUpStatus.status == C.SUCCESS) {
            location.href = '/setup/coach';
        }

        if (data.isUsernameUnique) {
            this.setState({usernameErrors: []});
        } else {
            this.setState({usernameErrors: ["Username isn't available."]});
        }

        this.setState({
            signUpStatus: data.signUpStatus,
            formSubmitted: false
        });
    }

    submit () {
        if (!this.state.formSubmitted) {
            this.state.formSubmitted = true;
            if (!this.hasErrors()) {
                SignUpActions.signUp(this.packageData());
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
        user['password'] = this.refs.password.getValue();
        user['password_confirmation'] = this.refs.password.getValue();
        user['account_type'] = 'coach';
        user['user_name'] = this.refs.username.getValue();
        return {user: user, invite_token: ''};
    }

    evalUsername(username) {
        if (username.length > 4) {
            SignUpActions.usernameCheck(username);
        }
    }

    evalFirstName(firstName) {
        if (validator.isLength(firstName, {min: 2})) {
            this.setState({firstNameErrors: []});
        }
    }

    evalLastName(lastName) {
        if (validator.isLength(lastName, {min: 2})) {
            this.setState({lastNameErrors: []});
        }
    }

    evalEmail(email) {
        if (validator.isEmail(email)) {
            this.setState({emailErrors: []});
        }
    }

    evalPassword(password) {
        var strength = this.refs.password.getStrength();
        if (strength >= 2) {
            this.setState({passwordErrors: []});
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
            this.setState({lastNameErrors: ['Please enter a valid last name']});
            hasErrors = true;
        }

        var email = this.refs.email.getValue();
        if (!validator.isEmail(email)) {
            this.setState({emailErrors: ['Please enter a valid email']});
            hasErrors = true;
        }

        var strength = this.refs.password.getStrength();
        if (strength < 2 || !validator.isLength(this.refs.password.getValue(), {min: 8})) {
            this.setState({passwordErrors: ['Your password is too weak']});
            hasErrors = true;
        }
        return hasErrors;
    }

    fbLogin() {
        location.href = '/users/auth/facebook?coach=true';
    }

    render () {
        return <div className="coach-sign-up row">
            <div className="col-lg-5 col-lg-offset-6 col-md-6 col-md-offset-5 col-xs-8 col-xs-offset-4 form">
                <div className="row">
                    <div className="col-md-12">
                        <h1>Sign up as a Coach</h1>
                        <a href="/sign-up" className="info-text subtle-link">Not a coach? Sign up here.</a>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                        <span className="fb-button text-center" onClick={ () => this.fbLogin() }>Sign up with Facebook</span>
                    </div>
                </div>
                <div className="row buffer">
                    <div className="col-md-12 text-center">
                            <span className="purple-bot-container">
                                <hr className="hr-left" />
                                <span className="text-uppercase info-text">or sign up with an email address</span>
                                <hr className="hr-right" />
                            </span>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                            <span className={`purple-bot-container ${this.state.usernameErrors.length > 0 ? 'error' : null}`}>
                                <FancyInput ref="username" name="user_name" placeholder="Username" type="text"
                                            changedCallback={this.evalUsername} errors={this.state.usernameErrors} />
                            </span>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                            <span className={`purple-bot-container ${this.state.firstNameErrors.length > 0 ? 'error' : null}`}>
                                <FancyInput ref="firstName" name="first_name" placeholder="First Name" type="text"
                                            changedCallback={this.evalFirstName} errors={this.state.firstNameErrors} />
                            </span>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                            <span className={`purple-bot-container ${this.state.lastNameErrors.length > 0 ? 'error' : null}`}>
                                <FancyInput ref="lastName" name="last_name" placeholder="Last Name" type="text"
                                            changedCallback={this.evalLastName} errors={this.state.lastNameErrors} />
                            </span>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                            <span className={`purple-bot-container ${this.state.emailErrors.length > 0 ? 'error' : null}`}>
                                <FancyInput ref="email" name="email" placeholder="Email Address" type="text"
                                            changedCallback={this.evalEmail} errors={this.state.emailErrors} />
                            </span>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                            <span className={`purple-bot-container ${this.state.passwordErrors.length > 0 ? 'error' : null}`}>
                                <FancyInput ref="password" name="password" placeholder="Password" type="password"
                                            changedCallback={this.evalPassword} errors={this.state.passwordErrors} />
                            </span>
                    </div>
                </div>
                <div className="row submit-row">
                    <div className="col-md-12">
                        <If condition={this.state.signUpStatus.status == C.FAILURE}>
                            <div className="sign-up-error">{this.state.signUpStatus.errors.join(', ')}</div>
                        </If>
                        <span onClick={ () => this.submit()} className={this.state.formSubmitted ? "submitting submit-button purple-text" : "submit-button purple-text" }>
                            {this.state.formSubmitted ? "..." : "Sign Up" }
                        </span>
                        <a href="/sign-in" className="help-text bold-link">Have an account? Login here.</a>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                        By clicking Sign Up you agree to the <a href="/terms" target="_blank" className="help-text bold-link">user agreement.</a>
                    </div>
                </div>
            </div>
        </div>;
    }
}

render(<CoachSignUp/>, document.getElementById('app'));