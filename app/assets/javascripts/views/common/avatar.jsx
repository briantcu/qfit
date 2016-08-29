import React from 'react';
import {render} from 'react-dom';

class Avatar extends React.Component {

    constructor(props) {
        super(props);
    }

    imagePath() {
        var path = "https://s3.amazonaws.com/quadfit/blank-avi.png";
        if (this.props.user && this.props.user.avatars && this.props.user.avatars.length > 0) {
            path = this.props.user.avatars[0];
        }
        return path;
    }

    render () {
        return <img src={this.imagePath()} alt={this.props.user.user_name} className="img-circle" width="48" height="48"/>;
    }
}
export default Avatar;