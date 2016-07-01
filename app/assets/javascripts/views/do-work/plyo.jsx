import {render} from 'react-dom';
import Thumbnail from 'views/do-work/thumbnail'

require('views/do-work/plyo.scss');

class Plyo extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <div className="plyo exercise row" >
            <Thumbnail exercise={this.props.exercise.plyometric} />
        </div>
    }
}

export default Plyo;