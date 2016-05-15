import React from 'react';
import {render} from 'react-dom';
import FancyInput from 'views/common/fancy_input';
import Slider from 'views/common/slider';
import validator from 'validator';

require('sign_up.scss');

class AthleteSignUp extends React.Component {
    submit () {
        //account_type = "user"
        //password_confirmation = "user"
        //trim all
        //convert sex to lowercase
    }

    evalUsername(username) {
        //call to see if username is unique
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
                            <span className="purple-bot-container">
                                <FancyInput ref="username" name="displayed_user_name" placeholder="Username" type="text"
                                changedCallback={this.evalUsername} />
                            </span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className="purple-bot-container">
                                <FancyInput ref="firstName" name="first_name" placeholder="First Name" type="text"/>
                            </span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className="purple-bot-container">
                                <FancyInput ref="lastName" name="last_name" placeholder="Last Name" type="text"/>
                            </span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className="purple-bot-container">
                                <FancyInput ref="email" name="email" placeholder="Email Address" type="text"/>
                            </span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className="purple-bot-container">
                                <FancyInput ref="password" name="password" placeholder="Password" type="password"/>
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
                            <span onClick={ () => this.submit()} className="submit-button purple-text">Sign Up</span>
                            <a href="" className="help-text bold-link">Have an account? Login here.</a>
                        </div>
                    </div>
                </div>
            </div>;
    }
}

render(<AthleteSignUp/>, document.getElementById('app'));