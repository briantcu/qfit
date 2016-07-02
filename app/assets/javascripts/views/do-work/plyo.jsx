import {render} from 'react-dom';
import Thumbnail from 'views/do-work/thumbnail'
import VertCircleCheck from 'views/common/vert_circle_check'

require('views/do-work/plyo.scss');

class Plyo extends React.Component {
    constructor(props) {
        super(props);
    }

    change(elem) {
        var check = this.refs[elem.target.id];
        var checked = check.getValue();
    }

    render() {
        var classes = (this.props.border) ? 'plyo exercise row top-border' : 'plyo exercise row';
        return <div className={classes} >
            <div className="col-xs-5">
                <Thumbnail exercise={this.props.exercise.plyometric} />
                <span className="ex-info">
                    <div className="ex-name">{this.props.exercise.plyometric.name}</div>
                    <div className="ex-subtext">Recommended: {this.props.exercise.plyometric.recommended}</div>
                    <div className="ex-subtext"><u className="link">Read Tips</u> | <u className="link">Swap</u> | <u className="link">Delete</u></div>
                </span>
            </div>
            <div className="col-xs-1 col-xs-offset-4">
                <VertCircleCheck ref={this.props.exercise.id + '1'} id={this.props.exercise.id + '1'}
                                 defaultChecked={this.props.exercise.completed} label={'Complete'} change={ this.change } />
            </div>
            <div className="col-xs-1">
                <VertCircleCheck ref={this.props.exercise.id + '2'} id={this.props.exercise.id + '2'}
                                 defaultChecked={this.props.exercise.completed} label={'Complete'} change={ this.change } />
            </div>
            <div className="col-xs-1">
                <VertCircleCheck ref={this.props.exercise.id + '3'} id={this.props.exercise.id + '3'}
                                 defaultChecked={this.props.exercise.completed} label={'Complete'} change={ this.change } />
            </div>
        </div>
    }
}

export default Plyo;