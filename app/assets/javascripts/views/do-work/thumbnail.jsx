import {render} from 'react-dom';

require('views/do-work/thumbnail.scss');

class Thumbnail extends React.Component {
    constructor(props) {
        super(props);
        this.showThumb = this.showThumb.bind(this);
        this.state = {
            url: undefined
        };
    }

    componentWillMount() {
        if (this.props.exercise.is_stretch) {
            this.setState({url: this.props.exercise.video_link});
        } else {
            this.loadThumb();
        }
    }

    loadThumb() {
        var url = "http://vimeo.com/api/v2/video/" + this.props.exercise.video_link + ".json";
        $.ajax({
            type: 'get',
            url: url,
            dataType: 'json',
            success: function(data) {
                this.showThumb(data);
            }.bind(this),
            error: function(response) {
                alert(JSON.parse(response.responseJSON));
            }
        });
    }

    showThumb(data) {
        var url = data[0].thumbnail_medium;
        this.setState({url: url});
    }

    render() {
        return <span className="thumb" onClick={this.props.click}>
            <img width="120" height="90" src={this.state.url} />
        </span>
    }
}

export default Thumbnail;