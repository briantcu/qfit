import {render} from 'react-dom';

require('views/setup/schedule.scss');

class Schedule extends React.Component {
    constructor(props) {
        super(props);
    }

    render () {
        return <div className="schedule">
            {this.props.suggested_schedule.num_weight_days}
            {this.props.suggested_schedule.num_plyo_days}
            {this.props.suggested_schedule.num_sprint_days}

        </div>
    }

}

export default Schedule;
