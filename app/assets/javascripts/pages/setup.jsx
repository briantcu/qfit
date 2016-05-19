import {render} from 'react-dom';
import Header from 'views/common/header';
import Subnav from 'views/setup/subnav';
import UserStore from 'stores/user_store';
import UserActions from 'actions/user_actions';
import CircleCheck from 'views/common/circle_check';
import { Router, Route, Link, browserHistory } from 'react-router'

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
        if (!this.state.formSubmitted) {
            this.state.formSubmitted = true;
            var strength = this.refs.strength.getValue();
            var plyo = this.refs.plyo.getValue();
            var sprinting = this.refs.sprinting.getValue();
            var valid = strength && plyo && sprinting;
            if (valid) {

            } else {
                this.setState({valid: false, formSubmitted: false});
            }
        }

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
                            <CircleCheck ref="strength"  id={'strength'} label={'Strength Training'} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck ref="plyo" id={'plyo'} label={'Plyometrics'} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck ref="sprinting" id={'sprinting'} label={'Sprinting'} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <CircleCheck id={'stretching'} label={'Stretching (Default)'} disabled={true} />
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <If condition={this.state.valid == false}>
                                <span>You must choose at least one Quad.</span>
                            </If>
                            <span onClick={ () => this.submit()} className="continue-button purple-text">Continue</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

render((
    <Router history={browserHistory}>
        <Route path="/get-started" component={Setup} />
    </Router>
), document.getElementById('app'));