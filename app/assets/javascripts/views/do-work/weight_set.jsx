import {render} from 'react-dom';
import VertCircleCheck from 'views/common/vert_circle_check';

class WeightSet extends React.Component {
    constructor(props) {
        super(props);
        this.change = this.change.bind(this);
    }

    change (e) {

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
                        <VertCircleCheck ref={this.props.exercise.id + '3'} id={this.props.exercise.id + '3'}
                                         defaultChecked={this.props.exercise.completed} label={'Complete'} change={ this.change } />
                    </span>
                </When>
                <When condition={(this.props.exercise.category == 7 && (this.props.weightSet.rec_weight == 0)) || this.props.exercise.category == 3} >
                    <span className="double">
                            Max Reps
                    </span><br/>
                    <span className="double">
                        <input ref="reps" type='text' className="transparent-input standard-text" id={this.props.weightSet.id + 'reps'}
                               onChange={this.props.onChange} defaultValue={this.props.perf_reps}/>
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
                               onChange={this.props.onChange} defaultValue={this.props.perf_weight}/>
                        <label for="{this.props.weightSet.id + 'weight'}">lbs</label>
                    </span>
                    <span className="col">
                        <input ref="reps" type='text' className="transparent-input standard-text" id={this.props.weightSet.id + 'reps'}
                               onChange={this.props.onChange} defaultValue={this.props.perf_reps}/>
                        <label for={this.props.weightSet.id + 'reps'} >reps</label>
                    </span>
                </Otherwise>
            </Choose>
        </div>
    }
}

export default WeightSet;