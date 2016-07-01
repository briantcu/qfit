import {render} from 'react-dom';

require('views/do-work/strength.scss');

class Strength extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <div className="strength row" >
            Strength
        </div>
    }
}

export default Strength;