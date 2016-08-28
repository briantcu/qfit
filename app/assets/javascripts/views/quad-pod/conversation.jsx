import {render} from 'react-dom';
import UserActions from 'actions/user_actions';

class Conversation extends React.Component {

    constructor(props) {
        super(props);
        this.sendDM = this.sendDM.bind(this);
    }


    sendDM (receiverId) {
        var message = this.refs.messageBox.value.trim();
        if (message) {
            UserActions.sendDM(receiverId);
        }
    }

    render () {
        return  <span>
                <div className="sec-header">{this.props.conversation.user.user_name}</div>
                <div className="sec-main">
                    <Choose>
                        <When condition={this.props.conversation && this.props.conversation.messages.length > 0}>
                            {
                                this.props.conversation.messages.map(function (e) {
                                    return <div className="friend gray-border">
                                        <Choose>
                                            <When condition={e.poster_id == this.props.user.id}>
                                                <span>{}</span>
                                                <span>{e.message}</span>
                                                <span>{e.created_at}</span>
                                            </When>
                                            <Otherwise >
                                                <span>{}</span>
                                                <span>{e.message}</span>
                                                <span>{e.created_at}</span>
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
                        <textarea ref="messageBox" className="" rows="5" cols="40"></textarea>
                        <span onClick={() => this.sendDM(this.props.conversation.user.id)}>Click </span>
                    </div>
                </div>
            </span>;
    }


}

export default Conversation;