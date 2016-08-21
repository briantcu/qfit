import {render} from 'react-dom';
import VertCircleCheck from 'views/common/vert_circle_check';
import RoutineActions from 'actions/routine_actions';
import RoutineConstants from 'constants/routine_constants';

class WeightSet extends React.Component {
    constructor(props) {
        super(props);
        this.change = this.change.bind(this);
        this.showErrorState = this.showErrorState.bind(this);
    }

    change (e) {
        if (this.props.exercise.for_time) {
            var completed = this.refs.reps.getValue();
            var reps = completed ? 1 : 0;
            RoutineActions.storeResults(RoutineConstants.WEIGHTS, this.props.exercise.id, this.props.setNum, reps, 0);
        } else if ((this.props.exercise.category == 7 && (this.props.weightSet.rec_weight == 0)) || this.props.exercise.category == 3) {
            var reps = this.refs.value;
            var weight = 0;
            if (isNaN(reps) && reps && reps.length > 0) {
                this.showErrorState();
            } else {
                RoutineActions.storeResults(RoutineConstants.WEIGHTS, this.props.exercise.id, this.props.setNum, reps, 0);
            }

        } else {
            var reps = this.refs.reps.value;
            var weight = this.refs.weight.value;
            if ((isNaN(reps) && reps && reps.length > 0) || (isNaN(weight) && weight && weight.length > 0)) {
                this.showErrorState();
            } else {
                RoutineActions.storeResults(RoutineConstants.WEIGHTS, this.props.exercise.id, this.props.setNum, reps, weight);
            }
        }
    }

    showErrorState() {
        alert('not valid!')
    }

    render() {
        var classes = this.props.gray ? 'weight-set gray' : 'weight-set';
        return <div className={classes} >
            <Choose>
                <When condition={this.props.exercise.for_time} >
                    <span className="double">
                       30 seconds
                    </span><br/>
                    <span className="double">
                        <VertCircleCheck ref="reps" id={this.props.weightSet.id + 'reps'}
                                         defaultChecked={this.props.exercise.completed} label={'Complete'} onBlur={ this.change } />
                    </span>
                </When>
                <When condition={(this.props.exercise.category == 7 && (this.props.weightSet.rec_weight == 0)) || this.props.exercise.category == 3} >
                    <span className="double">
                            Max Reps
                    </span><br/>
                    <span className="double">
                        <input ref="reps" type='text' className="transparent-input standard-text" id={this.props.weightSet.id + 'reps'}
                               onBlur={this.change} defaultValue={this.props.weightSet.perf_reps} />
                        <label for={this.props.weightSet.id + 'reps'} >reps</label>
                    </span>
                </When>
                <Otherwise>
                    <span className="col">
                        {this.props.weightSet.rec_weight} lbs
                    </span>
                    <span className="col">
                        {this.props.weightSet.rec_reps} reps
                    </span><br/>
                    <span className="col">
                        <input ref="weight" type='text' className="transparent-input standard-text" id={this.props.weightSet.id + 'weight'}
                               onBlur={this.change} defaultValue={this.props.weightSet.perf_weight} />
                        <label for="{this.props.weightSet.id + 'weight'}">lbs</label>
                    </span>
                    <span className="col">
                        <input ref="reps" type='text' className="transparent-input standard-text" id={this.props.weightSet.id + 'reps'}
                               onBlur={this.change} defaultValue={this.props.weightSet.perf_reps} />
                        <label for={this.props.weightSet.id + 'reps'} >reps</label>
                    </span>
                </Otherwise>
            </Choose>
        </div>
    }
}

export default WeightSet;