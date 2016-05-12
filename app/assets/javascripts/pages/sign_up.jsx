import React from 'react';
import {render} from 'react-dom';
require('sign_up.scss');

class AthleteSignUp extends React.Component {
    render () {
        return <div className="athlete-sign-up row">
                <div className="col-xs-6">
                    <img src="https://s3.amazonaws.com/quadfit/runner-13.png" className="img-responsive"/>
                </div>
                <div className="col-xs-5">
                    <div className="row">
                        <div className="col-xs-12">
                            Sign up as an Athlete
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            Sign up with Facebook
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            or sign up with an email address
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <input type="text" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <input type="text" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <input type="text" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <input type="text" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12">
                            <input type="text" />
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