import {render} from 'react-dom';

require('views/do-work/thumbnail.scss');

class Thumbnail extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            url: undefined
        };
    }

    componentWillMount() {
        if (this.props.exercise.video_link.split('.').length > 2) {
            this.setState({url: this.props.exercise.video_link});
        } else {
            this.setState({url: this.props.exercise.thumbnail});
        }
    }

    render() {
        return <span className="thumb" onClick={this.props.click}>
            <img width="120" height="90" src={this.state.url} />
        </span>
    }
}

export default Thumbnail;