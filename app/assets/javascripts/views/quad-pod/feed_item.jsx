import React from 'react';
import {render} from 'react-dom';
import Avatar from 'views/common/avatar';
import Util from 'helpers/util';

require('views/quad-pod/feed-item.scss');

class FeedItem extends React.Component {

    constructor(props) {
        super(props);
    }

    getMessageHtml() {
        var html = this.props.message;
        return {__html: html};
    }

    render () {
        return <div className="gray-border message-row">
            <div className="them">
                <div className="avi-wrap">
                    <Avatar user={this.props.poster} />
                </div>
                <div className="message-wrap">
                    <div>
                        {this.props.poster.user_name}
                    </div>
                    <div className="message-date">
                        {Util.formatFullDate(this.props.created_at)}
                    </div>
                    <div className="message-text">
                        <If condition={this.props.stripHtml} >
                            {this.props.message}
                        </If>
                        <If condition={!this.props.stripHtml} >
                            <div dangerouslySetInnerHTML={this.getMessageHtml()} />
                        </If>
                    </div>
                </div>
            </div>
        </div>;
    }
}
export default FeedItem;