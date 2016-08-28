import {render} from 'react-dom';

require('views/quad-pod/quad-pod.scss');

class QuadPod extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="quad-pod">
            <div className="row main">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-12">
                        <div className="qp-header">
                            Quad Pod
                        </div>
                        <div className="qp-sub">
                            Here you can invite and talk with friends, and see their workouts!
                        </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12 col-sm-5">
                            <div className="qp-section">
                                <div className="sec-header">Your Pod</div>
                                <div className="sec-main"></div>
                            </div>
                            <div className="qp-section">
                                <div className="sec-header">Invite Friends to Your Pod</div>
                                <div className="sec-main">
                                    Invite friends to join your Quad Pod. You can enter email addresses or cell phone
                                    numbers. Put each entry in a new field.
                                </div>
                            </div>
                        </div>
                        <div className="col-xs-12 col-sm-7">
                            <div className="qp-section">
                                <div className="sec-header">Your Feed</div>
                                <div className="sec-main"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>;
    }


}

export default QuadPod;