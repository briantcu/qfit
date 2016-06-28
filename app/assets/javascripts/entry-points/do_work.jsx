import {render} from 'react-dom';
import RoutineStore from 'stores/routine_store';
import UserStore from 'stores/user_store';
import RoutineActions from 'actions/routine_actions';
import UserActions from 'actions/user_actions';
import Header from 'views/common/header';

require('pages/do_work.scss');

class DoWork extends React.Component {
    constructor(props) {
        super(props);
        var year, month, day;
        var urlArray = location.pathname.split('/');
        if (urlArray.length > 2) {
            year = urlArray[2];
            month = urlArray[3];
            day = urlArray[4];
        } else {
            var today = new Date();
            year = today.getFullYear();
            month = today.getMonth() + 1;
            day = today.getDate();
        }

        this.state = {
            year: year,
            month: month,
            day: day,
            calendar: {},
            routine: {},
            user: {}
        }
    }

    componentDidMount () {
        RoutineStore.addChangeListener(this.onChange.bind(this));
        UserStore.addChangeListener(this.onChange);
        this.load();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        RoutineStore.removeChangeListener(this.onChange.bind(this));
    }

    load() {
        UserActions.getUser(gon.current_user_id);
        RoutineActions.getCalendar(this.state.year, this.state.month, gon.current_user_id);
        RoutineActions.getRoutine(this.state.year, this.state.month, this.state.day, gon.current_user_id);
    }

    onChange () {
        var data = RoutineStore.getData();
        var user = UserStore.getData();
        this.setState(
            {
                calendar: data.calendar,
                routine: data.routine,
                user: user.user
            }
        )
    }

    render () {
        return <div className="do-work">
            <Header user={this.state.user} />
            <div className="row calendar">

            </div>
            <div className="row subnav">

            </div>
            <div className="row main">
                <div className="container">

                    <div className="stretching sec container">
                        <div className="row">
                            <div className="col-xs-12 sec-header">Stretching/Warmup</div>
                        </div>
                        <div className="row">
                            <div className="col-xs-12">ex one</div>
                        </div>
                        <div className="row">
                            <div className="col-xs-12">ex two</div>
                        </div>
                    </div>

                    <div className="strength sec container">
                        <div className="row">
                            <div className="col-xs-12 sec-header">Strength Training</div>
                        </div>
                    </div>

                    <div className="plyos sec container">
                        <div className="row">
                            <div className="col-xs-12 sec-header">Plyometrics</div>
                        </div>
                    </div>

                    <div className="sprinting sec container">
                        <div className="row">
                            <div className="col-xs-12 sec-header">Sprinting</div>
                        </div>
                    </div>

                    <div className="comments sec container">
                        <div className="row">
                            <div className="col-xs-12 sec-header">Comments</div>
                        </div>
                    </div>

                </div>
            </div>
        </div>;
    }
}

render(<DoWork/>, document.getElementById('app'));