import React from 'react';
import {render} from 'react-dom';
import FancyInput from 'views/common/fancy_input'
require('sign_up.scss');

class AthleteSignUp extends React.Component {
    render () {
        return <div className="athlete-sign-up row">
                <div className="col-xs-5 col-xs-offset-6 form">
                    <div className="row">
                        <div className="col-xs-12">
                            <h1>Sign up as an Athlete</h1>
                            <a href="" className="form-info">Are you a coach? Sign up here.</a>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <span className="fb-button text-center">Sign up with Facebook</span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12 text-center">
                            <span className="text-uppercase form-info">or sign up with an email address</span>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <FancyInput/>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <FancyInput/>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <FancyInput/>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <FancyInput/>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <FancyInput/>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            Slider
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            Button
                        </div>
                    </div>
                </div>
            </div>;
    }
}

render(<AthleteSignUp/>, document.getElementById('app'));