import {render} from 'react-dom';
import UserActions from 'actions/user_actions';
import Avatar from 'views/common/avatar';

require('views/quad-pod/conversation.scss');

class Conversation extends React.Component {

    constructor(props) {
        super(props);
        this.sendDM = this.sendDM.bind(this);
        this.clearInput = this.clearInput.bind(this);
        this.fillPlaceholder = this.fillPlaceholder.bind(this);
    }


    sendDM (receiverId) {
        var message = this.refs.messageBox.value.trim();
        if (message) {
            UserActions.sendDM(receiverId, message);
        }
    }

    clearInput() {
        if (this.refs.messageBox.value == 'Type a message') {
            this.refs.messageBox.value = '';
        }
    }

    fillPlaceholder() {
        if (this.refs.messageBox.value == '') {
            this.refs.messageBox.value = 'Type a message';
        }
    }

    render () {
        return  <div className="conversation">
                <div className="sec-header">{this.props.conversation.user.user_name}</div>
                <div className="sec-main">
                    <Choose>
                        <When condition={this.props.conversation && this.props.conversation.messages.length > 0}>
                            {
                                this.props.conversation.messages.map(function (e) {
                                    return <div key={e.id} className="gray-border message-row">
                                        <Choose>
                                            <When condition={e.poster_id == this.props.user.id}>
                                                <div className="you">
                                                    <div className="message-wrap">
                                                        <div className="message-text">
                                                            {e.message}
                                                        </div>
                                                        <div className="message-date">
                                                            {e.created_at}
                                                        </div>
                                                    </div>
                                                    <div className="avi-wrap">
                                                        <Avatar user={this.props.user} />
                                                    </div>
                                                </div>
                                            </When>
                                            <Otherwise >
                                                <div className="them">
                                                    <div className="avi-wrap">
                                                        <Avatar user={this.props.conversation.user} />
                                                    </div>
                                                    <div className="message-wrap">
                                                        <div className="message-text">
                                                            {e.message}
                                                        </div>
                                                        <div className="message-date">
                                                            {e.created_at}
                                                        </div>
                                                    </div>
                                                </div>
                                            </Otherwise>
                                        </Choose>
                                    </div>
                                }.bind(this))
                            }
                        </When>
                        <Otherwise >
                            <div>
                                Nothing here yet! Send a message below to get things started.
                            </div>
                        </Otherwise>
                    </Choose>
                    <div className="post-row">
                        <div className="input-wrap">
                            <textarea defaultValue="Type a message" ref="messageBox" className="message-box" rows="3"
                                      cols="60" onBlur={this.fillPlaceholder} onFocus={this.clearInput} />
                            <div onClick={() => this.sendDM(this.props.conversation.user.id)} className="submit">SEND</div>
                        </div>
                    </div>
                </div>
            </div>;
    }


}

export default Conversation;