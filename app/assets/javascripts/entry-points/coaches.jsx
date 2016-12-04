import {render} from 'react-dom';
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
import URLSearchParams from 'url-search-params';
import Footer from 'views/common/footer';

require('pages/coaches.scss');

class Coaches extends React.Component {
    constructor(props) {
        super(props);
        var params = new URLSearchParams(window.location.search);
        this.state = {
            user: {},
            coach_account: {teams: [], individuals: [], sign_up_codes: [], can_send_codes: true, num_used_accts: 0, num_accts: 5},
            showTeamModal: false,
            showAddUserModal: false,
            showBanner: params.has('choose'),
            loading: false
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
        this.setLoading = this.setLoading.bind(this);
    }

    componentDidMount () {
        var scrollFn = function() {
            var bannerRow = $(".banner-row");
            if ($(window).scrollTop() > 100) {
                bannerRow.addClass("fixed");
            } else {
                bannerRow.removeClass("fixed");
            }
        };
        var debounced = _.debounce(scrollFn, 5);
        window.addEventListener('scroll', debounced);
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
                coach_account: coach_account.account,
                loading: false
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

    setLoading() {
        this.setState({loading: true});
    }

    render () {
        return <div className="coaches hundo-height">
            <Header user={this.state.user} showWorkoutNav={true} active={'coach'} trueLinks={true}/>
            <If condition={this.state.showBanner} >
                <div className="row banner-row no-margin">
                    <div className="container">
                        <div className="row">
                            <div className="col-xs-12 text-center">
                                To view workouts for teams, click "Manage Workout" for a particular team below.<br/>
                                To view workouts and progress for athletes, click "View Workout".
                            </div>
                        </div>
                    </div>
                </div>
            </If>
            <div className="row main no-margin">
                <div className="container">
                    <div className='row xs-padding'>
                        <div className="col-xs-12">
                            <h1>Coaches' Corner</h1>
                        </div>
                    </div>
                    <div className='row standard-text purple xs-padding'>
                        <div className="col-xs-12">
                        Create Teams and add Athletes, and we'll handle the workouts.<br/>
                        You have a maximum of {this.state.coach_account.num_accts} athlete accounts.
                        You can upgrade/downgrade your account <a className="norm-link" href="/settings">HERE</a>. <br />
                        <If condition={!this.state.coach_account.can_send_codes}>
                            You have a limit of {this.state.coach_account.num_accts} athlete accounts, but you have sent {this.state.coach_account.num_sent_codes} sign up codes
                            and have {this.state.coach_account.num_used_accounts} existing athlete accounts. You'll need to
                            <a className="norm-link" href="/settings">upgrade your account</a> to send more sign up codes.<br/>
                        </If>
                        <If condition={this.state.coach_account.num_used_accounts > this.state.coach_account.num_accts} >
                            You have exceeded your athlete account limit. Workouts will no longer be created for your athletes until you
                            <a className="norm-link" href="/settings">upgrade your account</a>, or delete some existing athlete accounts.
                        </If>
                        </div>
                    </div>
                    <div className='row'>
                        <div className="container sec first-sec">
                            <div className="row head">
                                <div className="col-sm-2 col-xs-12 sec-header">
                                    Teams
                                </div>
                                <div className="col-sm-3 col-xs-12 col-sm-offset-7 action">
                                    <span className="hover" onClick={this.createTeam}>Add a New Team</span>
                                </div>
                            </div>
                            <div className="row">
                                <div className="container">
                                    {
                                        this.state.coach_account.teams.map(function(e) {
                                            return <Team team={e} key={e.id} teams={this.state.coach_account.teams} viewTeam={this.viewTeam}
                                            viewAthlete={this.viewAthlete} setLoading={this.setLoading}/>
                                        }.bind(this))
                                    }
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className='row'>
                        <div className="container sec">
                            <div className="row head">
                                <div className="col-sm-2 col-xs-12 sec-header">
                                    Athletes
                                </div>
                                <If condition={this.state.coach_account.can_send_codes} >
                                    <div className="col-sm-5 col-xs-12 col-sm-offset-5 action">
                                        <span className="hover" onClick={this.addUser}>Add a New Athlete Account</span>
                                    </div>
                                </If>
                            </div>
                            <div className="row main">
                                <div className="container">
                                    {
                                        this.state.coach_account.individuals.map(function(e) {
                                            return <Athlete athlete={e} key={e.id} onTeam={false} teams={this.state.coach_account.teams}
                                                            viewAthlete={this.viewAthlete} setLoading={this.setLoading} />
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
                                    Sent Invites
                                </div>
                            </div>
                            <div className="row main">
                                <div className="container">
                                    {
                                        this.state.coach_account.sign_up_codes.map(function(e, i) {
                                            return <div className="sign-up-code" key={i}>
                                                <div className="row">
                                                    <div className="col-sm-4 col-xs-12">
                                                        Sent to <span className="purple">{e.sent_to}</span> on {Util.formatDate(e.created_at)}
                                                    </div>
                                                    <div className="col-sm-4 col-xs-6 next-row-micro">
                                                        Status: {e.used ? 'Used: ' + Util.formatDate(e.redeemed_at) : 'Unused'}
                                                    </div>
                                                    <If condition={!e.used}>
                                                        <div className="col-sm-4 col-xs-6 text-right next-row-micro">
                                                            <span onClick={() => this.deleteCode(e.id)} className="norm-link">Delete Code</span>
                                                        </div>
                                                    </If>
                                                </div>
                                            </div>
                                        }.bind(this))
                                    }
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <Modal show={this.state.showTeamModal} onHide={this.cancelTeamCreation} >
                <Modal.Header closeButton>
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
            <If condition={this.state.loading} >
                <div className="loading-overlay"><img src="https://dwx350bwdtt59.cloudfront.net/loading-ring-164.gif" /></div>
            </If>
            <Footer />
        </div>;
    }
}

render(<Coaches/>, document.getElementById('app'));