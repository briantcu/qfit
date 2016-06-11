import {render} from 'react-dom';

require('views/setup/schedule.scss');

class Schedule extends React.Component {
    constructor(props) {
        super(props);
    }

    render () {
        return <div className="schedule">
            <div className="row">
                <div className="container">
                    <If condition={this.props.quads.strength}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                {this.props.suggested_schedule.num_weight_days}
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.quads.plyos}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                {this.props.suggested_schedule.num_plyo_days}
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.quads.sprinting}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                {this.props.suggested_schedule.num_sprint_days}
                            </div>
                        </div>
                    </If>
                </div>
            </div>
        </div>
    }

}

export default Schedule;
