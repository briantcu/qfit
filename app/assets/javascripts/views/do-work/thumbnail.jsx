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
        this.updateThumb(this.props);
    }

    componentWillReceiveProps(nextProps) {
        this.updateThumb(nextProps);
    }

    updateThumb(props) {
        if (props.exercise.video_link.split('.').length > 2) {
            this.setState({url: props.exercise.video_link});
        } else {
            this.setState({url: props.exercise.thumbnail});
        }
    }

    render() {
        return <span className="thumb" onClick={this.props.click}>
            <img src={this.state.url} />
        </span>
    }
}

export default Thumbnail;