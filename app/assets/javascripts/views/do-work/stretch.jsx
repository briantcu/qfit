import {render} from 'react-dom';
import Thumbnail from 'views/do-work/thumbnail'
import VertCircleCheck from 'views/common/vert_circle_check'
import { Modal } from 'react-bootstrap';
import Button from 'views/common/button';
import TipsModal from 'views/do-work/tips_modal';
import VideoModal from 'views/do-work/video_modal';
import MenuModal from 'views/do-work/menu_modal';
import RoutineActions from 'actions/routine_actions';
import RoutineConstants from 'constants/routine_constants';

require('views/do-work/stretch.scss');

class Stretch extends React.Component {
    constructor(props) {
        super(props);
        this.change = this.change.bind(this);
        this.close = this.close.bind(this);
        this.closeVideo = this.closeVideo.bind(this);
        this.closeSwap = this.closeSwap.bind(this);
        this.showVideo = this.showVideo.bind(this);
        this.showSwap = this.showSwap.bind(this);
        this.swap = this.swap.bind(this);

        this.state = {
            showTips: false,
            showVideo: false,
            showSwap: false,
            similar: this.getSimilar(props)
        };
    }

    getSimilar(props) {
        var exercises = [];
        if (props.exercises && props.exercises.warmups) {
            if (props.exercise.warmup.ex_type == 3) {
                exercises = props.exercises.warmups.warm_up;
            } else if (props.exercise.warmup.ex_type == 2) {
                exercises = props.exercises.warmups.dynamic_stretch;
            } else {
                exercises = props.exercises.warmups.static_stretch;
            }
        }
        return exercises
    }

    componentWillReceiveProps(nextProps) {
        var exercises = this.getSimilar(nextProps);
        this.setState({similar: exercises});
    }

    change(elem) {
        var check = this.refs.complete;
        var completed = check.getValue();
        RoutineActions.storeResults(RoutineConstants.WARMUP, this.props.exercise.id, 0, completed);
    }
    showTips() {
        this.setState({showTips: true});
    }
    close() {
        this.setState({showTips: false});
    }
    showVideo() {
        this.setState({showVideo: true});
    }
    closeVideo() {
        this.setState({showVideo: false});
    }
    showSwap() {
        this.setState({showSwap: true});
        this.props.maybeSaveRoutine();
    }
    closeSwap() {
        this.setState({showSwap: false});
    }

    swap(exercise) {
        RoutineActions.swapWarmup(this.props.exercise.id, exercise);
        this.setState({showSwap: false});
    }

    delete() {
        this.props.maybeSaveRoutine();
        var r=confirm("Are you sure you want to remove this exercise?");
        if (r==true) {
            RoutineActions.deleteExercise('warm_ups', this.props.exercise.id);
        }
    }

    render() {
        return <div className={'stretch exercise row ' + 'exercise-' + this.props.index}>
            <div className="col-sm-3 col-md-2 col-xs-12 thumb-col">
                <Thumbnail exercise={this.props.exercise.warmup} click={this.showVideo}/>
            </div>
            <div className="col-xs-12 col-sm-8 col-md-9 info-col">
                <span className="ex-info">
                    <div className="ex-name">{this.props.exercise.warmup.name}</div>
                    <div className="ex-subtext">
                        Recommended: {this.props.exercise.warmup.ex_type != 3 ? '3 x 30 seconds' : '5 minutes'}&nbsp;
                        {this.props.exercise.warmup.ex_type != 1 ? '(Perform before the rest of your workout)' : '(Perform after your workout)'}
                    </div>
                    <div className="ex-subtext">
                        <u className="link" onClick={ () => this.showTips()} >Read Tips</u>&nbsp;
                        <If condition={!this.props.shared && !gon.is_sub_user} >
                           | <u className="link" onClick={ () => this.showSwap()} >Swap</u> |&nbsp;
                            <u className="link" onClick={ () => this.delete()}>Delete</u>
                        </If>
                    </div>
                </span>
            </div>
            <If condition={gon.viewing == 'user' || this.props.shared}>
                <div className="col-sm-1 col-xs-12 input-col">
                    <VertCircleCheck ref="complete"
                                     id={'stretch' + this.props.exercise.id}
                                     disabled={this.props.shared}
                                     checked={this.props.exercise.completed}
                                     label={'Complete'}
                                     change={ this.change }/>
                </div>
            </If>
            <TipsModal show={this.state.showTips} tips={this.props.exercise.warmup.tips} close={this.close} />
            <VideoModal show={this.state.showVideo} tips={this.props.exercise.warmup.tips}
                        name={this.props.exercise.warmup.name}
                        link={this.props.exercise.warmup.video_link} close={this.closeVideo} />
            <MenuModal show={this.state.showSwap} close={this.closeSwap} click={this.swap} {...this.props}
                       exercise_subset={this.state.similar}/>
        </div>
    }
}

export default Stretch;