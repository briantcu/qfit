import {render} from 'react-dom';

require('views/quad-pod/friends.scss');

class Friends extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="qp-section friends">
            <div className="sec-header">Your Pod</div>
            <div className="sec-main"></div>
        </div>;
    }


}

export default Friends;