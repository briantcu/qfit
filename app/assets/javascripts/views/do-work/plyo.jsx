import {render} from 'react-dom';
import Thumbnail from 'views/do-work/thumbnail';
import VertCircleCheck from 'views/common/vert_circle_check';
import TipsModal from 'views/do-work/tips_modal';
import VideoModal from 'views/do-work/video_modal';
import MenuModal from 'views/do-work/menu_modal';
import RoutineActions from 'actions/routine_actions';
import RoutineConstants from 'constants/routine_constants';

require('views/do-work/plyo.scss');

class Plyo extends React.Component {
    constructor(props) {
        super(props);
        this.close = this.close.bind(this);
        this.change = this.change.bind(this);
        this.showVideo = this.showVideo.bind(this);
        this.closeVideo = this.closeVideo.bind(this);
        this.showSwap = this.showSwap.bind(this);
        this.closeSwap = this.closeSwap.bind(this);
        this.swap = this.swap.bind(this);
        this.state = {
            showTips: false,
            showVideo: false,
            showSwap: false
        };
    }

    showTips() {
        this.setState({showTips: true});
    }

    close() {
        this.setState({showTips: false});
    }
    change(elem) {
        var check = this.refs[elem.target.id];
        var checked = check.getValue();
        RoutineActions.storeResults(RoutineConstants.PLYOS, this.props.exercise.id, this.refs[elem.target.id].props.setNum, checked);
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
        RoutineActions.swapPlyo(this.props.exercise.id, exercise);
        this.setState({showSwap: false});
    }

    delete() {
        var r=confirm("Are you sure you want to remove this exercise?");
        if (r==true) {
            RoutineActions.deleteExercise('plyometrics', this.props.exercise.id);
        }
    }

    render() {
        var classes = (this.props.border) ? 'plyo exercise row top-border' : 'plyo exercise row';
        return <div className={classes} >
            <div className="col-xs-5">
                <Thumbnail exercise={this.props.exercise.plyometric} click={this.showVideo} />
                <span className="ex-info">
                    <div className="ex-name">{this.props.exercise.plyometric.name}</div>
                    <div className="ex-subtext">Recommended: {this.props.exercise.plyometric.recommended}</div>
                    <div className="ex-subtext">
                        <u className="link" onClick={ () => this.showTips()}>Read Tips</u> |
                        <u className="link" onClick={ () => this.showSwap()} >Swap</u> |
                        <u className="link" onClick={ () => this.delete()}>Delete</u>
                    </div>
                </span>
            </div>
            <div className="col-xs-1 col-xs-offset-4">
                <VertCircleCheck ref={this.props.exercise.id + '1'} id={this.props.exercise.id + '1'}
                                 setNum={1} defaultChecked={this.props.exercise.peformed_one} label={'Complete'} change={ this.change } />
            </div>
            <div className="col-xs-1">
                <VertCircleCheck ref={this.props.exercise.id + '2'} id={this.props.exercise.id + '2'}
                                 setNum={2} defaultChecked={this.props.exercise.performed_two} label={'Complete'} change={ this.change } />
            </div>
            <div className="col-xs-1">
                <VertCircleCheck ref={this.props.exercise.id + '3'} id={this.props.exercise.id + '3'}
                                 setNum={3} defaultChecked={this.props.exercise.performed_three} label={'Complete'} change={ this.change } />
            </div>

            <TipsModal show={this.state.showTips} tips={this.props.exercise.plyometric.tips} close={this.close} />
            <VideoModal show={this.state.showVideo} link={this.props.exercise.plyometric.video_link} close={this.closeVideo} />
            <MenuModal show={this.state.showSwap} close={this.closeSwap} click={this.swap} {...this.props} type="plyometrics"/>
        </div>
    }
}

export default Plyo;