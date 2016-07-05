import {render} from 'react-dom';
import VertCircleCheck from 'views/common/vert_circle_check';
import TipsModal from 'views/do-work/tips_modal';
import MenuModal from 'views/do-work/menu_modal';

require('views/do-work/sprint.scss');

class Sprint extends React.Component {
    constructor(props) {
        super(props);
        this.change = this.change.bind(this);
        this.close = this.close.bind(this);
        this.showSwap = this.showSwap.bind(this);
        this.closeSwap = this.closeSwap.bind(this);
        this.swap = this.swap.bind(this);
        this.state = {
            showTips: false,
            showSwap: false,
            similar: this.getSimilar(props)
        }
    }

    componentWillReceiveProps(nextProps) {
        var exercises = this.getSimilar(nextProps);
        this.setState({similar: exercises});
    }

    getSimilar(props) {
        var exercises = [];
        if (props.exercises.sprints) {
            if (props.exercise.sprint.sprint_type == 3) {
                exercises = props.exercises.sprints.treadmill;
            } else if (props.exercise.sprint.sprint_type == 2) {
                exercises = props.exercises.sprints.basketball_court;
            } else {
                exercises = props.exercises.sprints.treadmill;
            }
        }
        return exercises
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
        return <div className="sprint exercise row" >
            <div className="col-xs-12">
                <div className="row">
                    <span className="ex-info col-xs-12">
                        <div className="ex-name">{this.props.exercise.sprint.name}</div>
                        <div className="ex-subtext">
                            <u className="link" onClick={ () => this.showTips()}>Read Tips</u> |
                            <u className="link" onClick={ () => this.showSwap()} >Swap</u> |
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
            <MenuModal show={this.state.showSwap} close={this.closeSwap} click={this.swap} {...this.props}
                       exercise_subset={this.state.similar} />
        </div>
    }
}

export default Sprint;