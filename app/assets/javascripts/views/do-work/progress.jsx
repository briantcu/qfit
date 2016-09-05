import {render} from 'react-dom';
import Button from 'views/common/button';
import { LineChart } from 'react-chartkick';
window.Chart = require('chart.js');
require('views/do-work/progress.scss');

class Progress extends React.Component {
    constructor(props) {
        super(props);
        this.changeChart = this.changeChart.bind(this);
    }

    componentDidMount () {

    }

    changeChart() {

    }

    render() {
        return <div className="progress-tab">
            <div className="row main">
                <div className="container">
                    <div className="row">
                        <div className="col-xs-12 title-row">
                            <div className="pr-header text-left">
                                Your Progress
                            </div>
                            <div className="pr-sub">
                                Change this text
                            </div>
                            <div className="controls-row">
                                <select className="form-control">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                                <Button ref="submitButton" buttonText="Submit" onClick={ () => this.changeChart() }
                                        disabled={false} />
                            </div>
                        </div>
                    </div>
                    <div className="row">

                        <div className="col-xs-12 info-bar">
                           <div className="row">
                               <div className="col-xs-10">
                                   Weight
                               </div>
                               <div className="col-xs-1">
                                   209
                               </div>
                               <div className="col-xs-1">
                                   186
                               </div>
                           </div>
                        </div>

                        <div className="col-xs-12 chart-header">
                            <div className="row">
                                <div className="col-xs-7">
                                    Weight
                                </div>
                                <div className="col-xs-5 text-right">
                                    <span>Last 30 Days</span>
                                    <span>Last 90 Days</span>
                                    <span>Last Year</span>
                                    <span>All Time</span>
                                </div>
                            </div>
                        </div>

                        <div className="col-xs-12 chart-area">
                            <LineChart data={{"2013-02-10 00:00:00 -0800": 11, "2013-02-11 00:00:00 -0800": 6}} />
                        </div>
                    </div>
                </div>
            </div>
        </div>;
    }
}

export default Progress;