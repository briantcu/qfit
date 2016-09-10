import {render} from 'react-dom';
import Button from 'views/common/button';
import { LineChart } from 'react-chartkick';
import UserActions from 'actions/user_actions';
import UserStore from 'stores/user_store';
import Chart from 'chart.js'

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
            all_time: 2,
            one_year: 3,
            one_month: 4
        };
        this.state = {
            hasData: false,
            min: 'N/A',
            max: 'N/A',
            period: 4,
            title: 'Weight',
            chartType: 0
        };

    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange);
        UserActions.getProgress(gon.current_user_id, this.chartTypes[0], this.periods.one_month);
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
    }

    onChange() {
        var chartData = UserStore.getData().chart;
        this.formatChartData(chartData);
        var ctx = document.getElementById("myChart");
        var chart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: [0,1,3,5,9],
                datasets: [{
                    data: [7,6,9,11,12],
                    spanGaps: true
                }]
            },
            optons: {
                scales: {
                    yAxes: [{
                        gridLines: {
                            display: true
                        }
                    }],
                    xAxes: [{
                        display: false,
                        gridLines: {
                            display: true
                        }
                    }],
                    gridLines: {
                        display: false
                    }
                },
                lineTension: 0,
                backgroundColor: 'black'
            }
        });
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
            this.setState({max: max.value, min: min.value, hasData: true, dataset: dataset, title: chartData.title});
        } else {
            this.setState({hasData: false, min: 'N/A', max: 'N/A', title: chartData.title})
        }
    }

    chartText() {
        if (this.state.chartType == 0) {
            return "Quadfit tracks your weight throughout the program, so that you can be sure you're on the right track.";
        } else if (this.state.chartType == 1) {
            return "Your PowerIndex is calculated by Quadfit's proprietary formulas, and represents your overall " +
                "strength level. The PowerIndex is on a scale of 1-200, with 200 representing the theoretical strongest " +
                "man alive. Most likely, the strongest man you know has a PowerIndex of around 80.";
        } else if (this.state.chartType == 2) {
            return "Quadfit calculates the percentage of the Quadfit workouts that you have completed each week. So, " +
                "if you are only completing 73% of your workouts, you know why your goals aren't being met.";
        } else {
            return "For every weight training exercise that you complete, Quadfit calculates the estimated one rep " +
                "maximum weight load you could have completed that day.";
        }
    }

    changeChart() {
        this.setState({chartType: this.refs.chartType.value});
        UserActions.getProgress(gon.current_user_id, this.chartTypes[this.refs.chartType.value], this.state.period);
    }

    periodChanged(period) {
        this.setState({period: period});
        UserActions.getProgress(gon.current_user_id, this.chartTypes[this.refs.chartType.value], period);
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
                                {this.chartText()}
                            </div>
                            <div className="controls-row">
                                <select ref="chartType" className="form-control" onChange={() => this.changeChart() }>
                                    <option value="0">Weight</option>
                                    <option value="1">PowerIndex</option>
                                    <option value="2">% of Workouts Completed by Week</option>
                                    <option value="3">Specific Exercise Progress</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div className="row">

                        <div className="col-xs-12 info-bar">
                           <div className="row">
                               <div className="col-xs-10">
                                   {this.state.title}
                               </div>
                               <div className="col-xs-1 text-center">
                                   <div>{this.state.max}</div>
                                   <div className="val-label">HIGHEST</div>
                               </div>
                               <div className="col-xs-1 text-center">
                                   {this.state.min}
                                   <div className="val-label">LOWEST</div>
                               </div>
                           </div>
                        </div>

                        <div className="col-xs-12 chart-header">
                            <div className="row">
                                <div className="col-xs-7 small-title">
                                    {this.state.title}
                                </div>
                                <div className="col-xs-5 text-right">
                                    <span onClick={() => this.periodChanged(this.periods.one_month) }
                                          className={(this.state.period ==  this.periods.one_month) ? 'selected-period' : 'period'}>Last 30 Days</span>
                                    <span onClick={() => this.periodChanged(this.periods.three_months) }
                                          className={(this.state.period == this.periods.three_months) ? 'selected-period' : 'period'}>Last 90 Days</span>
                                    <span onClick={() => this.periodChanged(this.periods.one_year) }
                                          className={(this.state.period ==  this.periods.one_year) ? 'selected-period' : 'period'}>Last Year</span>
                                    <span onClick={() => this.periodChanged(this.periods.all_time) }
                                          className={(this.state.period ==  this.periods.all_time) ? 'selected-period' : 'period'}>All Time</span>
                                </div>
                            </div>
                        </div>

                        <div className="col-xs-12 chart-area">
                            <Choose>
                                <When condition={this.state.dataset && this.state.hasData}>
                                    <canvas id="myChart" width="400" height="400"></canvas>
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