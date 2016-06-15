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
                    <div className="col-xs-16 text-center">
                        <span className={ (this.props.activeNav == 'setup') ? 'bold-text' : null} >Setup</span>
                        <span className={ (this.props.activeNav == 'fitness') ? 'bold-text' : null} >Fitness Assessment</span>
                        <span className={ (this.props.activeNav == 'schedule') ? 'bold-text' : null} >Scheduling</span>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Subnav;