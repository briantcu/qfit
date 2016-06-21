import {render} from 'react-dom';
import RoutineStore from 'stores/routine_store';

require('pages/sign_up.scss');

class DoWork extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
        }
    }

    componentDidMount () {
        RoutineStore.addChangeListener(this.onChange.bind(this));
    }

    componentWillUnmount () {
        RoutineStore.removeChangeListener(this.onChange.bind(this));
    }

    onChange () {
        var data = SignUpStore.getData();
    }

    render () {
        return <div className="do-work row">
            <div className="col-md-5 col-md-offset-6 col-xs-12 col-xs-offset-0 form">
                <div className="row">
                    <div className="col-md-12">
                        <h1>Sign up as an Athlete</h1>
                        <a href="" className="info-text subtle-link">Are you a coach? Sign up here.</a>
                    </div>
                </div>
            </div>
        </div>;
    }
}

render(<DoWork/>, document.getElementById('app'));