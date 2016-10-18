import {render} from 'react-dom';
import { Modal } from 'react-bootstrap';
import Button from 'views/common/button';


class VideoModal extends React.Component {
    constructor(props) {
        super(props);
        this.getVideoHtml = this.getVideoHtml.bind(this);
    }

    getVideoHtml() {
        if (this.props.link.split('.').length < 2) {
            var width = $(window).width();
            var vWidth, vHeight;
            if (width < 480) {
                vWidth = 320;
                vHeight = 180
            }
            if (width >= 480) {
                vWidth = 480;
                vHeight = 270;
            }
            if (width >= 768) {
                vWidth = 720;
                vHeight = 405;
            }

            var videoHtml = '<iframe src="//player.vimeo.com/video/' + this.props.link +
                '" width="' + vWidth + '" height="' + vHeight + '" ' + 'frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>';
            return {__html: videoHtml};
        } else {
            var html = '<div>There is no video for this exercise. We thought it was self explanatory.</div>';
            return {__html: html};
        }
    }

    render() {
        return <div className="video-modal">
                <Modal show={this.props.show} onHide={this.props.close} className="video-modal">
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
            </div>
    }
}

export default VideoModal;