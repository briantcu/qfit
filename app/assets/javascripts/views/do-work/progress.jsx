 import {render} from 'react-dom';
import Button from 'views/common/button';
import { LineChart } from 'react-chartkick';
import UserActions from 'actions/user_actions';
import UserStore from 'stores/user_store';
import Chart from 'chart.js'
import moment from 'moment'

window.Chart = require('chart.js');
require('views/do-work/progress.scss');

class Progress extends React.Component {
    constructor(props) {
        super(props);
        this.changeChart = this.changeChart.bind(this);
        this.onChange = this.onChange.bind(this);
        this.formatChartData = this.formatChartData.bind(this);
        this.afterScaleUpdate = this.afterScaleUpdate.bind(this);
        this.drawMonthBar = this.drawMonthBar.bind(this);
        this.chartHover = this.chartHover.bind(this);
        this.chartTypes = ['user_weight', 'power_index', 'completed_workouts', 'exercise'];
        this.periods = {
            three_months: 1,
            all_time: 2,
            one_year: 3,
            one_month: 4,
            two_month: 5
        };
        this.state = {
            hasData: false,
            min: 'N/A',
            max: 'N/A',
            period: 4,
            title: 'Weight',
            chartType: 0,
            maxes: []
        };

    }

    chartHover () {
        console.log(arguments);
    }

    componentDidMount () {
        Chart.defaults.global.defaultFontColor = 'rgba(168, 172, 185, 1)';
        UserStore.addChangeListener(this.onChange);
        if (gon.viewing == 'user') {
            UserActions.getProgress(gon.current_user_id, this.chartTypes[0], this.periods.one_month);
            UserActions.getMaxes();
        }
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange);
    }

    onChange() {
        var data = UserStore.getData();
        var chartData = data.chart;
        var maxes = data.maxes;
        this.setState({maxes: maxes});
        this.formatChartData(chartData);
        this.formMonthBar(chartData);
        var ctx = document.getElementById("myChart");
        if (ctx) {
            var chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: this.state.labels,
                    datasets: [{
                        fill: false,
                        backgroundColor: 'rgba(121, 83, 170, 1)',
                        borderColor: 'rgba(121, 83, 170, 1)',
                        lineTension: 0,
                        data: this.state.dataset,
                        spanGaps: true
                    }]
                },
                options: {
                    animation: {
                        onComplete: this.drawMonthBar
                    },
                    borderColor: "rgba(0,0,0,0)",
                    fill: false,
                    responsive: true,
                    maintainAspectRatio: false,
                    legend: {
                        display: false
                    },
                    title: {
                        display: false
                    },
                    line: {
                        fill: false
                    },
                    tooltips: {
                        enabled: false
                    },
                    scales: {
                        yAxes: [{
                            gridLines: {
                                display: false
                            },
                            ticks: {
                                suggestedMin: 0,
                                beginAtZero: true
                            }

                        }],
                        xAxes: [{
                            display: true,
                            gridLines: {
                                zeroLineWidth: 0,
                                zeroLineColor: "rgba(0,0,0,0)",
                                display: true
                            },
                            ticks: {
                                display: true,
                                callback: function(value, index, values) {
                                    return value.slice(-2);
                                },
                                autoSkipPadding: 30
                            },
                            afterFit: function(scale) {
                                if (scale.id == 'x-axis-0'){
                                    scale.height = 40;
                                }
                            },
                            afterUpdate: this.afterScaleUpdate
                        }]
                    },
                    lineTension: 0
                }
            });
        }

    }

    afterScaleUpdate(scale) {
        this.scaleWidth = scale.width;
        this.chartHeight = scale.chart.chart.height;
        this.chartWidth = scale.chart.chart.width;
    }

    drawMonthBar() {
        if (this.monthBarData) {
            var colorArray = ['rgba(121, 83, 170, 0.46)', 'rgba(213, 221, 34, 0.61)'];

            var totalTicks = 0;
            for (var property in this.monthBarData) {
                if (this.monthBarData.hasOwnProperty(property)) {
                    totalTicks += this.monthBarData[property];
                }
            }

            var timeline = $("#timeline");
            timeline.html('');
            var index = 0;
            var offset = (this.chartWidth - this.scaleWidth); //scale is right justified
            timeline.css('left', offset);
            for (var property in this.monthBarData) {
                if (this.monthBarData.hasOwnProperty(property)) { //{august: 22}, {september: 8}
                    var bar = $("<span class='timeline-bar'></span>");
                    var barWidth = ((this.monthBarData[property] / totalTicks) * (this.scaleWidth)); //3 is a hack, but works
                    bar.css('width', barWidth);
                    bar.css('background-color', colorArray[index]);
                    index ++;
                    index = index % 2;
                    bar.text(property.toUpperCase());
                    offset += barWidth;
                    timeline.append(bar);
                }
            }
        }
    }

    formMonthBar(chartData) {
        var startDate = moment(chartData.start_date);
        var endDate = moment(chartData.end_date);
        var monthBarData = {};
        for(var date = moment(startDate); date.diff(endDate) < 0; date.add(1, 'days')) {
            var monthName = date.format('MMMM');
            if (!monthBarData[monthName]) {
                monthBarData[monthName] = 1;
            } else {
                monthBarData[monthName] = monthBarData[monthName] + 1;
            }
        }
        this.monthBarData = monthBarData;
    }

    formatChartData(chartData) {
        if (chartData.dataset && chartData.dataset.length > 0) {
            if (chartData.has_data) {
                var max = _.max(chartData.dataset, function (data) {
                    if (data.y) {
                        return data.y;
                    }
                });
                var min = _.min(chartData.dataset, function (data) {
                    if (data.y) {
                        return data.y;
                    }
                });
                max = max.y;
                min = min.y;
                if (!max) {
                    max = 'N/A';
                }
                if (!min) {
                    min = 'N/A';
                }
            } else {
                max = 'N/A';
                min = 'N/A';
            }
            var labels = _.pluck(chartData.dataset, 'x');
            this.setState({max: max, min: min, hasData: chartData.has_data, dataset: chartData.dataset, title: chartData.title, labels: labels });
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
        if (gon.viewing == 'team') {
            return;
        }
        this.setState({chartType: this.refs.chartType.value});
        var exerciseId = 0;
        if (this.refs.exercises) {
            exerciseId = this.refs.exercises.value;
        } else if (this.state.maxes.length > 0) {
            exerciseId = this.state.maxes[0].exercise_id;
        }
        if ((this.chartTypes[this.refs.chartType.value] == 'exercise') && exerciseId == 0) {
            return;
        }
        UserActions.getProgress(gon.current_user_id, this.chartTypes[this.refs.chartType.value], this.state.period, exerciseId);
    }

    periodChanged(period) {
        this.setState({period: period});
        if (gon.viewing == 'team') {
            return;
        }
        var exerciseId = 0;
        if (this.refs.exercises) {
            exerciseId = this.refs.exercises.value;
        }
        if ((this.chartTypes[this.state.chartType] == 'exercise') && exerciseId == 0) {
            return;
        }
        UserActions.getProgress(gon.current_user_id, this.chartTypes[this.refs.chartType.value], period, exerciseId);
    }

    render() {
        return <div className="progress-tab">
            <div className="row main no-margin">
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
                                    <If condition={this.state.maxes.length > 0}>
                                        <option value="3">Specific Exercise Progress</option>
                                    </If>
                                </select>
                                <If condition={this.chartTypes[this.state.chartType] == 'exercise'}>
                                    <select id="exerciseSelect" ref="exercises" className="form-control" onChange={() => this.changeChart() }>
                                        {
                                            this.state.maxes.map(function(max) {
                                                return <option value={max.exercise_id}>{max.exercise}</option>
                                            })
                                        }
                                    </select>
                                </If>
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-xs-12 info-bar">
                           <div className="row no-margin">
                               <div className="col-xs-6 col-sm-10">
                                   {this.state.title}
                               </div>
                               <div className="col-xs-3 col-sm-1 text-center">
                                   <div>{this.state.max}</div>
                                   <div className="val-label">HIGHEST</div>
                               </div>
                               <div className="col-xs-3 col-sm-1 text-center">
                                   {this.state.min}
                                   <div className="val-label">LOWEST</div>
                               </div>
                           </div>
                        </div>

                        <div className="col-xs-12 chart-header">
                            <div className="row">
                                <div className="col-xs-12 col-sm-7 small-title">
                                    {this.state.title}
                                </div>
                                <div className="col-xs-12 col-sm-5 text-right">
                                    <span onClick={() => this.periodChanged(this.periods.one_month) }
                                          className={(this.state.period ==  this.periods.one_month) ? 'selected-period' : 'period'}>Last 30 Days</span>
                                    <span onClick={() => this.periodChanged(this.periods.two_month) }
                                          className={(this.state.period ==  this.periods.two_month) ? 'selected-period' : 'period'}>Last 60 Days</span>
                                    <Choose>
                                        <When condition={gon.has_premium_access} >
                                            <span onClick={() => this.periodChanged(this.periods.three_months) }
                                                  className={(this.state.period == this.periods.three_months) ? 'selected-period' : 'period'}>Last 90 Days</span>
                                            <span onClick={() => this.periodChanged(this.periods.one_year) }
                                                  className={(this.state.period ==  this.periods.one_year) ? 'selected-period' : 'period'}>Last Year</span>
                                            <span onClick={() => this.periodChanged(this.periods.all_time) }
                                                  className={(this.state.period ==  this.periods.all_time) ? 'selected-period' : 'period'}>All Time</span>
                                        </When>
                                        <Otherwise>
                                            <a className="upgrade-link" href="/settings">Upgrade for more</a>
                                        </Otherwise>
                                    </Choose>



                                </div>
                            </div>
                        </div>

                        <div className="col-xs-12 chart-area">
                            <Choose>
                                <When condition={this.state.dataset && this.state.hasData}>
                                    <canvas id="myChart" />
                                </When>
                                <Otherwise>
                                    <If condition={gon.viewing == 'team'}>
                                        <span className="no-progress">Progress tracking isn't available for teams, only people.
                                        Head back to the <a href="/coach">Coach</a> page and click "View Workout" for an individual.</span>
                                    </If>
                                    <If condition={gon.viewing == 'user'}>
                                        <span className="no-progress">Womp womp...no data for this chart!</span>
                                    </If>
                                </Otherwise>
                            </Choose>
                            <div id="timeline"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>;
    }
}

export default Progress;