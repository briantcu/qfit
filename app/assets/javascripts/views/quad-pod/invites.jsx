import {render} from 'react-dom';
import Avatar from 'views/common/avatar';
import UserActions from 'actions/user_actions';
import Button from 'views/common/button';

class Invites extends React.Component {

    constructor(props) {
        super(props);
        this.accept = this.accept.bind(this);
        this.ignore = this.ignore.bind(this);
    }

    accept(id) {
        UserActions.acceptInvite(id);
    }

    ignore(id) {
        UserActions.ignoreInvite(id);
    }

    render () {
        if (this.props.quad_pod_loading) {
            return <div className="qp-section friends loading">
                <div className="sec-header">Loading...</div>
            </div>;
        }

        return <div className="qp-section">
            <div className="sec-header">Quad Pod Invites</div>
            <div className="sec-main gray-border">
                <If condition={this.props.invites_received && this.props.invites_received.length > 0} >
                    {
                        this.props.invites_received.map(function(e) {
                            return <div className="invite-item container gray-border">
                                <div className="row">
                                    <Avatar user={e} />
                                    <span className="username poster-detes">{e.user_name}</span>
                                </div>
                                <div className="row actions-row text-right">
                                    <Button buttonText="Accept" onClick={() => this.accept(e.id)} inverse={true} />
                                    <Button buttonText="Ignore" onClick={() => this.ignore(e.id)} inverse={true} />
                                </div>
                            </div>
                        }.bind(this))
                    }
                </If>
                <If condition={!this.props.invites_received || this.props.invites_received.length == 0} >
                    Looks like you don't have any pending Quad Pod invites! When someone invites you to
                    join their Quad Pod, you'll see it here.
                </If>
            </div>
        </div>
    }


}

export default Invites;