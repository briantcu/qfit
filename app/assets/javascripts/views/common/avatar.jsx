import React from 'react';
import {render} from 'react-dom';

class Avatar extends React.Component {

    constructor(props) {
        super(props);
    }

    imagePath() {
        var path = "https://s3.amazonaws.com/quadfit/blank-avi.png";
        if (this.props.user && this.props.user.avatar) {
            path = this.props.user.avatar;
        }
        return path;
    }

    render () {
        return <a href="/account"><img src={this.imagePath()} alt={this.props.user.user_name} className="img-circle" width="48" height="48"/></a>;
    }
}
export default Avatar;