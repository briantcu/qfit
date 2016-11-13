import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import UserStore from 'stores/user_store';
import UserActions from 'actions/user_actions';
import ProfileActions from 'actions/profile_actions';
import Header from 'views/common/header';
import Footer from 'views/common/footer';
import Button from 'views/common/button';
import Avatar from 'views/common/avatar';
import QuadPodStore from 'stores/quad_pod_store';
import Util from 'helpers/util';

require('pages/profile.scss');


class Profile extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {recent_workouts: []},
            loggedInUser: {},
            quad_pod: []
        };
        this.onChange = this.onChange.bind(this);
        this.sendInvite = this.sendInvite.bind(this);
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        QuadPodStore.addChangeListener(this.onChange);
        this.load();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        QuadPodStore.removeChangeListener(this.onChange.bind(this));
    }

    load() {
        if (gon.user_id) {
            UserActions.getUser(gon.user_id, true, true);
        }
        ProfileActions.getProfile(gon.current_user_id);
        ProfileActions.getPodForUser(gon.current_user_id);
    }

    onChange () {
        var user = UserStore.getData();
        var qpData = QuadPodStore.getData();
        this.setState(
            {
                loggedInUser: user.loggedInUser,
                user: user.user,
                quad_pod: qpData.pod
            }
        );
    }

    sendInvite() {

    }

    render () {

        return <div>
            <Header user={this.state.loggedInUser} showWorkoutNav={true} active={''} trueLinks={true} />
            <div className="profile">
                <div className="row main">
                    <div className="container">
                        <div className="row profile-row">
                            <div className="col-xs-12">
                                <div className="p-section">
                                    <div className="sec-header">Profile
                                        {  (this.state.user.id == this.state.loggedInUser.id)

                                            ?
                                                <span className="edit-link"><a className="norm-link" href="/settings">Edit</a></span>
                                            :
                                            ''
                                        }

                                    </div>
                                    <div className="sec-main">
                                        <div className="row">
                                            <div className="col-xs-12 col-sm-8">
                                                <div className="block-wrapper"><Avatar user={this.state.user} big={true} noLink={true} /></div>
                                                <div className="details">
                                                    <div className="user-name">{this.state.user.user_name}</div>
                                                    <span className="user-info"><span className="power-index">Power</span>Index: {this.state.user.power_index}</span>
                                                    <span className="user-info"><span className="power-index">Rep</span>utation: {this.state.user.points}</span>
                                                </div>
                                            </div>
                                            <div className="col-xs-12 col-sm-4 text-right">
                                                <div className="button-wrapper">
                                                    <If condition={!this.state.user.is_friend && gon.current_user_id != gon.user_id} >
                                                        <Button buttonText="Invite to Quad Pod" onClick={this.sendInvite} />
                                                    </If>
                                                    <If condition={this.state.user.is_friend && gon.current_user_id != gon.user_id} >
                                                        <span className="in-pod">In Your Quad Pod</span>
                                                    </If>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div className="row profile-row last-row">
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">Recent Workouts</div>
                                    <div className="sec-main workout-section">
                                        {
                                            this.state.user.recent_workouts.map(function(workout, i) {
                                                return <div key={i} className="workout-row row">
                                                    <div className="col-xs-8">
                                                        {Util.formatFullDateNoTime(workout.day_performed)}
                                                    </div>
                                                    <div className="col-xs-4 text-right">
                                                        <a className="norm-link" href={workout.share_link}>View</a>
                                                    </div>
                                                </div>
                                            })
                                        }
                                    </div>
                                </div>
                            </div>
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">
                                        {  (this.state.user.id == this.state.loggedInUser.id)

                                            ?
                                            <a className="norm-link" href="/quad-pod">Quad Pod</a>
                                            :

                                            'Quad Pod'
                                        }

                                    </div>
                                    <div className="sec-main workout-section">
                                        {
                                            this.state.quad_pod.map(function(friend) {
                                                return <div key={friend.id} className="row friend-row">
                                                    <div className="col-xs-9">
                                                        <span className="block-wrapper"><Avatar user={friend} /></span>
                                                        <span className="block-wrapper friend-text user-name">{friend.user_name}</span>
                                                    </div>
                                                    <div className="col-xs-3 text-right friend-text">
                                                        <a className="norm-link" href={"/p/" + encodeURIComponent(friend.user_name)}>View</a>
                                                    </div>
                                                </div>
                                            })
                                        }
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <Footer />
        </div>
    }
}

render(<Profile />, document.getElementById('app'));
