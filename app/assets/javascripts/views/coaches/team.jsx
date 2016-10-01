import React from 'react';
import {render} from 'react-dom';

require('views/coaches/team.scss');

class Team extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="team">
            <div className="row">
                <div className="col-xs-12 first team-name">{this.props.team.name}</div>
            </div>
        </div>;
    }
}
export default Team;