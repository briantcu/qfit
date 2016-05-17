import {render} from 'react-dom';
import Header from 'views/common/header';
import UserStore from 'stores/user_store';
import UserActions from 'actions/user_actions';

require('pages/setup.scss');

class Setup extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {}
        }
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange.bind(this));
        UserActions.getUser(gon.current_user_id);
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange.bind(this));
    }

    onChange () {
        var data = UserStore.getData();

        this.setState({
            user: data.user
        });
    }

    render () {
        return <div className="setup">
            <Header user={this.state.user} />
            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-2">
                            {this.state.user.first_name}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

render(<Setup/>, document.getElementById('app'));