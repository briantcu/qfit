import {render} from 'react-dom';
import Thumbnail from 'views/do-work/thumbnail';
import WeightSet from 'views/do-work/weight_set';
import VertCircleCheck from 'views/common/vert_circle_check';
import TipsModal from 'views/do-work/tips_modal';
import VideoModal from 'views/do-work/video_modal';
import MenuModal from 'views/do-work/menu_modal';
import RoutineActions from 'actions/routine_actions';

require('views/do-work/strength.scss');

class Strength extends React.Component {
    constructor(props) {
        super(props);
        this.close = this.close.bind(this);
        this.showVideo = this.showVideo.bind(this);
        this.closeVideo = this.closeVideo.bind(this);
        this.showSwap = this.showSwap.bind(this);
        this.closeSwap = this.closeSwap.bind(this);
        this.swap = this.swap.bind(this);
        this.state = {
            showTips: false,
            showVideo: false,
            showSwap: false,
            similar: this.getSimilar(props)
        };
    }

    componentWillReceiveProps(nextProps) {
        var exercises = this.getSimilar(nextProps);
        this.setState({similar: exercises});
    }

    getSimilar(props) {
        var exercises = [];
        if (props.exercises.exercises) {
            exercises = props.exercises.exercises[this.props.exercise.exercise_type.id - 1].exercises;
        }
        return exercises
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
    }
    closeSwap() {
        this.setState({showSwap: false});
    }

    swap(exercise) {
        RoutineActions.swapStrength(this.props.exercise.id, exercise);
        this.setState({showSwap: false});
    }

    delete() {
        var r=confirm("Are you sure you want to remove this exercise?");
        if (r==true) {
            RoutineActions.deleteExercise('exercises', this.props.exercise.id);
        }
    }

    render() {
        var classes = (this.props.border) ? 'strength exercise row top-border' : 'strength exercise row';
        return <div className={classes} >
            <div className="col-xs-5">
                <Thumbnail exercise={this.props.exercise.exercise} click={this.showVideo} />
                <span className="ex-info">
                    <div className="type-name">{this.props.exercise.exercise_type.type_name}</div>
                    <div className="ex-name">{this.props.exercise.exercise.name}</div>
                    <div className="ex-subtext">Rest for {this.props.exercise.rest_period} seconds between sets </div>
                    <div className="ex-subtext">
                        <u className="link" onClick={ () => this.showTips()}>Read Tips</u> |
                        <u className="link" onClick={ () => this.showSwap()}>Swap</u> |
                        <u className="link" onClick={ () => this.delete()}>Delete</u>
                    </div>
                </span>
            </div>
            <If condition={gon.viewing == 'user'}>
                <div className="col-xs-7">
                    {
                        this.props.exercise.weight_sets.map(function(e, index) {
                            return <WeightSet weightSet={e} gray={index % 2 == 0} key={this.props.exercise.id + '' + (index + 1)}
                                              setNum={index + 1} exercise={this.props.exercise.exercise} disabled={this.props.closed} />;
                        }.bind(this))
                    }
                </div>
            </If>
            <TipsModal show={this.state.showTips} tips={this.props.exercise.exercise.tips} close={this.close} />
            <VideoModal show={this.state.showVideo} link={this.props.exercise.exercise.video_link} close={this.closeVideo} />
            <MenuModal show={this.state.showSwap} close={this.closeSwap} click={this.swap} {...this.props}
                       exercise_subset={this.state.similar} />
        </div>
    }
}

export default Strength;