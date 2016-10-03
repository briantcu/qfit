import React from 'react';
import {render} from 'react-dom';
import Avatar from 'views/common/avatar';

class FeedItem extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="gray-border message-row">
            <div className="them">
                <div className="avi-wrap">
                    <Avatar user={this.props.item.poster} />
                </div>
                <div className="message-wrap">
                    <div>
                        {this.props.item.poster.username}
                    </div>
                    <div className="message-date">
                        {this.props.item.created_at}
                    </div>
                    <div className="message-text">
                        {this.props.item.message}
                    </div>
                </div>
            </div>
        </div>;
    }
}
export default FeedItem;