import React from 'react';
import {render} from 'react-dom';

require('views/coaches/athlete.scss');

class Athlete extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="athlete row">
            <div className="col-xs-12"> athlete</div>
        </div>;
    }
}
export default Athlete;