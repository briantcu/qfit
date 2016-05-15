import React from 'react';
import {render} from 'react-dom';
import FancyInput from 'views/common/fancy_input';
import Slider from 'views/common/slider';
require('sign_up.scss');

class AthleteSignUp extends React.Component {
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
                                <FancyInput/>
                            </span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className="purple-bot-container">
                                <FancyInput/>
                            </span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className="purple-bot-container">
                                <FancyInput/>
                            </span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className="purple-bot-container">
                                <FancyInput/>
                            </span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className="purple-bot-container">
                                <FancyInput/>
                            </span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            <span className="purple-bot-container">
                                <Slider />
                            </span>
                        </div>
                    </div>
                    <div className="row submit-row">
                        <div className="col-md-12">
                            <span className="submit-button purple-text">Sign Up</span><a href="" className="help-text bold-link">Have an account? Login here.</a>
                        </div>
                    </div>
                </div>
            </div>;
    }
}

render(<AthleteSignUp/>, document.getElementById('app'));