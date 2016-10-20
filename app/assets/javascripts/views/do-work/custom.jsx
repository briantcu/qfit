import {render} from 'react-dom';
import RoutineActions from 'actions/routine_actions';
import RoutineConstants from 'constants/routine_constants';
import FancyInput from 'views/common/fancy_input';

require('views/do-work/custom.scss');

class Custom extends React.Component {
    constructor(props) {
        super(props);
        this.delete = this.delete.bind(this);
        this.changed = this.changed.bind(this);
    }

    delete() {
        var r=confirm("Are you sure you want to remove this exercise?");
        if (r==true) {
            RoutineActions.deleteExercise('custom', this.props.exercise.id);
        }
    }

    changed(details) {
        RoutineActions.storeResults(RoutineConstants.CUSTOM, this.props.exercise.id, null, null, null, details);
    }

    render() {
        return <div className="custom exercise row top-border" >
            <div className="col-xs-6">
                <span className="thumb">
                    <img width="120" height="90" src="https://s3.amazonaws.com/quadfit/custom-icon.png" />
                </span>
                <span className="ex-info">
                    <div className="ex-name">{this.props.exercise.name}</div>
                    <div className="ex-subtext">
                        <u className="link" onClick={ () => this.delete()} >Delete</u>
                    </div>
                </span>
            </div>
            <div className="col-xs-6 custom-input">
                <FancyInput ref="details" name="details" placeholder="Enter Details" type="text" value={this.props.exercise.details}
                changedCallback={this.changed} />
            </div>
        </div>
    }
}

export default Custom;