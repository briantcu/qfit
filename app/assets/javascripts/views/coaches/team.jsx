import React from 'react';
import {render} from 'react-dom';
import Athlete from 'views/coaches/athlete';

require('views/coaches/team.scss');

class Team extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="team">
            <div className="row">
                <div className="col-xs-4 first team-name">{this.props.team.name}</div>
                <div className="col-xs-8 text-right">
                    <span>Let group see each other's workouts</span>
                    <span>|</span>
                    <span>View Workout</span>
                    <span>|</span>
                    <span>Delete Group</span>
                </div>
            </div>
            {
                this.props.team.players.map(function(e) {
                    return <Athlete athlete={e} key={e.id} onTeam={true} teams={this.props.teams}/>
                }.bind(this))
            }
        </div>;
    }
}
export default Team;