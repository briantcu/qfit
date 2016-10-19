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
        return <div className="gray-border feed-item">
            <div className="row them">
                <div className="col-xs-12">
                    <span className="avi-wrap"><Avatar user={this.props.poster} /></span>
                    <span className="poster-detes">
                        <div className="poster-name">
                            {this.props.poster.user_name}
                        </div>
                        <div className="message-date">
                            {Util.formatFullDate(this.props.created_at)}
                        </div>
                    </span>
                </div>
            </div>
            <div className="row">
                <div className="message-text col-xs-12">
                    <If condition={this.props.stripHtml} >
                        {this.props.message}
                    </If>
                    <If condition={!this.props.stripHtml} >
                        <div dangerouslySetInnerHTML={this.getMessageHtml()} />
                    </If>
                </div>
            </div>
        </div>;
    }
}
export default FeedItem;