import {render} from 'react-dom';

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
                <span className="col">
                        {this.props.weightSet.rec_weight} lbs
                </span>
                <span className="col">
                        {this.props.weightSet.rec_reps} reps
                </span><br/>
                <span>
                    <input ref="weight" type='text' className="transparent-input standard-text" id={this.props.weightSet.id + 'weight'}
                           onChange={this.props.onChange} defaultValue={this.props.perf_weight}/>
                    <label for="{this.props.weightSet.id + 'weight'}">lbs</label>
                </span>
                <span>
                    <input ref="reps" type='text' className="transparent-input standard-text" id={this.props.weightSet.id + 'reps'}
                           onChange={this.props.onChange} defaultValue={this.props.perf_reps}/>
                    <label for={this.props.weightSet.id + 'reps'} >reps</label>
                </span>
        </div>
    }
}

export default WeightSet;