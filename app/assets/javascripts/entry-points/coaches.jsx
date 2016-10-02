import {render} from 'react-dom';
import validator from 'validator';
import Header from 'views/common/header';
import UserStore from 'stores/user_store';
import CoachStore from 'stores/coach_store';
import UserActions from 'actions/user_actions';
import CoachActions from 'actions/coach_actions';
import Team from 'views/coaches/team';
import Athlete from 'views/coaches/athlete';
import { Modal } from 'react-bootstrap';
import Button from 'views/common/button';
import AddAthleteModal from 'views/coaches/add_athlete_modal';
import Util from 'helpers/util';

require('pages/coaches.scss');

class Coaches extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {},
            coach_account: {teams: [], individuals: [], sign_up_codes: []},
            showTeamModal: false,
            showAddUserModal: false
        };
        this.onChange = this.onChange.bind(this);
        this.viewTeam = this.viewTeam.bind(this);
        this.viewAthlete = this.viewAthlete.bind(this);
        this.createTeam = this.createTeam.bind(this);
        this.cancelTeamCreation = this.cancelTeamCreation.bind(this);
        this.startTeam = this.startTeam.bind(this);
        this.addUser = this.addUser.bind(this);
        this.cancelAddUser = this.cancelAddUser.bind(this);
        this.deleteCode = this.deleteCode.bind(this);
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

    createTeam() {
        this.setState({showTeamModal: true});
    }

    cancelTeamCreation() {
        this.setState({showTeamModal: false});
    }

    startTeam() {
        CoachActions.createTempTeam(true);
    }

    viewTeam (id) {
        CoachActions.viewTeam(id);
    }

    addUser() {
        this.setState({showAddUserModal: true});
    }

    cancelAddUser() {
        this.setState({showAddUserModal: false});
    }

    viewAthlete(id) {
        CoachActions.viewAthlete(id);
    }

    load() {
        UserActions.getUser(gon.current_user_id);
        CoachActions.getAccount(gon.coach_account_id);
    }

    deleteCode(codeId) {
        var r = confirm("Are you sure? The athlete won't be able to sign up with this code.");
        if (r == true) {
            CoachActions.deleteCode(codeId);
        }
    }

    render () {
        return <div className="coaches">
            <Header user={this.state.user} showWorkoutNav={true} active={'coach'} trueLinks={true}/>
            <div className="row main">
                <div className="container">
                    <div className='row'>
                        <h1>Coaches' Corner</h1>

                    </div>
                    <div className='row standard-text purple'>
                        Create Teams and add Athletes, and we'll handle the workouts.<br/>
                        You have used {this.state.coach_account.used_accounts} of {this.state.coach_account.num_accts} athlete accounts. You can increase/decrease your number of
                        accounts <a href="/account">HERE</a>.
                    </div>
                    <div className='row'>
                        <div className="container sec first-sec">
                            <div className="row head">
                                <div className="col-xs-2 sec-header">
                                    Teams
                                </div>
                                <div className="col-xs-3 col-xs-offset-7 action">
                                    <span className="hover" onClick={this.createTeam}>Add a New Team</span>
                                </div>
                            </div>
                            <div className="row">
                                <div className="container">
                                    {
                                        this.state.coach_account.teams.map(function(e) {
                                            return <Team team={e} key={e.id} teams={this.state.coach_account.teams} viewTeam={this.viewTeam}
                                            viewAthlete={this.viewAthlete} />
                                        }.bind(this))
                                    }
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
                                    <span className="hover" onClick={this.addUser}>Add a New Athlete Account</span>
                                </div>
                            </div>
                            <div className="row main">
                                <div className="container">
                                    {
                                        this.state.coach_account.individuals.map(function(e) {
                                            return <Athlete athlete={e} key={e.id} onTeam={false} teams={this.state.coach_account.teams}
                                                            viewAthlete={this.viewAthlete} />
                                        }.bind(this))
                                    }
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
                            <div className="row main">
                                <div className="container">
                                    {
                                        this.state.coach_account.sign_up_codes.map(function(e) {
                                            return <div className="row sign-up-code">
                                                    <div className="col-xs-4">
                                                        Sent to <span className="purple">{e.sent_to}</span> on {Util.formatDate(e.created_at)}
                                                    </div>
                                                    <div className="col-xs-4">
                                                        Status: {e.used ? 'Used: ' + Util.formatDate(e.redeemed_at) : 'Unused'}
                                                    </div>
                                                    <If condition={!e.used}>
                                                        <div className="col-xs-4 text-right">
                                                            <span onClick={() => this.deleteCode(e.id)} className="norm-link">Delete Code</span>
                                                        </div>
                                                    </If>
                                            </div>
                                        }.bind(this))
                                    }
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <Modal show={this.state.showTeamModal} >
                <Modal.Header closeButton onHide={this.cancelTeamCreation}>
                    <Modal.Title>Let's get started!</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    Before you can add a new team, you'll have to create a workout for that team. After we guide you
                    through that easy process, you'll be able to give the team a name, and then invite people to join the team.
                    Once they join, they'll automatically get the team's workout.
                </Modal.Body>
                <Modal.Footer>
                    <Button buttonText="Get Started" onClick={this.startTeam} />
                </Modal.Footer>
            </Modal>
            <AddAthleteModal show={this.state.showAddUserModal} showTeamOption={this.state.coach_account.teams.length > 0}
                cancel={this.cancelAddUser}  coachAccount={this.state.coach_account} />
        </div>;
    }
}

render(<Coaches/>, document.getElementById('app'));