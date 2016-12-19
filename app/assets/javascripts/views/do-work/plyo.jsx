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
        this.props.maybeSaveRoutine();
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
        return <div className='plyo exercise row' >
            <div className="col-sm-3 col-md-2 col-xs-12 thumb-col">
                <Thumbnail exercise={this.props.exercise.plyometric} click={this.showVideo} />
            </div>
            <div className="col-xs-12 col-sm-6 col-md-7 info-col">
                <span className="ex-info">
                    <div className="ex-name">{this.props.exercise.plyometric.name}</div>
                    <div className="ex-subtext">Recommended: {this.props.exercise.plyometric.recommended}</div>
                    <div className="ex-subtext">
                        <u className="link" onClick={ () => this.showTips()}>Read Tips</u>&nbsp;
                        <If condition={!this.props.shared && !gon.is_sub_user} >
                            | <u className="link" onClick={ () => this.showSwap()} >Swap</u> | &nbsp;
                            <u className="link" onClick={ () => this.delete()}>Delete</u>
                        </If>
                    </div>
                </span>
            </div>
            <If condition={gon.viewing == 'user' || this.props.shared}>
                <div className="col-xs-3 first-check col-sm-1 col-sm-offset-0">
                    <VertCircleCheck ref={this.props.exercise.id + '1'} id={this.props.exercise.id + '1'} disabled={this.props.shared}
                                     setNum={1} checked={this.props.exercise.performed_one} label={'Complete'} change={ this.change } />
                </div>
                <div className="col-xs-3 col-sm-1">
                    <VertCircleCheck ref={this.props.exercise.id + '2'} id={this.props.exercise.id + '2'} disabled={this.props.shared}
                                     setNum={2} checked={this.props.exercise.performed_two} label={'Complete'} change={ this.change } />
                </div>
                <div className="col-xs-3 col-sm-1">
                    <VertCircleCheck ref={this.props.exercise.id + '3'} id={this.props.exercise.id + '3'} disabled={this.props.shared}
                                     setNum={3} checked={this.props.exercise.performed_three} label={'Complete'} change={ this.change } />
                </div>
            </If>
            <TipsModal show={this.state.showTips} tips={this.props.exercise.plyometric.tips} close={this.close} />
            <VideoModal show={this.state.showVideo} tips={this.props.exercise.plyometric.tips}
                        name={this.props.exercise.plyometric.name}
                        link={this.props.exercise.plyometric.video_link} close={this.closeVideo} />
            <MenuModal show={this.state.showSwap} close={this.closeSwap} click={this.swap} {...this.props} type="plyos"/>
        </div>
    }
}

export default Plyo;