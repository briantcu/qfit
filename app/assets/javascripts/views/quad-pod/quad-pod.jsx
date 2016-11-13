import {render} from 'react-dom';
import Friends from 'views/quad-pod/friends';
import Feed from 'views/quad-pod/feed';
import Button from 'views/common/button';
import UserActions from 'actions/user_actions';
import Invites from'views/quad-pod/invites';
import { Modal } from 'react-bootstrap';

require('views/quad-pod/quad-pod.scss');

class QuadPod extends React.Component {

    constructor(props) {
        super(props);
        this.invite = this.invite.bind(this);
        this.showConversation = this.showConversation.bind(this);
        this.showFeed = this.showFeed.bind(this);
        this.hideInvite = this.hideInvite.bind(this);
        this.showInvite = this.showInvite.bind(this);
        this.state = {
            viewingConversation: false,
            transitioning: false,
            showInvite: false
        };
    }

    invite(e) {
        var invites = [];
        _.each(this.refs, function(ref) {
            if (ref.className == 'standard-text') {
                if (ref.value.trim().length > 0) {
                    invites.push(ref.value.trim());
                }
            }
        });
        UserActions.sendInvitations(invites);
    }

    componentWillReceiveProps(nextProps) {
        this.setState({transitioning: nextProps.quad_pod_loading});
    }

    showConversation (userId) {
        UserActions.getConversation(userId);
        this.setState({viewingConversation: true, transitioning: true});
    }

    showFeed () {
        UserActions.getFeed();
        this.setState({viewingConversation: false, transitioning: true});
    }

    hideInvite() {
        this.setState({showInvite: false});
    }

    showInvite() {
        this.setState({showInvite: true});
    }

    render () {
        return <div className="quad-pod">
            <div className="row main">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-12">
                            <div className="qp-header">
                                Quad Pod
                            </div>
                            <div className="qp-sub">
                                Talk with friends and see their workouts!
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12 col-sm-5 fixed-wrapper">
                            <Invites {...this.props} showInviteModal={this.showInvite}/>
                            <Friends {...this.props} showConversation={this.showConversation} />
                        </div>
                        <div className="col-xs-12 col-sm-7">
                            <Feed {...this.props} showFeed={this.showFeed} viewingConversation={this.state.viewingConversation} transitioning={this.state.transitioning} />
                        </div>
                    </div>
                </div>
            </div>
            <Modal show={this.state.showInvite} onHide={this.hideInvite}>
                <Modal.Header closeButton>
                    <Modal.Title>Invite Friends to Your Pod</Modal.Title>
                </Modal.Header>
                <Modal.Body className="pod-invite-modal">
                    <div className="qp-section">
                        <div className="sec-main gray-border">
                            Invite friends to join your Quad Pod. You can enter email addresses or cell phone
                            numbers. Put each entry in a new field.
                        </div>
                        <div className="input-row">
                            <input ref="inputField1" type="text" className="standard-text" name="" />
                            <input ref="inputField2" type="text" className="standard-text" name="" />
                        </div>
                        <div className="input-row">
                            <input ref="inputField3" type="text" className="standard-text" name="" />
                            <input ref="inputField4" type="text" className="standard-text" name="" />
                        </div>
                        <div className="input-row">
                            <input ref="inputField5" type="text" className="standard-text" name="" />
                            <input ref="inputField6" type="text" className="standard-text" name="" />
                        </div>
                        <div className="submit-row">
                            <Button buttonText={'Submit'} onClick={this.invite} />
                        </div>
                        <If condition={this.props.invites.successes && this.props.invites.successes.length > 0} >
                            <div className="sec-main">
                                <div className="green">Successfully invited:</div>
                                {
                                    this.props.invites.successes.map(function(e) {
                                        return <div className="green">{e.sent_to}</div>
                                    }.bind(this))
                                }
                            </div>
                        </If>
                        <If condition={this.props.invites.failures && this.props.invites.failures.length > 0} >
                            <div className="sec-main">
                                <div className="red">We failed to invite:</div>
                                {
                                    this.props.invites.failures.map(function(e) {
                                        return <div className="red">{e.sent_to}: {e.message}</div>
                                    }.bind(this))
                                }
                            </div>
                        </If>
                    </div>
                </Modal.Body>
            </Modal>
        </div>;
    }


}

export default QuadPod;