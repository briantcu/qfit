import {render} from 'react-dom';
import { Router, Route, Link, browserHistory } from 'react-router'
import Avatar from 'views/common/avatar';
import UserActions from 'actions/user_actions';

require('common/header.scss');

class Header extends React.Component {
    constructor(props) {
        super(props);
    }

    signOut() {
        UserActions.signOut();
    }

    render () {
        return <div className={this.props.showWorkoutNav ? "row header no-margin" : "row header no-margin shorter"}>
            <div className="container">
                <div className="row">
                    <div className="col-sm-2 col-xs-6">
                        <a href="/"><img className="logo" src="https://dwx350bwdtt59.cloudfront.net/logo%403x.png" /></a>
                    </div>
                    <If condition={this.props.showWorkoutNav && this.props.user.id}>
                        <div className="col-sm-8 hidden-xs text-center nav-wrapper">
                            <div className="nav">
                                <If condition={this.props.trueLinks}>
                                    <If condition={gon.is_coach} >
                                        <a className={(this.props.active == 'coach') ? 'btn active' : 'btn'}  href="/coach">
                                            <img height="14" width="18" src="https://dwx350bwdtt59.cloudfront.net/workout.png"/>  COACH
                                        </a>
                                    </If>
                                    <a className={(this.props.active == 'workout') ? 'btn active' : 'btn'}  href="/workout">
                                        <img src="https://dwx350bwdtt59.cloudfront.net/workouticon.png"/> WORKOUT
                                    </a>
                                    <a className={(this.props.active == 'progress') ? 'btn active' : 'btn'}  href="/progress">
                                        <img src="https://dwx350bwdtt59.cloudfront.net/Progress.png"/> PROGRESS
                                    </a>
                                    <If condition={!gon.is_coach} >
                                        <a className={(this.props.active == 'quad-pod') ? 'btn active' : 'btn'} href="/quad-pod">
                                            <img src="https://dwx350bwdtt59.cloudfront.net/QuadPod.png"/> QUAD POD
                                        </a>
                                    </If>
                                </If>
                                <If condition={!this.props.trueLinks}>
                                    <If condition={gon.is_coach} >
                                        <a className={(this.props.active == 'coach') ? 'btn active' : 'btn'}  href="/coach">
                                            <img height="14" width="14" src="https://dwx350bwdtt59.cloudfront.net/workout.png"/> COACH
                                        </a>
                                    </If>
                                    <Link className={(this.props.active == 'workout') ? 'btn active' : 'btn'}
                                          to={`/workout`}>
                                        <img src="https://dwx350bwdtt59.cloudfront.net/workouticon.png"/>  WORKOUT
                                    </Link>
                                    <Link className={(this.props.active == 'progress') ? 'btn active' : 'btn'} to={`/progress`}>
                                        <img src="https://dwx350bwdtt59.cloudfront.net/Progress.png"/> PROGRESS
                                    </Link>
                                    <If condition={!gon.is_coach} >
                                        <Link className={(this.props.active == 'quad-pod') ? 'btn active' : 'btn'} to={`/quad-pod`}>
                                            <img src="https://dwx350bwdtt59.cloudfront.net/QuadPod.png"/> QUAD POD
                                        </Link>
                                    </If>
                                </If>

                            </div>
                        </div>
                    </If>
                    <If condition={this.props.user.id && !this.props.hideAvatar}>
                        <div className={(this.props.showWorkoutNav) ? "col-sm-2 col-sm-offset-0 avi col-xs-6 col-xs-offset-0 text-right" : "col-xs-6 col-xs-offset-0 col-sm-2 col-sm-offset-8 avi text-right"}>
                            <Avatar user={this.props.user} />
                            <div className="dropdown">
                                <span className="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                    <span className="menu-pointer"></span>
                                </span>
                                <ul className="dropdown-menu user-menu" aria-labelledby="dropdownMenu1">
                                    <If condition={!gon.is_coach} >
                                        <li className="user-menu-item"><a className="white-link" href={'/p/'+ this.props.user.user_name}>My Profile</a></li>
                                    </If>
                                    <li className="user-menu-item"><a className="white-link" href="/settings">Settings</a></li>
                                    <li className="user-menu-item" onClick={this.signOut}><a className="white-link" href="javascript:void(0);">Sign Out</a></li>
                                </ul>
                            </div>
                        </div>
                    </If>
                    <If condition={!this.props.user.id && !this.props.hideAvatar}>
                        <div className="col-xs-12 col-xs-offset-0 col-sm-6 col-sm-offset-4 text-right links-wrapper">
                            <a href="/sign-up">For Athletes</a>
                            <a href="/sign-up-coach">For Coaches</a>
                            <a href="/sign-in">Sign In</a>
                        </div>
                    </If>
                </div>
                <div className="row hidden-sm hidden-md hidden-lg">
                    <If condition={this.props.showWorkoutNav}>
                        <div className="col-xs-12 text-center nav-wrapper">
                            <div className="nav">
                                <If condition={this.props.trueLinks}>
                                    <If condition={gon.is_coach} >
                                        <a className={(this.props.active == 'coach') ? 'btn active' : 'btn'}  href="/coach">
                                            <img height="14" width="18" src="https://dwx350bwdtt59.cloudfront.net/workout.png"/>  COACH
                                        </a>
                                    </If>
                                    <a className={(this.props.active == 'workout') ? 'btn active' : 'btn'}  href="/workout">
                                        <img src="https://dwx350bwdtt59.cloudfront.net/workouticon.png"/> WORKOUT
                                    </a>
                                    <a className={(this.props.active == 'progress') ? 'btn active' : 'btn'}  href="/progress">
                                        <img src="https://dwx350bwdtt59.cloudfront.net/Progress.png"/> PROGRESS
                                    </a>
                                    <If condition={!gon.is_coach} >
                                        <a className={(this.props.active == 'quad-pod') ? 'btn active' : 'btn'} href="/quad-pod">
                                            <img src="https://dwx350bwdtt59.cloudfront.net/QuadPod.png"/> QUAD POD
                                        </a>
                                    </If>
                                </If>
                                <If condition={!this.props.trueLinks}>
                                    <If condition={gon.is_coach} >
                                        <a className={(this.props.active == 'coach') ? 'btn active' : 'btn'}  href="/coach">
                                            <img height="14" width="14" src="https://dwx350bwdtt59.cloudfront.net/workout.png"/> COACH
                                        </a>
                                    </If>
                                    <Link className={(this.props.active == 'workout') ? 'btn active' : 'btn'} to={`/workout`}>
                                        <img src="https://dwx350bwdtt59.cloudfront.net/workouticon.png"/>  WORKOUT
                                    </Link>
                                    <Link className={(this.props.active == 'progress') ? 'btn active' : 'btn'} to={`/progress`}>
                                        <img src="https://dwx350bwdtt59.cloudfront.net/Progress.png"/> PROGRESS
                                    </Link>
                                    <If condition={!gon.is_coach} >
                                        <Link className={(this.props.active == 'quad-pod') ? 'btn active' : 'btn'} to={`/quad-pod`}>
                                            <img src="https://dwx350bwdtt59.cloudfront.net/QuadPod.png"/> QUAD POD
                                        </Link>
                                    </If>
                                </If>
                            </div>
                        </div>
                    </If>
                </div>
            </div>
            </div>
    }

}

export default Header;