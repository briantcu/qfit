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
                        <If condition={this.props.user && !this.props.user.hor_push_max > 0}>
                            <span className={ (this.props.activeNav == 'fitness') ? 'bold-text' : null} >Fitness Assessment</span>
                        </If>
                        <span className={ (this.props.activeNav == 'schedule') ? 'bold-text' : null} >Scheduling</span>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Subnav;