import {render} from 'react-dom';
import Button from 'views/common/button';
import CoachActions from 'actions/coach_actions';

require('views/setup/coach.scss');

class Coach extends React.Component {
    constructor(props) {
        super(props);
    }

    buttonClicked(option) {
        CoachActions.createTempTeam(option == 'team');
    }

    render () {
        return <div className="coach metal-bg">

            <div className="row no-margin">
                <div className="container">
                    <div className="row title-row">
                        <div className="col-xs-12 text-center">
                            <h1>Let's Create a Plan</h1>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12 col-sm-6 col-sm-offset-3 text-center">
                            Make a Selection
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12 col-sm-6 col-sm-offset-3 text-center desc">
                            If you'd like to create a workout plan for a team, like a Varsity Basketball team, choose this option.
                            Later you'll be able to invite players to join this team on Quadfit, and they'll automatically get the workout we're about to create.<br/>
                            <Button buttonText="Create a Team Plan" onClick={ () => this.buttonClicked('team') } />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12 col-sm-6 col-sm-offset-3 text-center">
                            <hr className="hr-left" />
                            <span className="text-uppercase info-text">or</span>
                            <hr className="hr-right" />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12 col-sm-6 col-sm-offset-3 text-center desc">
                            If you'd like to create a plan for an individual, choose this option. Later we'll send them an email or text, which they'll use
                            to sign up for Quadfit. They will automatically get the workout we're about to create.<br/>
                            <Button buttonText="Create a Plan for an Individual" onClick={ () => this.buttonClicked('individual') } />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}
Coach.displayName = 'Coach';

export default Coach;
