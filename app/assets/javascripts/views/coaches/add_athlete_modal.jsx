import {render} from 'react-dom';
import { Modal } from 'react-bootstrap';
import Button from 'views/common/button';
import VCircleCheck from 'views/common/vert_circle_check';
var C = require('constants/fitness_assessment_constants.js');
import validator from 'validator';
import FancyInput from 'views/common/fancy_input';
import CoachActions from 'actions/coach_actions';


class AddAthleteModal extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            step: 'choose-option',
            error: '',
            goal: undefined,
            contactError: []
        };
        this.goalMap = {
            1: C.LEAN,
            2: C.MASS,
            3: C.RIP
        };
        this.changeState = this.changeState.bind(this);
        this.chooseOptionBody = this.chooseOptionBody.bind(this);
        this.chooseOptionFooter = this.chooseOptionFooter.bind(this);
        this.choseTeamBody = this.choseTeamBody.bind(this);
        this.choseTeamFooter = this.choseTeamFooter.bind(this);
        this.goalChanged = this.goalChanged.bind(this);
        this.sendTeamInvite = this.sendTeamInvite.bind(this);
        this.inviteSent = this.inviteSent.bind(this);
        this.sentBody = this.sentBody.bind(this);
        this.sentFooter = this.sentFooter.bind(this);
        this.cancel = this.cancel.bind(this);
    }

    componentWillReceiveProps(nextProps) {
        if ((!this.props.show) && (nextProps.show)) {
            this.setState({step: 'choose-option'});
        }
    }

    changeState(newState) {
        this.setState({step: newState});
    }

    choseIndividual() {
        CoachActions.createTempTeam(false);
    }

    goalChanged (elem) {
        var check = this.refs[this.goalMap[elem.target.id]];
        if (check.getValue()) {
            this.setState({goal: elem.target.id, error: ''});
        } else {
            this.setState({goal: undefined});
        }
    }

    chooseOptionBody() {
        return <div> At the end of this process, we'll send an invite to this new Quadfit member. Once they sign up
        they'll show up on this page. But first, you'll have to create a workout plan for this athlete.

        <If condition={this.props.showTeamOption}>
            Would you like to add this athlete to an existing team, in which case they will get the team's
            workout plan, or would you like to create a workout plan specifically for this user?
        </If>
        </div>
    }

    chooseOptionFooter() {
        return <div>
            <If condition={this.props.showTeamOption}>
                <Button buttonText="Add to Team" onClick={() => this.changeState('chose-team')} /> OR
            </If>
            <Button buttonText={this.props.showTeamOption ? 'Create Individual Plan' : 'Create Workout Plan'} onClick={() => this.choseIndividual()} />
        </div>
    }

    sentBody() {
        return <div>
            Success! Your invitation has been sent. When the athlete signs up, you'll be notified by email. In the
            meantime, you can see the status of your invite in the Sign Up Codes section of this page.
        </div>
    }

    sentFooter() {
        return <div>
            <Button buttonText={'Close'} onClick={this.props.cancel} />
        </div>
    }

    choseTeamBody() {
        return <div> Select a Team:
            <select className="form-control" ref="teamSelect">
                {
                    this.props.coachAccount.teams.map(function(t, index){
                        return <option key={t.id} value={t.id}>{t.name}</option>
                    }.bind(this))
                }
            </select>
            Select a goal for this athlete:
            <div className="row pick-goal">
                <div className="col-xs-4 text-center">
                    <VCircleCheck id={2} ref={C.MASS} uncontrolled={true}
                                  label={'Add Muscle'} change={ this.goalChanged } />
                </div>

                <div className="col-xs-4 text-center mid-option">
                    <VCircleCheck id={3} ref={C.RIP} uncontrolled={true}
                                  label={'Moderate muscle gains, lower body fat'}  change={ this.goalChanged }/>
                </div>

                <div className="col-xs-4 text-center">
                    <VCircleCheck ref={C.LEAN} id={1} uncontrolled={true}
                                  label={'Lose Weight, Build Endurance'} change={ this.goalChanged } />
                </div>
            </div>
            <FancyInput placeholder="Email or Mobile #" type="text" ref="contactInfo"
                        errors={this.state.contactError} />
        </div>
    }

    choseTeamFooter() {
        return <div>
            <Button buttonText='Send Invite' onClick={this.sendTeamInvite} />
        </div>
    }

    sendTeamInvite() {
        if (this.state.goal) {
            var contactInfo = this.refs.contactInfo.getValue();
            if (!validator.isEmail(contactInfo) && !validator.isMobilePhone(contactInfo, 'en-US') && contactInfo.length > 5) {
                this.setState({contactError: ['Please enter a valid email or mobile number']});
            } else {
                this.setState({contactError: []});
                var teamId = this.refs.teamSelect.value;
                CoachActions.sendInvite(contactInfo, teamId, 'team', this.inviteSent, this.state.goal);
            }
        } else {
            this.setState({error: 'Please choose a goal for this athlete'});
        }
    }

    cancel() {
        this.setState({step: 'choose-option'});
        this.props.cancel();
    }

    inviteSent(response) {
        if (response.status == 'success') {
            this.setState({step: 'invite-sent'});
            CoachActions.getAccount(gon.coach_account_id);
        } else {
            this.setState({error: response.message});
        }
    }

    render () {
        return <Modal show={this.props.show} className="add-athlete" onHide={this.cancel}>
                <Modal.Header closeButton>
                    <Modal.Title>Add an Athlete</Modal.Title>
                </Modal.Header>

                <Modal.Body>
                    <Choose>
                        <When condition={this.state.step == 'choose-option'}>
                            {this.chooseOptionBody()}
                        </When>
                        <When condition={this.state.step == 'chose-team'}>
                            {this.choseTeamBody()}
                        </When>
                        <When condition={this.state.step == 'invite-sent'}>
                            {this.sentBody()}
                        </When>
                    </Choose>
                    {this.state.error}
                </Modal.Body>

                <Modal.Footer>
                    <Choose>
                        <When condition={this.state.step == 'choose-option'}>
                            {this.chooseOptionFooter()}
                        </When>
                        <When condition={this.state.step == 'chose-team'}>
                            {this.choseTeamFooter()}
                        </When>
                        <When condition={this.state.step == 'invite-sent'}>
                            {this.sentFooter()}
                        </When>
                    </Choose>
                </Modal.Footer>
            </Modal>;
    }
}

export default AddAthleteModal;