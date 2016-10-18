import {render} from 'react-dom';
import { Router, Route, Link, browserHistory } from 'react-router'
import Avatar from 'views/common/avatar';

require('common/header.scss');

class Header extends React.Component {
    constructor(props) {
        super(props);
    }

    render () {
        return <div className="row header">
            <div className="container">
                <div className="row">
                    <div className="col-xs-2">
                        <a href="/"><img className="logo" src="https://s3.amazonaws.com/quadfit/logo%403x.png" /></a>
                    </div>
                    <If condition={this.props.showWorkoutNav}>
                        <div className="col-xs-8 text-center">     \
                            <div className="nav">
                                <If condition={this.props.trueLinks}>
                                    <If condition={gon.is_coach} >
                                        <a className={(this.props.active == 'coach') ? 'btn active' : 'btn'}  href="/coach">
                                            <img height="14" width="18" src="https://s3.amazonaws.com/quadfit/iocn-+workout.png"/>  COACH
                                        </a>
                                    </If>
                                    <a className={(this.props.active == 'workout') ? 'btn active' : 'btn'}  href="/workout">
                                        <img src="https://s3.amazonaws.com/quadfit/icon-dumbells.png"/> WORKOUT
                                    </a>
                                    <a className={(this.props.active == 'progress') ? 'btn active' : 'btn'}  href="/progress">
                                        <img src="https://s3.amazonaws.com/quadfit/Icon+-+Progress.png"/> PROGRESS
                                    </a>
                                    <If condition={!gon.is_coach} >
                                        <a className={(this.props.active == 'quad-pod') ? 'btn active' : 'btn'} href="/quad-pod">
                                            <img src="https://s3.amazonaws.com/quadfit/Icon+-+QuadPod.png"/> QUAD POD
                                        </a>
                                    </If>
                                </If>
                                <If condition={!this.props.trueLinks}>
                                    <If condition={gon.is_coach} >
                                        <a className={(this.props.active == 'coach') ? 'btn active' : 'btn'}  href="/coach">
                                            <img height="14" width="14" src="https://s3.amazonaws.com/quadfit/iocn-+workout.png"/> COACH
                                        </a>
                                    </If>
                                    <Link className={(this.props.active == 'workout') ? 'btn active' : 'btn'}
                                          to={`/workout`}>
                                        <img height="14" width="22" src="https://s3.amazonaws.com/quadfit/icon-dumbells.png"/>  WORKOUT
                                    </Link>
                                    <Link className={(this.props.active == 'progress') ? 'btn active' : 'btn'} to={`/progress`}>
                                        <img src="https://s3.amazonaws.com/quadfit/Icon+-+Progress.png"/> PROGRESS
                                    </Link>
                                    <If condition={!gon.is_coach} >
                                        <Link className={(this.props.active == 'quad-pod') ? 'btn active' : 'btn'} to={`/quad-pod`}>
                                            <img src="https://s3.amazonaws.com/quadfit/Icon+-+QuadPod.png"/> QUAD POD
                                        </Link>
                                    </If>
                                </If>

                            </div>
                        </div>
                    </If>
                    <div className={(this.props.showWorkoutNav) ? "col-xs-1 col-xs-offset-1 avi" : "col-xs-1 col-xs-offset-9 avi"}>
                        <Avatar user={this.props.user} />
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Header;