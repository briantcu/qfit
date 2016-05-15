import {render} from 'react-dom';
import FancyInput from 'views/common/fancy_input';
import Slider from 'views/common/slider';
import validator from 'validator';
import SignUpActions from 'actions/sign_up_actions';
import SignUpStore from 'stores/sign_up_store';
import C from 'constants/sign_up_constants';

require('sign_up.scss');

class AthleteSignUp extends React.Component {
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
        }
    }

    componentDidMount () {
        SignUpStore.addChangeListener(this.onChange.bind(this));
    }

    componentWillUnmount () {
        SignUpStore.removeChangeListener(this.onChange.bind(this));
    }

    onChange () {
        var data = SignUpStore.getData();
        if (data.signUpStatus.status == C.SUCCESS) {
            location.href = '/next';
        }

        if (!data.isUsernameUnique) {
            this.setState({usernameErrors: ["Username isn't available."]})
        } else {
            this.setState({usernameErrors: []})
        }

        this.setState({
            signUpStatus: data.signUpStatus
        })
    }

    submit () {
        //account_type = "user"
        //password_confirmation = "user"
        //trim all
        //convert sex to lowercase
    }

    evalUsername(username) {
        if (username.length > 4) {
            SignUpActions.usernameCheck(username);
        }
    }

    evalErrors () {
        var hasErrors = false;

    }

    render () {
        return <div className="athlete-sign-up row">
                <div className="col-md-5 col-md-offset-6 col-xs-12 col-xs-offset-0 form">
                    <div className="row">
                        <div className="col-md-12">
                            <h1>Sign up as an Athlete</h1>
                            <a href="" className="info-text subtle-link">Are you a coach? Sign up here.</a>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className="fb-button text-center">Sign up with Facebook</span>
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
                                <Slider ref="sex" checked="Female" unchecked="Male"/>
                            </span>
                        </div>
                    </div>
                    <div className="row submit-row">
                        <div className="col-md-12">
                            <If condition={this.state.signUpStatus.status == C.FAILURE}>
                                <div>{this.signUpStatus.errors.join(', ')}</div>
                            </If>
                            <span onClick={ () => this.submit()} className="submit-button purple-text">Sign Up</span>
                            <a href="" className="help-text bold-link">Have an account? Login here.</a>
                        </div>
                    </div>
                </div>
            </div>;
    }
}

render(<AthleteSignUp/>, document.getElementById('app'));