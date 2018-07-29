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
        var divStyle = {backgroundImage: `url(${this.imagePath()})`, width: this.state.width+'px', height: this.state.height+'px'};
        var link = (gon.is_coach) ? '/settings' : "/p/" +encodeURIComponent(this.props.user.user_name);
        if (this.props.noLink) {
            return <div style={divStyle} title={this.props.user.user_name} className="avi-wrapper img-circle" />;
        } else {
            return <a href={link}><div style={divStyle} title={this.props.user.user_name} className="avi-wrapper img-circle"/></a>;
        }
    }
}
export default Avatar;