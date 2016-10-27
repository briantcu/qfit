import {render} from 'react-dom';
import UserActions from 'actions/user_actions';
import Conversation from'views/quad-pod/conversation';
import FeedItem from 'views/quad-pod/feed_item';

require('views/quad-pod/feed.scss');

class Feed extends React.Component {

    constructor(props) {
        super(props);
        this.postToFeed = this.postToFeed.bind(this);
        this.clearInput = this.clearInput.bind(this);
        this.fillPlaceholder = this.fillPlaceholder.bind(this);
    }

    postToFeed () {
        var message = this.refs.messageBox.value.trim();
        if (message) {
            UserActions.postToFeed(message);
        }
    }

    fillPlaceholder() {
        if (this.refs.messageBox.value == '') {
            this.refs.messageBox.value = 'Type a message';
        }
    }

    clearInput() {
        if (this.refs.messageBox.value == 'Type a message') {
            this.refs.messageBox.value = '';
        }
    }

    render () {

        if (this.props.transitioning) {
            return <div className="qp-section feed loading">
                    <div className="sec-header">Loading...</div>
                </div>;
        }

        return <div className="qp-section feed">
                { !this.props.viewingConversation ?
                    <span>
                        <div className="sec-header">Your Feed</div>
                        <div className="sec-main">
                            <div className="post-row">
                                <div className="input-wrap">
                                    <textarea defaultValue="Type a message" ref="messageBox" className="message-box" rows="3"
                                              cols="60" onBlur={this.fillPlaceholder} onFocus={this.clearInput} />
                                    <div onClick={() => this.postToFeed()} className="submit">POST</div>
                                </div>
                            </div>
                            <Choose>
                                <When condition={this.props.feed && this.props.feed.inbox && this.props.feed.inbox.length > 0}>
                                    {
                                        this.props.feed.inbox.map(function (e) {
                                            return <FeedItem
                                                item={e}
                                                key={e.id}
                                                poster={e.poster}
                                                created_at={e.created_at}
                                                message={e.message}
                                            />
                                        }.bind(this))
                                    }
                                </When>
                                <Otherwise>
                                    <div>
                                        Nothing here yet! You will see messages from your Quad Pod and links to their completed
                                        workouts.
                                        You can get things going by posting to this feed with the button above. Everyone in your
                                        Quad Pod will see it!
                                    </div>
                                </Otherwise>
                            </Choose>
                        </div>
                    </span>
                    :
                    <Conversation {...this.props} />
                }
        </div>;
    }
}

export default Feed;