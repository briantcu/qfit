import {render} from 'react-dom';
import Button from 'views/common/button';
import { LineChart } from 'react-chartkick';
import UserActions from 'actions/user_actions';
import UserStore from 'stores/user_store';

window.Chart = require('chart.js');
require('views/do-work/progress.scss');

class Progress extends React.Component {
    constructor(props) {
        super(props);
        this.changeChart = this.changeChart.bind(this);
        this.onChange = this.onChange.bind(this);
        this.formatChartData = this.formatChartData.bind(this);
        this.chartTypes = ['user_weight', 'power_index', 'completed_workouts', 'exercise'];
        this.periods = {
            three_months: 1,
            six_months: 2,
            one_year: 3,
            one_month: 4
        };
        this.state = {
            hasData: false,
            min: {value: ''},
            max: {value: ''}
        }
    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        UserActions.getProgress(gon.current_user_id, this.chartTypes[1], this.periods.three_months);
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
    }

    onChange() {
        var chartData = UserStore.getData().chart;
        this.formatChartData(chartData);
    }

    formatChartData(chartData) {
        if (chartData.dataset && chartData.dataset.length > 0) {
            var max = _.max(chartData.dataset, function (data) {
                return data.value;
            });
            var min = _.min(chartData.dataset, function (data) {
                return data.value;
            });

            var dataset = {};
            _.each(chartData.dataset, function(data) {
                dataset[data.date] = data.value;
            });

            console.log(dataset);
            this.setState({max: max, min: min, hasData: true, dataset: dataset});
        } else {
            this.setState({hasData: false})
        }
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
                               <div className="col-xs-1 text-center">
                                   <div>{this.state.max.value}</div>
                                   <div className="val-label">HIGHEST</div>
                               </div>
                               <div className="col-xs-1 text-center">
                                   {this.state.min.value}
                                   <div className="val-label">LOWEST</div>
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
                            <Choose>
                                <When condition={this.state.dataset}>
                                    <LineChart data={this.state.dataset} spanGaps={true} />
                                </When>
                                <Otherwise>
                                    <span>No Data</span>
                                </Otherwise>
                            </Choose>

                        </div>
                    </div>
                </div>
            </div>
        </div>;
    }
}

export default Progress;