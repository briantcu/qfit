import {render} from 'react-dom';
import Thumbnail from 'views/do-work/thumbnail'
import VertCircleCheck from 'views/common/vert_circle_check'

require('views/do-work/stretch.scss');

class Stretch extends React.Component {
    constructor(props) {
        super(props);
        this.change = this.change.bind(this);
    }

    change(elem) {
        var check = this.refs.complete;
        var completed = check.getValue();
    }

    render() {
        var classes = (this.props.border) ? 'stretch exercise row top-border' : 'stretch exercise row';
        return <div className={classes}>
            <div className="col-xs-5">
                <Thumbnail exercise={this.props.exercise.warmup} />
                <span className="ex-info">
                    <div className="ex-name">{this.props.exercise.warmup.name}</div>
                    <div className="ex-subtext">Recommended: {this.props.exercise.warmup.is_stretch ? '3 x 30 seconds' : '5 minutes'} </div>
                    <div className="ex-subtext"><u className="link">Read Tips</u> | <u className="link">Swap</u> | <u className="link">Delete</u></div>
                </span>
            </div>
            <div className="col-xs-1 col-xs-offset-6">
                <VertCircleCheck ref="complete" id={'stretch' + this.props.exercise.id}
                             defaultChecked={this.props.exercise.completed} label={'Complete'} change={ this.change } />
            </div>
        </div>
    }
}

export default Stretch;