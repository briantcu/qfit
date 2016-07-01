import {render} from 'react-dom';

require('views/do-work/stretch.scss');

class Stretch extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <div className="stretch row">
            Stretch
        </div>
    }
}

export default Stretch;