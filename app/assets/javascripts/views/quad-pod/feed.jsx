import {render} from 'react-dom';
import UserActions from 'actions/user_actions';
import Conversation from'views/quad-pod/conversation';
import FeedItem from 'views/quad-pod/feed_item';

require('views/quad-pod/feed.scss');

class Feed extends React.Component {

    constructor(props) {
        super(props);
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
                        <div className="sec-header">Your Feed <span>POST</span></div>
                        <div className="sec-main">
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