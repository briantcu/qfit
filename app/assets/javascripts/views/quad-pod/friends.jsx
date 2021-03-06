import {render} from 'react-dom';
import Avatar from 'views/common/avatar';
import UserActions from 'actions/user_actions';

require('views/quad-pod/friends.scss');

class Friends extends React.Component {

    constructor(props) {
        super(props);
    }

    removeFriend(id) {
        var r=confirm("Are you sure you want to remove this person from your Quad Pod?");
        if (r==true) {
            UserActions.unfriend(id);
        }
    }

    render () {
        if (this.props.quad_pod_loading) {
            return <div className="qp-section friends loading">
                <div className="sec-header">Loading...</div>
            </div>;
        }

        return <div className="qp-section friends">
            <div className="sec-header">Your Pod</div>
            <div className="sec-main">
                <Choose>
                <When condition={this.props.quad_pod && this.props.quad_pod.length > 0} >
                        {
                            this.props.quad_pod.map(function(e) {
                                return <div key={e.id} className="friend gray-border">
                                    <span className="flag" onClick={ () => this.props.showConversation(e.id)}>
                                        <If condition={e.unseen_count > 0}>
                                            <span className="unseen-bubble">{e.unseen_count}</span>
                                        </If>
                                    </span>
                                    <span className="avi-wrap"><Avatar user={e}/></span>
                                    <span className="username">{e.user_name}</span>
                                    <div className="visible-micro"><br/></div>
                                    <span className="pi">PowerIndex: {(e.power_index) ? e.power_index : 0}</span>
                                    <span className="remove" onClick={() => this.removeFriend(e.id)}><img src="https://dwx350bwdtt59.cloudfront.net/X.png"/></span>
                                </div>
                            }.bind(this))
                        }
                </When>
                <Otherwise >
                    <div>You don't have anyone in your Quad Pod yet. Invite friends below!
                    </div>
                </Otherwise>
                </Choose>
            </div>
        </div>;
    }


}

export default Friends;