import {render} from 'react-dom';
import RoutineStore from 'stores/routine_store';
import RoutineActions from 'actions/routine_actions';

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
            routine: {}
        }
    }

    componentDidMount () {
        RoutineStore.addChangeListener(this.onChange.bind(this));
        this.load();
    }

    componentWillUnmount () {
        RoutineStore.removeChangeListener(this.onChange.bind(this));
    }

    load() {
        RoutineActions.getCalendar(this.state.year, this.state.month, gon.current_user_id);
        RoutineActions.getRoutine(this.state.year, this.state.month, this.state.day, gon.current_user_id);
    }

    onChange () {
        var data = RoutineStore.getData();
        this.setState(
            {
                calendar: data.calendar,
                routine: data.routine
            }
        )
    }

    render () {
        return <div className="do-work row">
            <div className="col-md-5 col-md-offset-6 col-xs-12 col-xs-offset-0 form">
                <div className="row">
                    <div className="col-md-12">
                        <h1>Sign up as an Athlete</h1>
                        <a href="" className="info-text subtle-link">Are you a coach? Sign up here.</a>
                    </div>
                </div>
            </div>
        </div>;
    }
}

render(<DoWork/>, document.getElementById('app'));