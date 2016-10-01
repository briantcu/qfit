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
            <div className="col-xs-8 text-right">
                <select ref="chartType" className="form-control">
                    {
                        this.props.teams.map(function(t, index){
                            return <option key={index} value={t.name}>{t.name}</option>
                        }.bind(this))
                    }
                </select>
                <select ref="chartType" className="form-control">
                    <option value="0">PowerLean</option>
                    <option value="1">PowerMass</option>
                    <option value="2">PowerRip</option>
                </select>
                <If condition={!this.props.onTeam}>
                    <span>View Workout</span>
                    <span>|</span>
                    <span>Delete Individual</span>
                </If>
            </div>
        </div>;
    }
}
export default Athlete;