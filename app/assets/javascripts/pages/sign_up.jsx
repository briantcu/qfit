import React from 'react';
import {render} from 'react-dom';
require('sign_up.scss');

class AthleteSignUp extends React.Component {
    render () {
        return <div className="athlete-sign-up row">
                <div className="col-xs-6">
                    <img src="https://s3.amazonaws.com/quadfit/runner-13.png" className="img-responsive"/>
                </div>
            </div>;
    }
}

render(<AthleteSignUp/>, document.getElementById('app'));