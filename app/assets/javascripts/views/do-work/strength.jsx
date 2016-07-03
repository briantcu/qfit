import {render} from 'react-dom';
import Thumbnail from 'views/do-work/thumbnail';
import WeightSet from 'views/do-work/weight_set';
import VertCircleCheck from 'views/common/vert_circle_check';

require('views/do-work/strength.scss');

class Strength extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        var classes = (this.props.border) ? 'strength exercise row top-border' : 'strength exercise row';
        return <div className={classes} >
            <div className="col-xs-5">
                <Thumbnail exercise={this.props.exercise.exercise} />
                <span className="ex-info">
                    <div className="type-name">{this.props.exercise.exercise_type.type_name}</div>
                    <div className="ex-name">{this.props.exercise.exercise.name}</div>
                    <div className="ex-subtext">Rest for {this.props.exercise.rest_period} seconds between sets </div>
                    <div className="ex-subtext"><u className="link">Read Tips</u> | <u className="link">Swap</u> | <u className="link">Delete</u></div>
                </span>
            </div>
            <div className="col-xs-7">
                {
                    this.props.exercise.weight_sets.map(function(e, index) {
                        return <WeightSet weightSet={e} gray={index % 2 == 0} key={this.props.exercise.id + '' + (index + 1)} />;
                    }.bind(this))
                }
            </div>
        </div>
    }
}

export default Strength;