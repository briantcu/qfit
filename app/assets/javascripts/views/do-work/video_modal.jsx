import {render} from 'react-dom';
import { Modal } from 'react-bootstrap';
import Button from 'views/common/button';


class VideoModal extends React.Component {
    constructor(props) {
        super(props);
        this.getVideoHtml = this.getVideoHtml.bind(this);
    }

    getVideoHtml() {
        var width = $(window).width();
        var vWidth, vHeight;
        if (width < 480) {
            vWidth = 320;
            vHeight = 180
        } else {
            vWidth = 480;
            vHeight = 270;
        }
        var videoHtml = '<iframe src="//player.vimeo.com/video/'+ this.props.link +
            '" width="' + vWidth + '" height="'+vHeight+'" ' + 'frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>';
        return {__html: videoHtml};
    }

    render() {
        return <Modal show={this.props.show} onHide={this.props.close}>
            <Modal.Header closeButton>
                <Modal.Title>Video</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <div dangerouslySetInnerHTML={this.getVideoHtml()} />
            </Modal.Body>
            <Modal.Footer>
                <Button buttonText="Close" onClick={this.props.close}>Close</Button>
            </Modal.Footer>
        </Modal>
    }
}

export default VideoModal;