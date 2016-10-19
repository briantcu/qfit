import {render} from 'react-dom';
import FancyInput from 'views/common/fancy_input';
import Button from 'views/common/button';

require('common/sliding_menu.scss');

class SlidingMenu extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            customErrors: []
        };
        this.click = this.click.bind(this);
        this.addWarmup = this.addWarmup.bind(this);
        this.addWeights = this.addWeights.bind(this);
        this.addPlyos = this.addPlyos.bind(this);
        this.addSprints = this.addSprints.bind(this);
    }

    componentDidMount() {
        $(this.refs.menu).dlmenu({
            animationClasses : { classin : 'dl-animate-in-2', classout : 'dl-animate-out-2' }
        });
        $('.dl-link').on('click', this.click);
        $('.add-wu').on('click', this.addWarmup);
        $('.add-wt').on('click', this.addWeights);
        $('.add-sp').on('click', this.addSprints);
        $('.add-pl').on('click', this.addPlyos);
    }

    click(e) {
        this.props.click($(e.target).data('id'));
    }

    addWarmup() {
        var name = this.refs['customWarmup'].getValue();
        if (name.length > 0) {
            this.props.click(name, true);
        }
    }

    addWeights() {
        var name = this.refs['customWeights'].getValue();
        if (name.length > 0) {
            this.props.click(name, true);
        }
    }

    addSprints() {
        var name = this.refs['customSprints'].getValue();
        if (name.length > 0) {
            this.props.click(name, true);
        }
    }

    addPlyos() {
        var name = this.refs['customPlyos'].getValue();
        if (name.length > 0) {
            this.props.click(name, true);
        }
    }

    render () {
        return <div className="row sliding-menu">
            <div ref="menu" className="dl-menuwrapper">
                <ul className="dl-menu dl-menuopen">
                    <Choose>
                        <When condition={this.props.type == 'warmups'}>
                            <li>
                                <a href="javascript:void(0)">Warmup</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.warmups.warm_up.map(function (e, index) {
                                            return <li key={index}><a data-id={e.id} className="dl-link" href="javascript:void(0)">{e.name}</a></li>
                                        }.bind(this))
                                    }
                                </ul>
                            </li>

                            <li>
                                <a href="javascript:void(0)">Dynamic Stretch</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.warmups.dynamic_stretch.map(function(e, index) {
                                    return <li key={index}><a data-id={e.id} className="dl-link" href="javascript:void(0)">{e.name}</a></li>
                                }.bind(this))
                                    }
                                </ul>
                            </li>

                            <li>
                                <a href="javascript:void(0)">Static Stretch</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.warmups.static_stretch.map(function (e, index) {
                                            return <li key={index}><a data-id={e.id} className="dl-link" href="javascript:void(0)">{e.name}</a></li>
                                        }.bind(this))
                                    }
                                </ul>
                            </li>
                            <li className="no-border">
                                <a href="javascript:void(0)">Custom Exercise</a>
                                <ul className="dl-submenu">
                                    <li className="no-border">
                                        <span className={`purple-bot-container ${this.state.customErrors.length > 0 ? 'error' : null}`}>
                                            <FancyInput ref="customWarmup" name="customWarmup" placeholder="Exercise Name" type="text" errors={this.state.customErrors} />
                                        </span>

                                        <span className="pull-right cust-btn add-wu"><Button onClick={this.addCustom} buttonText={"Add Exercise"} /></span>
                                    </li>
                                </ul>
                            </li>
                        </When>
                        <When condition={this.props.type == 'weights'} >
                            {
                                this.props.exercises.exercises.map(function (e, index) {
                                    return <li key={index}>
                                        <a href="javascript:void(0)">{e.type_name}</a>
                                        <ul className="dl-submenu">
                                            {
                                                e.exercises.map(function (e, index) {
                                                    return <li key={index}><a data-id={e.id} className="dl-link" href="javascript:void(0)">{e.name}</a></li>
                                                }.bind(this))
                                            }
                                        </ul>
                                    </li>
                                }.bind(this))
                            }
                            <li className="no-border">
                                <a href="javascript:void(0)">Custom Exercise</a>
                                <ul className="dl-submenu">
                                    <li className="no-border">
                                        <span className={`purple-bot-container ${this.state.customErrors.length > 0 ? 'error' : null}`}>
                                            <FancyInput ref="customWeights" name="customWeights" placeholder="Exercise Name" type="text" errors={this.state.customErrors} />
                                        </span>

                                        <span className="pull-right cust-btn add-wt"><Button onClick={this.addCustom} buttonText={"Add Exercise"} /></span>
                                    </li>
                                </ul>
                            </li>
                        </When>
                        <When condition={this.props.type == 'plyos'} >
                            {
                                this.props.exercises.plyometrics.map(function (e, index) {
                                    return <li key={index}><a data-id={e.id} className="dl-link" href="javascript:void(0)">{e.name}</a></li>
                                }.bind(this))
                            }
                            <li className="no-border">
                                <a href="javascript:void(0)">Custom Exercise</a>
                                <ul className="dl-submenu">
                                    <li className="no-border">
                                        <span className={`purple-bot-container ${this.state.customErrors.length > 0 ? 'error' : null}`}>
                                            <FancyInput ref="customPlyos" name="customPlyos" placeholder="Exercise Name" type="text" errors={this.state.customErrors} />
                                        </span>

                                        <span className="pull-right cust-btn add-pl"><Button onClick={this.addCustom} buttonText={"Add Exercise"} /></span>
                                    </li>
                                </ul>
                            </li>
                        </When>
                        <When condition={this.props.type == 'sprinting'} >
                            <li>
                                <a href="javascript:void(0)">Basketball Court</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.sprints.basketball_court.map(function (e, index) {
                                            return <li key={index}><a data-id={e.id} className="dl-link" href="javascript:void(0)">{e.name}</a></li>
                                        }.bind(this))
                                    }
                                </ul>
                            </li>

                            <li>
                                <a href="javascript:void(0)">Track</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.sprints.track.map(function(e, index) {
                                            return <li key={index}><a data-id={e.id} className="dl-link" href="javascript:void(0)">{e.name}</a></li>
                                        }.bind(this))
                                    }
                                </ul>
                            </li>

                            <li>
                                <a href="javascript:void(0)">Treadmill</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.sprints.treadmill.map(function (e, index) {
                                            return <li key={index}><a data-id={e.id} className="dl-link" href="javascript:void(0)">{e.name}</a></li>
                                        }.bind(this))
                                    }
                                </ul>
                            </li>
                            <li className="no-border">
                                <a href="javascript:void(0)">Custom Exercise</a>
                                <ul className="dl-submenu">
                                    <li className="no-border">
                                        <span className={`purple-bot-container ${this.state.customErrors.length > 0 ? 'error' : null}`}>
                                            <FancyInput ref="customSprints" name="customSprints" placeholder="Exercise Name" type="text" errors={this.state.customErrors} />
                                        </span>

                                        <span className="pull-right cust-btn add-sp"><Button onClick={this.addCustom} buttonText={"Add Exercise"} /></span>
                                    </li>
                                </ul>
                            </li>
                        </When>
                        <Otherwise>
                            {
                                this.props.exercise_subset.map(function (e, index) {
                                    return <li key={index}><a data-id={e.id} className="dl-link" href="javascript:void(0)">{e.name}</a></li>
                                }.bind(this))
                            }
                        </Otherwise>
                    </Choose>
                </ul>
            </div>
        </div>
    }

}

export default SlidingMenu;