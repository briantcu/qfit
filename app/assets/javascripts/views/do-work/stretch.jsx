import {render} from 'react-dom';
import Thumbnail from 'views/do-work/thumbnail'
import VertCircleCheck from 'views/common/vert_circle_check'
import { Modal } from 'react-bootstrap';
import Button from 'views/common/button';
import TipsModal from 'views/do-work/tips_modal';
import VideoModal from 'views/do-work/video_modal';
import MenuModal from 'views/do-work/menu_modal';

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
            showSwap: false
        };
    }

    change(elem) {
        var check = this.refs.complete;
        var completed = check.getValue();
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
        this.setState({showSwap: false});
    }

    render() {
        var classes = (this.props.border) ? 'stretch exercise row top-border' : 'stretch exercise row';
        return <div className={classes}>
            <div className="col-xs-5">
                <Thumbnail exercise={this.props.exercise.warmup} click={this.showVideo}/>
                <span className="ex-info">
                    <div className="ex-name">{this.props.exercise.warmup.name}</div>
                    <div className="ex-subtext">Recommended: {this.props.exercise.warmup.is_stretch ? '3 x 30 seconds' : '5 minutes'} </div>
                    <div className="ex-subtext">
                        <u className="link" onClick={ () => this.showTips()} >Read Tips</u> |
                        <u className="link" onClick={ () => this.showSwap()} >Swap</u> |
                        <u className="link">Delete</u>
                    </div>
                </span>
            </div>
            <div className="col-xs-1 col-xs-offset-6">
                <VertCircleCheck ref="complete" id={'stretch' + this.props.exercise.id}
                             defaultChecked={this.props.exercise.completed} label={'Complete'} change={ this.change } />
            </div>

            <TipsModal show={this.state.showTips} tips={this.props.exercise.warmup.tips} close={this.close} />
            <VideoModal show={this.state.showVideo} link={this.props.exercise.warmup.video_link} close={this.closeVideo} />
            <MenuModal show={this.state.showSwap} close={this.closeSwap} click={this.swap} />


        </div>
    }
}

export default Stretch;