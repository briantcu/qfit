import {render} from 'react-dom';

require('views/setup/subnav.scss');

class Subnav extends React.Component {
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
                    <div className="col-xs-2 text-center">
                        Fitness Assessment
                    </div>
                    <div className="col-xs-2 text-center">
                        Program Selection
                    </div>
                    <div className="col-xs-2 text-center">
                        Scheduling
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Subnav;