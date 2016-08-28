import {render} from 'react-dom';

require('views/quad-pod/feed.scss');

class Feed extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="qp-section feed">
            <div className="sec-header">Your Feed</div>
            <div className="sec-main"></div>
        </div>;
    }


}

export default Feed;