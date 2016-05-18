import {render} from 'react-dom';
import Header from 'views/common/header';
import Subnav from 'views/setup/subnav';
import UserStore from 'stores/user_store';
import UserActions from 'actions/user_actions';
import CircleCheck from 'views/common/circle_check';

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

    submit () {

    }

    render () {
        return <div className="setup">
            <Header user={this.state.user} />
            <Subnav  />
            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-4">
                            <h1 className="purple">Let's Get Started</h1>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-4 header-text">
                            Which of the Quads of the Quadfit program would you like to add to your program?
                            (Stretching will be added automatically)
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck id={'strength'} label={'Strength Training'} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck id={'plyo'} label={'Plyometrics'} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck id={'sprinting'} label={'Sprinting'} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck id={'stretching'} label={'Stretching (Default)'} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <span onClick={ () => this.submit()} className="submit-button purple-text">Continue</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

render(<Setup/>, document.getElementById('app'));