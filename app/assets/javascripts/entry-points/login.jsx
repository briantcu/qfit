import {render} from 'react-dom';
import FancyInput from 'views/common/fancy_input';
import Slider from 'views/common/slider';
import validator from 'validator';
import SignUpActions from 'actions/sign_up_actions';
import SignUpStore from 'stores/sign_up_store';
import C from 'constants/sign_up_constants';

require('pages/login.scss');

class Login extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            signUpStatus: {status: '', errors: []},
            usernameErrors: [],
            emailErrors: [],
            passwordErrors: []
        };
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
            location.href = '/workout';
        } else {
            this.setState({
                signUpStatus: data.signUpStatus
            });
        }

        this.state.formSubmitted = false;
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
        var email = this.refs.email.getValue();
        var password = this.refs.password.getValue();
        return {email: email, password: password};
    }

    hasErrors () {
        var hasErrors = false;

        var email = this.refs.email.getValue();
        if (!validator.isEmail(email)) {
            this.setState({emailErrors: ['Please enter a valid email']});
            hasErrors = true;
        }

        if (strength < 2) {
            this.setState({passwordErrors: ['Your password is too weak']});
            hasErrors = true;
        }
        return hasErrors;
    }

    fbLogin() {
        location.href = '/users/auth/facebook';
    }

    render () {
        return <div className="athlete-sign-up row">
            <div className="col-md-5 col-md-offset-6 col-xs-12 col-xs-offset-0 form">
                <div className="row">
                    <div className="col-md-12">
                        <h1>Sign in to your account</h1>
                        <a href="/sign-up" className="info-text subtle-link">New here? Sign up here.</a>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                        <span className="fb-button text-center" onClick={ () => this.fbLogin() }>Sign in with Facebook</span>
                    </div>
                </div>
                <div className="row buffer">
                    <div className="col-md-12 text-center">
                            <span className="purple-bot-container">
                                <hr className="hr-left" />
                                <span className="text-uppercase info-text">or</span>
                                <hr className="hr-right" />
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
                <div className="row submit-row">
                    <div className="col-md-12">
                        <If condition={this.state.signUpStatus.status == C.FAILURE}>
                            <div>{this.state.signUpStatus.errors.join(', ')}</div>
                        </If>
                        <span onClick={ () => this.submit()} className="submit-button purple-text">Sign In</span>
                        <a href="" className="help-text bold-link">Forgot your password?</a>
                    </div>
                </div>
            </div>
        </div>;
    }
}

render(<Login/>, document.getElementById('app'));