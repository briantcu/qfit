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
        this.scrollRight = this.scrollRight.bind(this);
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
        if (props.exercises && props.exercises.exercises && props.exercises.exercises.length > 0) {
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

    scrollRight() {
        $(this.refs.sets).animate({
            scrollLeft: "+=200px"
        }, "slow");
    }

    render() {
        return <div className='strength exercise row' >
            <div className="col-xs-3 col-md-2 thumb-col">
                <Thumbnail exercise={this.props.exercise.exercise} click={this.showVideo} />
            </div>
            <div className="col-xs-9 col-md-3 info-col">
                <span className="ex-info">
                    <div className="type-name">{this.props.exercise.exercise_type.type_name}</div>
                    <div className="ex-name">{this.props.exercise.exercise.name}</div>
                    <div className="ex-subtext">Rest for {this.props.exercise.rest_period} seconds between sets </div>
                    <div className="ex-subtext">
                        <u className="link" onClick={ () => this.showTips()}>Read Tips</u>&nbsp;
                        <If condition={!this.props.shared && !gon.is_sub_user} >
                            | <u className="link" onClick={ () => this.showSwap()}>Swap</u> |&nbsp;
                            <u className="link" onClick={ () => this.delete()}>Delete</u>
                        </If>
                    </div>
                </span>
            </div>
            <If condition={gon.viewing == 'user' || this.props.shared}>
                <div className="col-xs-12 col-md-7 weight-sets-col">
                    <div className="sets-wrapper" ref="sets">
                        <div className="weight-set  recommended">
                            Recommended:<br/>
                            Completed:
                        </div>
                        {
                            this.props.exercise.weight_sets.map(function(e, index) {
                                return <WeightSet weightSet={e} gray={index % 2 == 0} key={this.props.exercise.id + '' + (index + 1)}
                                                  setNum={index + 1} exercise={this.props.exercise.exercise} disabled={this.props.shared} />;
                            }.bind(this))
                        }
                    </div>
                    <div onClick={this.scrollRight} className="scroll-indicator">
                        <img src="https://dwx350bwdtt59.cloudfront.net/more-arrow.png" />
                    </div>
                </div>
            </If>
            <TipsModal show={this.state.showTips} tips={this.props.exercise.exercise.tips} close={this.close} />
            <VideoModal show={this.state.showVideo} tips={this.props.exercise.exercise.tips}
                        name={this.props.exercise.exercise.name}
                        link={this.props.exercise.exercise.video_link} close={this.closeVideo} />
            <MenuModal show={this.state.showSwap} close={this.closeSwap} click={this.swap} {...this.props}
                       exercise_subset={this.state.similar} premiumAccess={this.props.premiumAccess}/>
        </div>
    }
}

export default Strength;