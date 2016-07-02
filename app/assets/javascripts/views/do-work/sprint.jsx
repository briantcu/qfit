import {render} from 'react-dom';
import VertCircleCheck from 'views/common/vert_circle_check'

require('views/do-work/sprint.scss');

class Sprint extends React.Component {
    constructor(props) {
        super(props);
        this.change = this.change.bind(this);
    }

    change(e) {
        var check = this.refs[e.target.id];
        var checked = check.getValue();
    }

    render() {
        return <div className="sprint exercise row" >
            <div className="col-xs-12">
                <div className="row">
                    <span className="ex-info col-xs-12">
                        <div className="ex-name">{this.props.exercise.sprint.name}</div>
                    </span>
                </div>
                {
                    this.props.exercise.sprint_details.map(function(e, index) {
                        return <div className="row detail-row">
                                <div className="col-xs-4 detail">{e.detail}</div>
                                <div className="col-xs-8">
                                    <VertCircleCheck ref={this.props.exercise.laps[index].id} id={this.props.exercise.laps[index].id}
                                                     defaultChecked={this.props.exercise.laps[index].completed}
                                                     label={'Complete'} change={ this.change } />
                                </div>
                            </div>
                    }.bind(this))
                }
            </div>
        </div>
    }
}

export default Sprint;