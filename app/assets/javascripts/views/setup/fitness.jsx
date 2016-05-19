import {render} from 'react-dom';

require('views/setup/fitness.scss');

class Fitness extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="row subnav">
            <div className="container">
                <div className="row">
                    <div className="col-xs-1 col-xs-offset-3 text-center bold-text">
                        Setup
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Fitness;