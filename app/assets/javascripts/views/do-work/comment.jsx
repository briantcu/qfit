import {render} from 'react-dom';
import { Modal } from 'react-bootstrap';
import Button from 'views/common/button';

require('views/do-work/comment.scss');

class Comment extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <div className="comment row">
            <div className="col-xs-12">
                {this.props.comment.poster.user_name}
                {this.props.comment.created_at}
            </div>
            <div className="col-xs-12">
                {this.props.comment.message}
            </div>
        </div>
    }
}

export default Comment;