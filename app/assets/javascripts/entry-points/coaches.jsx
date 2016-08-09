import {render} from 'react-dom';
import validator from 'validator';
import Header from 'views/common/header';
import UserStore from 'stores/user_store';
import CoachStore from 'stores/coach_store';
import UserActions from 'actions/user_actions';
import CoachActions from 'actions/coach_actions';

require('pages/coaches.scss');

class Coaches extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {},
            coach_account: {}
        };
        this.onChange = this.onChange.bind(this);
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        CoachStore.addChangeListener(this.onChange);
        this.load();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        CoachStore.removeChangeListener(this.onChange);
    }

    onChange () {
        var user = UserStore.getData();
        var coach_account = CoachStore.getData();
        this.setState(
            {
                user: user.user,
                coach_account: coach_account.account
            }
        )
    }

    load() {
        UserActions.getUser(gon.current_user_id);
        CoachActions.getAccount(gon.coach_account_id);
    }

    render () {
        return <div className="coaches">
            <Header user={this.state.user} />
            <div className="row main">
                <div className="container">
                    <div className='row'>
                        <h1>Coaches' Corner</h1>

                    </div>
                    <div className='row standard-text purple'>
                        Create Teams and add Athletes, and we'll handle the workouts.<br/>
                        You have used {this.state.coach_account.used_accounts} of {this.state.coach_account.num_accts} athlete accounts. You can increase/decrease your number of accounts HERE.
                    </div>
                    <div className='row'>
                        <div className="container sec first-sec">
                            <div className="row head">
                                <div className="col-xs-2 sec-header">
                                    Teams
                                </div>
                                <div className="col-xs-3 col-xs-offset-7 action">
                                    Create New Team
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className='row'>
                        <div className="container sec">
                            <div className="row head">
                                <div className="col-xs-2 sec-header">
                                    Athletes
                                </div>
                                <div className="col-xs-3 col-xs-offset-7 action">
                                    Add a new Account
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className='row'>
                        <div className="container sec last-sec">
                            <div className="row head">
                                <div className="col-xs-12 sec-header">
                                    Sign Up Codes
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>;
    }
}

render(<Coaches/>, document.getElementById('app'));