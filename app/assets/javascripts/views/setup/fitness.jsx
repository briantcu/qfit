import {render} from 'react-dom';
import UserStore from 'stores/user_store';
require('views/setup/fitness.scss');

class Fitness extends React.Component {

    constructor(props) {
        super(props);
        this.onChange = this.onChange.bind(this);
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
    }

    onChange () {
        var userData = UserStore.getData();

        this.setState({
            user: userData.user
        });
    }

    render () {
        return <div className="row subnav">
            <div className="container">
                <div className="row">
                    <div className="col-xs-1 col-xs-offset-3 text-center bold-text">
                        Setup
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Fitness;