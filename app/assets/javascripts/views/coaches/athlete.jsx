import React from 'react';
import {render} from 'react-dom';

require('views/coaches/athlete.scss');

class Athlete extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="athlete row">
            <div className="col-xs-4 first">{this.props.athlete.first_name} {this.props.athlete.last_name}</div>
            <div className="col-xs-8 text-right last">
                <select ref="chartType" className="form-control" defaultValue={this.props.team_id}>
                    <option value='0'>No Team</option>
                    {
                        this.props.teams.map(function(t, index){
                            return <option key={t.id} value={t.id}>{t.name}</option>
                        }.bind(this))
                    }
                </select>
                <select defaultValue={this.props.athlete.program_type_id} ref="chartType" className="form-control">
                    <option value="1">PowerLean</option>
                    <option value="2">PowerMass</option>
                    <option value="3">PowerRip</option>
                </select>
                    <span className="actions">
                        <span className="norm-link" onClick={() => this.props.viewAthlete(this.props.athlete.id)}>View Workout</span>
                        <span className="separator">|</span>
                        <span className="norm-link">Delete Individual</span>
                    </span>
            </div>
        </div>;
    }
}
export default Athlete;