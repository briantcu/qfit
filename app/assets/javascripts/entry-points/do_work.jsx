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
        UserActions.getUser(gon.current_user_id);
        this.load();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
        RoutineStore.removeChangeListener(this.onChange.bind(this));
    }

    load() {
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
                    <div className="stretching quad">
                    </div>
                    <div className="strength quad">
                    </div>
                    <div className="plyos quad">
                    </div>
                    <div className="sprinting quad">
                    </div>
                </div>
            </div>
        </div>;
    }
}

render(<DoWork/>, document.getElementById('app'));