import {render} from 'react-dom';
import { Modal } from 'react-bootstrap';
import Button from 'views/common/button';
import SlidingMenu from 'views/common/sliding_menu';


class MenuModal extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <Modal show={this.props.show} onHide={this.props.close}>
            <Modal.Header closeButton>
                <Modal.Title>Choose an exercise</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <SlidingMenu click={this.props.click}/>
            </Modal.Body>
            <Modal.Footer>
                <Button buttonText="Close" onClick={this.props.close}>Close</Button>
            </Modal.Footer>
        </Modal>
    }
}

export default MenuModal;