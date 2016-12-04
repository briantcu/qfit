import {render} from 'react-dom';
import FancyInput from 'views/common/fancy_input';
import Slider from 'views/common/slider';
import validator from 'validator';
import SignUpActions from 'actions/sign_up_actions';
import SignUpStore from 'stores/sign_up_store';
import C from 'constants/sign_up_constants';

require('pages/forgot.scss');

class Forgot extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            pwResetStatus: {status: '', errors: []},
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

        this.setState({
            pwResetStatus: data.pwResetStatus,
            formSubmitted: false
        });
    }

    submit () {
        if (!this.state.formSubmitted) {
            this.state.formSubmitted = true;
            if (!this.hasErrors()) {
                SignUpActions.forgotPassword(this.refs.email.getValue());
            } else {
                this.state.formSubmitted = false;
            }
        }
    }

    hasErrors () {
        var hasErrors = false;

        var email = this.refs.email.getValue();
        if (!validator.isEmail(email)) {
            this.setState({emailErrors: ['Please enter a valid email']});
            hasErrors = true;
        }

        return hasErrors;
    }

    fbLogin() {
        location.href = '/users/auth/facebook';
    }

    render () {
        return <div className="forgot row">
            <div className="col-md-6 col-md-offset-5 col-lg-5 col-lg-offset-6  col-xs-8 col-xs-offset-4 form">
                <div className="row">
                    <div className="col-md-12">
                        <h1>Forgot password?</h1>
                        <span className="subtext">Or register as a <a href="/sign-up-coach" className="info-text subtle-link">Coach</a> or an <a href="/sign-up" className="info-text subtle-link">Athlete</a></span>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-12">
                            <span className={`purple-container ${this.state.emailErrors.length > 0 ? 'error' : null}`}>
                                <FancyInput ref="email" name="email" placeholder="Email Address" type="text"
                                            errors={this.state.emailErrors} />
                            </span>
                    </div>
                </div>
                <div className="row submit-row">
                    <div className="col-md-12">
                        <If condition={this.state.pwResetStatus.status == C.FAILURE}>
                            <div className="error-text">{this.state.pwResetStatus.errors}</div>
                        </If>
                        <If condition={this.state.pwResetStatus.status == C.SUCCESS}>
                            <div>We just sent you an email with a password reset link!</div>
                        </If>
                        <span onClick={ () => this.submit()} className="submit-button purple-text">Reset Password</span>
                        <div className="visible-xs"><br/></div>
                        <a href="/sign-in" className="help-text bold-link">Or sign in to your account</a>
                    </div>
                </div>
            </div>
        </div>;
    }
}

render(<Forgot/>, document.getElementById('app'));