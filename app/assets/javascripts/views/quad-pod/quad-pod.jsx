import {render} from 'react-dom';
import Friends from 'views/quad-pod/friends';
import Feed from 'views/quad-pod/feed';
import Button from 'views/common/button';
import UserActions from 'actions/user_actions';

require('views/quad-pod/quad-pod.scss');

class QuadPod extends React.Component {

    constructor(props) {
        super(props);
        this.invite = this.invite.bind(this);
        this.showConversation = this.showConversation.bind(this);
        this.showFeed = this.showFeed.bind(this);
        this.state = {
            viewingConversation: false,
            transitioning: false
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
                        <div className="col-xs-12 col-sm-5">
                            <Friends {...this.props} showConversation={this.showConversation} />
                            <div className="qp-section">
                                <div className="sec-header">Invite Friends to Your Pod</div>
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
                        </div>
                        <div className="col-xs-12 col-sm-7">
                            <Feed {...this.props} viewingConversation={this.state.viewingConversation} transitioning={this.state.transitioning} />
                        </div>
                        <If condition={this.state.viewingConversation} >
                            <div className="col-xs-12 col-sm-7">
                                <span className="small-link" onClick={() => this.showFeed() }>Back to Feed</span>
                            </div>
                        </If>
                    </div>
                </div>
            </div>
        </div>;
    }


}

export default QuadPod;