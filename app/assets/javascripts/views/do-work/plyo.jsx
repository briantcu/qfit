import {render} from 'react-dom';

require('views/do-work/plyo.scss');

class Plyo extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <div className="plyo row" >
            Plyo
        </div>
    }
}

export default Plyo;