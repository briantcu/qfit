import React from 'react';
import {render} from 'react-dom';

class Avatar extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            width: "48",
            height: "48"
        }
    }

    componentWillReceiveProps(nextProps){
        if (nextProps.big) {
            this.setState({width: "130", height: "130"});
        }
    }

    imagePath() {
        var path = "https://dwx350bwdtt59.cloudfront.net/blank-avi.png";
        if (this.props.user && this.props.user.avatar) {
            path = this.props.user.avatar;
        }
        return path;
    }

    render () {
        if (this.props.noLink) {
            return <img src={this.imagePath()} alt={this.props.user.user_name} className="img-circle"
                        width={this.state.width} height={this.state.height}/>;
        } else {
            return <a href={"/p/" +encodeURIComponent(this.props.user.user_name)}>
                <img src={this.imagePath()} alt={this.props.user.user_name}
                     className="img-circle" width={this.state.width} height={this.state.height}/></a>;
        }
    }
}
export default Avatar;