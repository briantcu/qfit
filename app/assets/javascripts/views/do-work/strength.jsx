import {render} from 'react-dom';
import Thumbnail from 'views/do-work/thumbnail'

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
                    <div className="ex-name">{this.props.exercise.exercise.name}</div>
                    <div className="ex-subtext">Recommended:  </div>
                </span>
            </div>
        </div>
    }
}

export default Strength;