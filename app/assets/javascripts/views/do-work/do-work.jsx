import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';
import RoutineStore from 'stores/routine_store';
import UserStore from 'stores/user_store';
import ExerciseStore from 'stores/exercise_store';
import QuadPodStore from 'stores/quad_pod_store';
import RoutineActions from 'actions/routine_actions';
import UserActions from 'actions/user_actions';
import ExerciseActions from 'actions/exercise_actions';
import Header from 'views/common/header';
import Calendar from 'views/do-work/calendar';
import Stretch from 'views/do-work/stretch';
import Custom from 'views/do-work/custom';
import Strength from 'views/do-work/strength';
import Plyo from 'views/do-work/plyo';
import Sprint from 'views/do-work/sprint';
import C from 'constants/routine_constants';
import MenuModal from 'views/do-work/menu_modal';
import Button from 'views/common/button';
import Comment from 'views/do-work/comment';
import QuadPod from 'views/quad-pod/quad-pod';
import Footer from 'views/common/footer';
import Progress from 'views/do-work/progress';
import TeamActions from 'actions/team_actions';
import TeamStore from 'stores/team_store';
import { Modal } from 'react-bootstrap';
import CoachActions from 'actions/coach_actions';
import validator from 'validator';
import FancyInput from 'views/common/fancy_input';
import FeedItem from 'views/quad-pod/feed_item.jsx';
import Clipboard from 'clipboard';

class DoWork extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            showAddEx: false,
            sendTo: undefined,
            sendToErrors: [],
            showMessagesModal: false,
            closingWorkout: false,
            showSaveChanges: false,
            showShareWorkout: false,
            linkCopied: false,
            titles: ['Awesome!', 'Nice!', 'Sweet!', 'Dope!', 'Tight!', 'Mint!', 'Fresh!', 'Epic!']
        };
        this.addEx = this.addEx.bind(this);
        this.closeAddEx = this.closeAddEx.bind(this);
        this.weightChanged = this.weightChanged.bind(this);
        this.saveSendTo = this.saveSendTo.bind(this);
        this.finishOnboarding = this.finishOnboarding.bind(this);
        this.closeMessages = this.closeMessages.bind(this);
        this.saveChanges = this.saveChanges.bind(this);
        this.closeSaveChanges = this.closeSaveChanges.bind(this);
        this.showShareWorkout = this.showShareWorkout.bind(this);
        this.closeShareWorkout = this.closeShareWorkout.bind(this);
        this.exitingPage = this.exitingPage.bind(this);
        this.saveSendTo = this.saveSendTo.bind(this);
        this.evalTeamName = this.evalTeamName.bind(this);
    }

    componentDidMount() {
        $(window).unload(this.exitingPage);
    }

    componentWillUnmount () {
        $(window).off('unload', this.exitingPage);
    }

    exitingPage() {
        if (gon.viewing == 'user' && this.props.dirty) {
            console.log('executing');
            RoutineActions.saveWorkout(this.props.routine);
        }
    }

    componentWillReceiveProps(nextProps) {
        var clipboard = new Clipboard('.copy-link');
        clipboard.on('success', function(e) {
            this.setState({linkCopied: true});
        }.bind(this));
        if (this.state.closingWorkout && nextProps.routine && nextProps.routine.messages.length > 0) {
            this.setState({showMessagesModal: true, closingWorkout: false});
        }
    }

    closeMessages() {
        this.setState({showMessagesModal: false});
    }

    weightChanged() {
        RoutineActions.userWeightChanged(this.refs.userWeight.value);
    }

    saveSendTo(value) {
        if (!validator.isEmail(value) && !validator.isMobilePhone(value, 'en-US') && value.length > 5) {
            this.setState({sendToErrors: ['Please enter a valid email or mobile number']});
        } else {
            this.setState({sendTo: value, sendToErrors: []});
        }

    }

    evalTeamName(name) {
        if (validator.isLength(name, {min: 2})) {
            this.setState({newTeamErrors: [], sendTo: name});
        } else {
            this.setState({newTeamErrors: ['Team names must be at least 2 characters']});
        }
    }
    
    showShareWorkout() {
        this.setState({showShareWorkout: true, showMessagesModal: false});
    }

    closeShareWorkout() {
        this.setState({showShareWorkout: false, linkCopied: false});
    }

    addEx(e, is_custom) {
        if (is_custom) {
            RoutineActions.addCustomExercise(this.props.routine.id, this.state.exercise_type, e);
        } else {
            RoutineActions.addExercise(this.props.routine.id, this.state.exercise_type, e);
        }
        this.setState({showAddEx: false});
    }

    closeAddEx() {
        this.setState({showAddEx: false});
    }

    showAddEx(type) {
        this.setState({showAddEx: true, exercise_type: type});
    }

    saveChanges(saveChanges) {
        this.setState({showSaveChanges: false});
        if (saveChanges) {
            RoutineActions.saveChanges();
            this.props.routine.changes_saved = true;
        }
        this.submit();
    }

    submit() {
        var userWeight = this.refs.userWeight.value;
        if ((!userWeight) || isNaN(userWeight)) {
            $(this.refs.userWeight).addClass('error');
            this.setState({errors: 'Please enter your weight!'});
        } else {
            if (this.props.routine.modified && !this.props.routine.changes_saved) {
                $(this.refs.userWeight).removeClass('error');
                this.setState({errors: undefined, showSaveChanges: true});
            } else {
                $(this.refs.userWeight).removeClass('error');
                this.setState({errors: undefined, closingWorkout: true});
                this.props.submitWorkout(this.props.routine);
            }
        }
    }

    closeSaveChanges() {
        this.setState({showSaveChanges: false});
    }

    reset() {
        var r=confirm("Are you sure you want to remove all of your modifications to this workout?");
        if (r==true) {
            RoutineActions.resetRoutine(this.props.routine.id);
        }
    }

    leaveComment() {
        var commentText = this.refs.commentBox.value;
        this.refs.commentBox.value = '';
        if (commentText) {
            RoutineActions.postComment(this.props.routine.id, commentText);
        }
    }

    finishOnboarding() {
        this.props.finishOnboarding(this.state.sendTo);
    }

    formatValue(value) {
        if (value == null) {
            return '';
        } else {
            return value;
        }
    }

    render () {
        return <div className="do-work">
            <If condition={!this.props.shared}>
                <Calendar {...this.props} />

                <div className="row subnav no-margin">
                    <div className="col-xs-12 text-center subnav-cluster">
                        <If condition={gon.viewing != 'team' && this.props.routine.id } >
                            <span onClick={ () => this.submit()} >
                                <img className="hidden-xs" src="https://dwx350bwdtt59.cloudfront.net/Icon+-+Complete.png" /> Complete this Workout
                            </span>
                        </If>
                        <span><a className="no-hover" href="/schedule"><img className="hidden-xs" src="https://dwx350bwdtt59.cloudfront.net/Icon+-+Change+Schedule.png" /> Change Schedule</a></span>
                        <If condition={gon.viewing != 'team' && this.props.routine.id } >
                            <div className="visible-micro"></div>
                        </If>
                        <span><a className="no-hover" href="/program"><img className="hidden-xs" src="https://dwx350bwdtt59.cloudfront.net/Icon+-+Change+Program.png" /> Change Program</a></span>
                        <If condition={gon.viewing != 'team' && this.props.routine.id } >
                            <span onClick={this.showShareWorkout}><img className="hidden-xs" src="https://dwx350bwdtt59.cloudfront.net/Icon+-+Share+Workout.png" />Share Workout</span>
                        </If>
                    </div>

                </div>
            </If>
            <div className="row main no-margin">
                <div className="container">
                    <div className={this.props.loading ? 'loading row' : 'row'}>

                        <div className="stretching sec container">
                            <If condition={this.state.errors} >
                                <div className="row">
                                    <div className="col-xs-12 text-center errors">
                                        {this.state.errors}
                                    </div>
                                </div>
                            </If>
                            <If condition={!this.props.loading && !this.props.routine.id && (this.props.week_days[this.props.day_index])} >
                                <div className="row">
                                    <div className="col-xs-12 text-center future">
                                        You're scheduled to workout this day, but the workout hasn't been created yet.
                                    </div>
                                </div>
                            </If>
                            <div className="row sec-header">
                                <div className="col-sm-8 col-sm-offset-0 col-xs-12">
                                    <span>Preparation</span>
                                </div>
                                <If condition={!this.props.shared} >
                                    <div className="add-ex col-sm-4 text-right col-xs-12" onClick={ () => this.showAddEx('warmups')}>Add Exercise</div>
                                </If>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.props.routine &&
                                        (this.props.routine.performed_warm_ups && this.props.routine.performed_warm_ups.length > 0) ||
                                        _.where(this.props.routine.custom_exercises, {ex_type: 4}).length > 0 }>
                                        {
                                            this.props.routine.performed_warm_ups.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Stretch exercises={this.props.exercises} exercise={e} key={e.id}
                                                                closed={this.props.routine.closed} shared={this.props.shared} />
                                            }.bind(this))
                                        }

                                        {
                                            _.where(this.props.routine.custom_exercises, {ex_type: 4}).map(function(ex, index) {
                                                return <Custom exercise={ex} />

                                            }.bind(this))

                                        }
                                    </When>
                                    <When condition={!this.props.loading} >
                                        <div className="row">
                                            <div className="col-xs-12 text-center">
                                                <If condition={!this.props.shared} >
                                                    <span className="no-exercises">Quadfit hasn't scheduled any Stretching/Warmup exercises for you.
                                                        You can <span className="norm-link" onClick={ () => this.showAddEx('warmups')}>add some</span> if you want!</span>
                                                </If>
                                            </div>
                                        </div>
                                    </When>
                                </Choose>
                            </div>
                        </div>

                        <div className="strength-sec sec container">
                            <div className="row sec-header">
                                <div className="col-sm-8 col-sm-offset-0 col-xs-12">
                                    <span>Strength Training</span>
                                </div>
                                <If condition={!this.props.shared} >
                                    <div className="add-ex col-sm-4 text-right col-xs-12" onClick={ () => this.showAddEx('weights')}>Add Exercise</div>
                                </If>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.props.routine &&
                                    (this.props.routine.performed_exercises && this.props.routine.performed_exercises.length > 0) ||
                                    _.where(this.props.routine.custom_exercises, {ex_type: 1}).length > 0}>
                                        {
                                            this.props.routine.performed_exercises.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Strength exercises={this.props.exercises} exercise={e} key={e.id}
                                                                 closed={this.props.routine.closed} shared={this.props.shared} />
                                            }.bind(this))
                                        }

                                        {
                                            _.where(this.props.routine.custom_exercises, {ex_type: 1}).map(function(ex, index) {
                                                return <Custom exercise={ex} />

                                            }.bind(this))

                                        }
                                    </When>
                                    <When condition={!this.props.loading} >
                                        <div className="row">
                                            <div className="col-xs-12 text-center">
                                                <If condition={!this.props.shared} >
                                                    <span className="no-exercises">Quadfit hasn't scheduled any Strength Training exercises for you.
                                                        You can <span className="norm-link" onClick={ () => this.showAddEx('weights')}>add some</span> if you want!</span>
                                                </If>
                                            </div>
                                        </div>
                                    </When>
                                </Choose>
                            </div>
                        </div>

                        <div className="plyos sec container">
                            <div className="row sec-header">
                                <div className="col-sm-8 col-sm-offset-0 col-xs-12">
                                    <span>Plyometrics</span>
                                </div>
                                    <If condition={!this.props.shared} >
                                        <div className="add-ex col-sm-4 text-right col-xs-12" onClick={ () => this.showAddEx('plyos')}>Add Exercise</div>
                                    </If>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.props.routine &&
                                    (this.props.routine.performed_plyometrics && this.props.routine.performed_plyometrics.length > 0) ||
                                    _.where(this.props.routine.custom_exercises, {ex_type: 2}).length > 0 }>
                                        {
                                            this.props.routine.performed_plyometrics.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Plyo exercises={this.props.exercises} exercise={e} key={e.id}
                                                             closed={this.props.routine.closed} shared={this.props.shared} />
                                            }.bind(this))
                                        }

                                        {
                                            _.where(this.props.routine.custom_exercises, {ex_type: 2}).map(function(ex, index) {
                                                return <Custom exercise={ex} />

                                            }.bind(this))

                                        }
                                    </When>
                                    <When condition={!this.props.loading} >
                                        <div className="row">
                                            <div className="col-xs-12 text-center">
                                                <If condition={!this.props.shared} >
                                                    <span className="no-exercises">Quadfit hasn't scheduled any Plyometric exercises for you.
                                                        You can <span className="norm-link" onClick={ () => this.showAddEx('plyos')}>add some</span> if you want!</span>
                                                </If>
                                            </div>
                                        </div>
                                    </When>
                                </Choose>
                            </div>
                        </div>

                        <div className="sprinting sec container">
                            <div className="row sec-header">
                                <div className="col-sm-8 col-sm-offset-0 col-xs-12">
                                    <span>Sprinting</span>
                                </div>
                                    <If condition={!this.props.shared} >
                                        <div className="add-ex col-sm-4 text-right col-xs-12" onClick={ () => this.showAddEx('sprinting')}>Add Exercise</div>
                                    </If>
                            </div>
                            <div className="exercise-section">
                                <Choose>
                                    <When condition={this.props.routine &&
                                    (this.props.routine.performed_sprints && this.props.routine.performed_sprints.length > 0) ||
                                    _.where(this.props.routine.custom_exercises, {ex_type: 4}).length > 3} >
                                        {
                                            this.props.routine.performed_sprints.map(function(e, index) {
                                                if (e.status == 2) {
                                                    return;
                                                }
                                                return <Sprint exercises={this.props.exercises} exercise={e} key={e.id}
                                                               closed={this.props.routine.closed} shared={this.props.shared} />
                                            }.bind(this))
                                        }

                                        {
                                            _.where(this.props.routine.custom_exercises, {ex_type: 4}).map(function(ex, index) {
                                                return <Custom exercise={ex} />

                                            }.bind(this))

                                        }
                                    </When>
                                    <When condition={!this.props.loading} >
                                        <div className="row">
                                            <div className="col-xs-12 text-center">
                                                <If condition={!this.props.shared} >
                                                    <span className="no-exercises">Quadfit hasn't scheduled any Sprinting for you.
                                                        You can <span className="norm-link" onClick={ () => this.showAddEx('sprinting')}>add some</span> if you want!</span>
                                                </If>
                                            </div>
                                        </div>
                                    </When>
                                </Choose>
                            </div>
                            <If condition={this.state.errors} >
                                <div className="row">
                                    <div className="col-xs-12 text-center errors">
                                        {this.state.errors}
                                    </div>
                                </div>
                            </If>
                            <If condition={!this.props.shared && this.props.routine.id} >
                            <div className="row last-row">
                                <div className="col-sm-4 col-xs-12">
                                    <If condition={this.props.routine.id && gon.viewing == 'user'} >
                                        <input ref="userWeight" type="text" className="user-weight" value={this.formatValue(this.props.routine.weight)} onChange={this.weightChanged}/>
                                        <span className="standard-text white ">Your Weight (lbs)</span>
                                    </If>
                                </div>
                                <div className="hidden-xs col-sm-8 text-right action-row">
                                        <span className="reset-link" onClick={() => this.reset()}>Reset Workout</span>
                                        <If condition={this.props.routine.id && gon.viewing == 'user'} >
                                            <Button ref="completeWorkout" buttonText="Complete Workout" onClick={ () => this.submit() }
                                                    disabled={this.state.closingWorkout} inverse={true}/>
                                        </If>
                                </div>
                                <div className="col-xs-12 visible-xs text-center action-row">
                                    <If condition={this.props.routine.id && gon.viewing == 'user'} >
                                        <Button ref="completeWorkout" buttonText="Complete Workout" onClick={ () => this.submit() }
                                                disabled={this.state.closingWorkout} inverse={true}/>
                                    </If>
                                </div>
                                <div className="col-xs-12 visible-xs text-center reset-row">
                                    <span className="reset-link" onClick={() => this.reset()}>Reset Workout</span>
                                </div>
                            </div>
                            </If>
                        </div>
                        <If condition={this.props.routine.id && (gon.viewing == 'user' || (this.props.shared && this.props.loggedInUser))} >
                            <div className="comments sec container">
                                <div className="row">
                                    <div className="col-xs-12 sec-header">{(gon.user_id) ? 'Leave a comment' : 'Comments'}</div>
                                </div>
                                {
                                    this.props.routine.comments.map(function(e, index) {
                                        return <FeedItem
                                            item={e}
                                            key={e.id}
                                            poster={e.poster}
                                            created_at={e.created_at}
                                            message={e.message}
                                            stripHtml={true}
                                        />
                                    }.bind(this))
                                }
                                <div className="row comment-row text-right">
                                    <div className="col-sm-12 col-md-8 col-xs-12">
                                        <If condition={gon.user_id} >
                                        <textarea ref="commentBox" className="leave-comment" rows="10"></textarea>
                                        <Button ref="leaveComment" buttonText="Post" onClick={ () => this.leaveComment() }
                                                disabled={false} />
                                        </If>
                                    </div>
                                </div>
                            </div>
                        </If>
                    </div>
                </div>
            </div>
            <MenuModal
                show={this.state.showAddEx}
                close={this.closeAddEx}
                click={this.addEx}
                exercises={this.props.exercises}
                type={this.state.exercise_type}
                premiumAccess={this.props.user.has_premium_access}
            />
            <Modal show={this.props.showActionModal} >
                <Modal.Header>
                    <Modal.Title>Last Step - {(this.props.context == 'coach_sub') ? 'Send this workout to someone!' : 'Give this team a name!'}</Modal.Title>
                </Modal.Header>
                <Modal.Body className="coach-invite-modal">
                    <If condition={this.props.context == 'coach_sub'} >
                        <div className="more-info">They'll be notified that you created this workout for them, and we'll notify you once they sign up.</div>
                        <FancyInput placeholder="Email or Mobile #" type="text" changedCallback={this.saveSendTo}
                                    errors={this.state.sendToErrors} />
                        <span>{this.props.finishErrors}</span>
                    </If>
                    <If condition={this.props.context == 'coach_team'} >
                        <div className="more-info">Give this team a name. In a moment you'll be able to invite athletes to join this team.</div>
                        <FancyInput placeholder="Team Name" type="text" changedCallback={this.evalTeamName}
                                    errors={this.state.newTeamErrors} />
                    </If>
                </Modal.Body>
                <Modal.Footer>
                    <Button buttonText="Submit" onClick={this.finishOnboarding}>{(this.props.context == 'coach_sub') ? 'Send' : 'Save'}</Button>
                </Modal.Footer>
            </Modal>

            <Modal show={this.state.showSaveChanges} onHide={this.closeSaveChanges}>
                <Modal.Header closeButton>
                    <Modal.Title>Save changes?</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    Yo! Looks like you've modified this workout. Do you want to save these changes for future workouts?
                </Modal.Body>
                <Modal.Footer>
                    <Button buttonText="Nope" onClick={() => this.saveChanges(false)}>Nope</Button>
                    <Button buttonText="Yep" onClick={() => this.saveChanges(true)}>Yep</Button>
                </Modal.Footer>
            </Modal>

            <Modal show={this.state.showShareWorkout} onHide={this.closeShareWorkout} className="shareModal" animation={false}>
                <Modal.Header closeButton>
                    <Modal.Title>Share this Workout!</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <span className="share-section row">
                        <span className="col-sm-6 col-xs-12 text-center">
                            <input type="text" className="link-input" value={this.props.routine.share_link} readOnly/><button
                            data-clipboard-target=".link-input" className="qfButton btn btn-default copy-link" >{(this.state.linkCopied) ? 'Copied!' : 'Copy'}</button>
                        </span>

                        <a className="col-sm-3 col-xs-6" href={"http://twitter.com/share?text=Check out my Quadfit workout&url=" + this.props.routine.share_link}
                           title="Share on Twitter" target="_blank" >
                            <img className="img-circle" src="https://dwx350bwdtt59.cloudfront.net/social-twitter.png" height="32" width="32"/> Twitter</a>

                        <a className="col-sm-3 col-xs-6" href={"http://www.facebook.com/sharer.php?u=" + this.props.routine.share_link}
                           title="Share on Facebook" target="_blank" >
                            <img className="img-circle" src="https://dwx350bwdtt59.cloudfront.net/social-facebook.png" height="32" width="32"/> Facebook</a>
                    </span>
                </Modal.Body>
            </Modal>

            <If condition={this.props.routine && this.props.routine.messages && this.props.routine.messages.length > 0}>
                <Modal show={this.state.showMessagesModal && this.props.routine.messages.length > 0} onHide={this.closeMessages} className="messages-modal">
                    <Modal.Header closeButton>
                        <Modal.Title></Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                        <If condition={this.props.routine.count_ex_completed > 0} >
                            <div className="messages-title">
                                {this.state.titles[Math.ceil(Math.random() * (this.state.titles.length)) - 1]}
                            </div>
                        </If>
                        <If condition={this.props.routine.count_ex_completed == 0} >
                            <div className="messages-title">
                                Ok!
                            </div>
                        </If>
                        <div className="messages-text">
                            {
                                this.props.routine.messages.map(function(e) {
                                    return <div className="workout-message" key={e.id}>{e.message}</div>
                                }.bind(this))
                            }
                        </div>
                        <div className="share-cta">Share this workout!</div>
                        <span className="share-section row">
                            <span className="col-sm-6 col-xs-12">
                                <input type="text" className="link-input" value={this.props.routine.share_link} readOnly/><button
                                data-clipboard-target=".link-input" className="qfButton btn btn-default copy-link" >{(this.state.linkCopied) ? 'Copied!' : 'Copy'}</button>
                            </span>
                            <a className="col-sm-3 col-xs-6" href="http://twitter.com/share?text=My Quadfit Workout&url=http://www.quadfit.com/share.html"
                               title="Share on Twitter" target="_blank" >
                                <img className="img-circle" src="https://dwx350bwdtt59.cloudfront.net/social-twitter.png" height="32" width="32"/> Twitter</a>

                            <a className="col-sm-3 col-xs-6" href="http://www.facebook.com/sharer.php?u=http://www.quadfit.com/share.html?<?echo $share?>"
                               title="Share on Facebook" target="_blank" >
                                <img className="img-circle" src="https://dwx350bwdtt59.cloudfront.net/social-facebook.png" height="32" width="32"/> Facebook</a>
                        </span>
                    </Modal.Body>
                </Modal>
            </If>
            <If condition={this.props.loading || this.state.closingWorkout} >
                <div className="loading-overlay"><img src="https://dwx350bwdtt59.cloudfront.net/loading-ring-164.gif" /></div>
            </If>
        </div>;
    }
}

export default DoWork;
