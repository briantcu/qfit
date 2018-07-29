import {render} from 'react-dom';
import { Modal } from 'react-bootstrap';
import Button from 'views/common/button';


class TipsModal extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <Modal show={this.props.show} onHide={this.props.close}>
                <Modal.Header closeButton>
                    <Modal.Title>Tips</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    {
                        this.props.tips.map(function(e, index) {
                            return <div key={index}>{e.tip}</div>;
                        })
                    }
                </Modal.Body>
                <Modal.Footer>
                    <Button buttonText="Close" onClick={this.props.close}>Close</Button>
                </Modal.Footer>
            </Modal>
    }
}

export default TipsModal;