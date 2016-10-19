import {render} from 'react-dom';
import RoutineActions from 'actions/routine_actions';
import RoutineConstants from 'constants/routine_constants';

require('views/do-work/plyo.scss');

class Custom extends React.Component {
    constructor(props) {
        super(props);
    }

    delete() {
        var r=confirm("Are you sure you want to remove this exercise?");
        if (r==true) {
            RoutineActions.deleteExercise('plyometrics', this.props.exercise.id);
        }
    }

    render() {
        return <div>
            </div>
    }
}

export default Custom;