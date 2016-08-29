import React from 'react';
import {render} from 'react-dom';

class FeedItem extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="gray-border">
            <span>Avatar</span>
            <span>x</span>
        </div>;
    }
}
export default FeedItem;