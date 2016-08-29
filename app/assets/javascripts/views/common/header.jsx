import {render} from 'react-dom';
import { Router, Route, Link, browserHistory } from 'react-router'

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
                                    <a className="btn" href="/workout">WORKOUT</a>
                                    <a className="btn" href="/progress">PROGRESS</a>
                                    <a className="btn" href="/quad-pod">QUAD POD</a>
                                </If>
                                <If condition={!this.props.trueLinks}>
                                    <Link className={(this.props.active == 'workout') ? 'btn active' : 'btn'}
                                          to={`/workout`}>WORKOUT</Link>
                                    < Link className={(this.props.active == 'progress') ? 'btn active' : 'btn'} to={`/progress`}>PROGRESS</Link>
                                    <Link className={(this.props.active == 'quad-pod') ? 'btn active' : 'btn'} to={`/quad-pod`}>QUAD POD</Link>
                                </If>

                            </div>
                        </div>
                    </If>
                    <If condition={this.props.user.avatars} >
                        <div className={(this.props.showWorkoutNav) ? "col-xs-1 col-xs-offset-1" : "col-xs-1 col-xs-offset-9"}>
                            <img src={`${this.props.user.avatars}`} />
                        </div>
                    </If>
                </div>
            </div>
        </div>
    }

}

export default Header;