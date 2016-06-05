import {render} from 'react-dom';
import CircleCheck from 'views/common/circle_check';

class Program extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            valid: true,
            nextDisabled: true
        };
    }

    submit () {

    }

    render () {
        return <div className="program">
            <div className="row">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-4">
                            <h1 className="purple">Choose a Strength Training Program</h1>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-6 col-xs-offset-4 header-text">
                            Help us put together your weight training program.
                            The schedules are listed in order from easiest to most difficult. More difficult schedules will
                            yield more explosive results. You can change your schedule at any time.
                        </div>
                    </div>
                    <If condition={this.props.program.days == 2}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="strength"  id={'strength'} label={'2 30 minute days per week'} />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 3}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="plyo" id={'plyo'} label={'3 30 minute days per week'} />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 2 && this.props.program.long}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck ref="sprinting" id={'sprinting'} label={'2 45 minute days per week'} />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 3 && this.props.program.long}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck id={'stretching'} label={'2 30 minute days per week, and 1 45 minute day per week'} />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 4}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck id={'stretching'} label={'4 30 minute days per week'} />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 3 && this.props.program.long}>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck id={'stretching'} label={'3 45 minute days per week'}  />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 4 && this.props.program.long }>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck id={'stretching'} label={'2 30 minute days per week, and 2 45 minute days per week'} />
                            </div>
                        </div>
                    </If>
                    <If condition={this.props.program.days == 4 && this.props.program.long }>
                        <div className="row">
                            <div className="col-xs-4 col-xs-offset-4">
                                <CircleCheck id={'stretching'} label={'4 45 minute days per week'} />
                            </div>
                        </div>
                    </If>
                    <div className="row">
                        <div className="col-xs-4 col-xs-offset-4">
                            <If condition={this.state.valid == false}>
                                <span>You must choose at least one Quad.</span>
                            </If>
                            <Button ref="programNext" buttonText="Continue" onClick={ () => this.submit() }
                                    disabled={this.state.nextDisabled} />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Program;
