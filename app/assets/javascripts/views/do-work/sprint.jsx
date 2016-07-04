import {render} from 'react-dom';
import VertCircleCheck from 'views/common/vert_circle_check';
import TipsModal from 'views/do-work/tips_modal';

require('views/do-work/sprint.scss');

class Sprint extends React.Component {
    constructor(props) {
        super(props);
        this.change = this.change.bind(this);
        this.close = this.close.bind(this);
        this.state = {
            showTips: false
        }
    }

    change(e) {
        var check = this.refs[e.target.id];
        var checked = check.getValue();
    }

    showTips() {
        this.setState({showTips: true});
    }

    close() {
        this.setState({showTips: false});
    }

    render() {
        return <div className="sprint exercise row" >
            <div className="col-xs-12">
                <div className="row">
                    <span className="ex-info col-xs-12">
                        <div className="ex-name">{this.props.exercise.sprint.name}</div>
                        <div className="ex-subtext">
                            <u className="link" onClick={ () => this.showTips()}>Read Tips</u> |
                            <u className="link">Swap</u> |
                            <u className="link">Delete</u>
                        </div>
                    </span>
                </div>
                {
                    this.props.exercise.sprint_details.map(function(e, index) {
                        return <div className="row detail-row" key={this.props.exercise.id + '' + (index + 1)}>
                                <div className="col-xs-4 detail">{e.detail}</div>
                                <div className="col-xs-8">
                                    <VertCircleCheck
                                        ref={this.props.exercise.laps[index].id}
                                        id={this.props.exercise.laps[index].id}
                                        defaultChecked={this.props.exercise.laps[index].completed}
                                        key={this.props.exercise.id + '' + (index + 1)}
                                        label={'Complete'} change={ this.change } />
                                </div>
                            </div>
                    }.bind(this))
                }
            </div>

            <TipsModal show={this.state.showTips} tips={this.props.exercise.sprint.tips} close={this.close} />

        </div>
    }
}

export default Sprint;