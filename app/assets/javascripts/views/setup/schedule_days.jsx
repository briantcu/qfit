import {render} from 'react-dom';


class ScheduleDays extends React.Component {
    constructor(props) {
        super(props);
    }

    getDays() {

    }

    valid () {

    }

    render () {
        return <div className="schedule-days">
            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-1 col-xs-offset-3 text-center bold-text">
                            <CircleCheck ref="sun" checked={this.props.program.strengthProgram == 2} id={''}
                                         label={'Sunday'} change={ this.change } />
                            <CircleCheck ref="mon" checked={this.props.program.strengthProgram == 2} id={'pro2'}
                                         label={'Monday'} change={ this.change } />
                            <CircleCheck ref="tue" checked={this.props.program.strengthProgram == 2} id={'pro2'}
                                         label={'Tuesday'} change={ this.change } />
                            <CircleCheck ref="wed" checked={this.props.program.strengthProgram == 2} id={'pro2'}
                                         label={'Wednesday'} change={ this.change } />
                            <CircleCheck ref="thurs" checked={this.props.program.strengthProgram == 2} id={'pro2'}
                                         label={'Thursday'} change={ this.change } />
                            <CircleCheck ref="fri" checked={this.props.program.strengthProgram == 2} id={'pro2'}
                                         label={'Friday'} change={ this.change } />
                            <CircleCheck ref="sat" checked={this.props.program.strengthProgram == 2} id={'pro2'}
                                         label={'Saturday'} change={ this.change } />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default ScheduleDays;