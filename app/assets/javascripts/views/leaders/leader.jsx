import {render} from 'react-dom';
import Avatar from 'views/common/avatar';

require('views/leaders/leader.scss');

class Leader extends React.Component {
    constructor(props) {
        super(props);
    }

    render () {
        return <div className="leader row">
            <div className="col-xs-8">
                <Avatar user={this.props.leader} />
                <div className="username">
                    {this.props.leader.user_name}
                </div>
            </div>
            <div className="value col-xs-4">{this.props.leader.value}</div>
        </div>;
    }
}

export default Leader;