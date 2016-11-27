import React from 'react';
import {render} from 'react-dom';
import Athlete from 'views/coaches/athlete';
import CoachActions from 'actions/coach_actions';

require('views/coaches/team.scss');

class Team extends React.Component {

    constructor(props) {
        super(props);
        this.delete = this.delete.bind(this);
    }

    delete(id) {
        var r = confirm("Are you sure? All members of this team will transition to your Athletes section.");
        if (r == true) {
            CoachActions.deleteTeam(id);
        }
    }

    render () {
        return <div className="team">
            <div className="row">
                <div className="col-sm-4 col-xs-12 first team-name">{this.props.team.name}</div>
                <div className="col-sm-8 col-xs-12 text-right last">
                    <span className="actions">
                        <span className="norm-link" onClick={() => this.props.viewTeam(this.props.team.id)}>View Workout</span>
                        <span className="separator">|</span>
                        <span className="norm-link" onClick={() => this.delete(this.props.team.id)}>Delete Team</span>
                    </span>
                </div>
            </div>
            {
                this.props.team.players.map(function(e) {
                    return <Athlete athlete={e} key={e.id} onTeam={true} teams={this.props.teams} viewAthlete={this.props.viewAthlete}
                    team_id={this.props.team.id} />
                }.bind(this))
            }
        </div>;
    }
}
export default Team;