import React from 'react';
import {render} from 'react-dom';
import CoachActions from 'actions/coach_actions';

require('views/coaches/athlete.scss');

class Athlete extends React.Component {

    constructor(props) {
        super(props);
        this.changeTeam = this.changeTeam.bind(this);
        this.delete = this.delete.bind(this);
    }

    changeTeam(e) {
        CoachActions.changeTeam(e.target.value, this.props.athlete.id);
    }

    delete() {
        var r = confirm("Are you sure? This can't be undone.");
        if (r == true) {
            CoachActions.deleteUser(this.props.athlete.id);
        }
    }

    render () {
        return <div className="athlete row">
            <div className={(!this.props.onTeam) ? "col-xs-4 first" : "col-xs-3 col-xs-offset-1 first"}>
                {this.props.athlete.first_name} {this.props.athlete.last_name}
            </div>
            <div className="col-xs-8 text-right last">
                <select className="form-control" defaultValue={this.props.team_id} onChange={this.changeTeam}>
                    <option value='0'>No Team</option>
                    {
                        this.props.teams.map(function(t, index){
                            return <option key={t.id} value={t.id}>{t.name}</option>
                        }.bind(this))
                    }
                </select>
                <span className="actions">
                    <span className="norm-link" onClick={() => this.props.viewAthlete(this.props.athlete.id)}>View Workout/Progress</span>
                    <span className="separator">|</span>
                    <span className="norm-link" onClick={this.delete}>Delete Individual</span>
                </span>
            </div>
        </div>;
    }
}
export default Athlete;