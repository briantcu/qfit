import {render} from 'react-dom';
import Thumbnail from 'views/do-work/thumbnail'

require('views/do-work/stretch.scss');

class Stretch extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <div className="stretch exercise row">
            <Thumbnail exercise={this.props.exercise.warmup} />
        </div>
    }
}

export default Stretch;