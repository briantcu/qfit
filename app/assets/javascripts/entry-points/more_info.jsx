import {render} from 'react-dom';
import FancyInput from 'views/common/fancy_input';
import Slider from 'views/common/slider';
import validator from 'validator';
import ProfileActions from 'actions/profile_actions';
import SignUpActions from 'actions/sign_up_actions';
import UserActions from 'actions/user_actions';
import SignUpStore from 'stores/sign_up_store';
import ProfileStore from 'stores/profile_store';
import UserStore from 'stores/user_store';
import C from 'constants/sign_up_constants';

require('pages/sign_up.scss');

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
            user: gon.onboarding_user,
            signUpCode: gon.sign_up_code
        };
        this.onChange = this.onChange.bind(this);
        this.evalUsername = this.evalUsername.bind(this);
    }

    componentDidMount () {
        SignUpStore.addChangeListener(this.onChange);
        var that = this;
        $(document).keypress(function(e) {
            if(e.which == 13) {
                that.submit();
            }
        });
    }

    componentWillUnmount () {
        SignUpStore.removeChangeListener(this.onChange);
        $(document).off("keypress");
    }

    onChange () {
        var isUsernameUnique = SignUpStore.getData().isUsernameUnique;
        var signUpStatus = SignUpStore.getData().signUpStatus;

        if (signUpStatus.status == C.SUCCESS) {
            location.href = '/setup/goal';
        }
        this.setState(
            {
                isUsernameUnique: isUsernameUnique,
                signUpStatus: signUpStatus
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
                SignUpActions.signUp(this.packageData());
            } else {
                this.state.formSubmitted = false;
            }
        }
    }

    packageData () {
        var user = {};
        user['first_name'] = this.refs.firstName.getValue();
        user['last_name'] = this.refs.lastName.getValue();
        user['sex'] = this.refs.sex.getValue();
        user['user_name'] = this.refs.username.getValue();
        user['sign_up_code'] = this.refs.signUpCode.getValue();
        return {user: user};
    }

    evalUsername(username) {
        if (username.length > 4) {
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

        return hasErrors;
    }

    render () {
        return <div className="athlete-sign-up row">
            <div className="col-md-5 col-md-offset-6 col-xs-12 col-xs-offset-0 form">
                <div className="row">
                    <div className="col-md-12">
                        <h1>We Need More Info</h1>
                    </div>
                </div>
                <div className="row buffer">
                    <div className="col-md-12 text-center">
                            <span className="purple-bot-container">
                                <hr className="hr-left" />
                                <span className="text-uppercase info-text">Almost done! Just a couple more things</span>
                                <hr className="hr-right" />
                            </span>
                    </div>
                </div>
                <If condition={this.state.user.first_name}>
                    <div className="row">
                        <div className="col-md-12">
                                <span className={`purple-bot-container ${this.state.usernameErrors.length > 0 ? 'error' : null}`}>
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
                                <span className="purple-bot-container">
                                    <Slider ref="sex" checked="female" unchecked="male"/>
                                </span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className={`purple-bot-container`}>
                                <FancyInput ref="signUpCode" name="signUpCode" placeholder="Sign Up Code" type="text"
                                value={this.state.signUpCode} />
                            </span>
                        </div>
                    </div>
                    <div className="row submit-row">
                        <div className="col-md-12">
                            <If condition={this.state.signUpStatus.status == C.FAILURE}>
                                <div>{this.state.signUpStatus.errors.join(', ')}</div>
                            </If>
                            <span onClick={ () => this.submit()} className="submit-button purple-text get-started">Get Started</span>
                        </div>
                    </div>
                </If>
            </div>
        </div>;
    }
}

render(<AthleteSignUp/>, document.getElementById('app'));