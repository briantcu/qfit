import {render} from 'react-dom';

require('common/sliding_menu.scss');

class SlidingMenu extends React.Component {
    constructor(props) {
        super(props);
        this.click = this.click.bind(this);
    }

    componentDidMount() {
        $(this.refs.menu).dlmenu({
            animationClasses : { classin : 'dl-animate-in-2', classout : 'dl-animate-out-2' }
        });
        $('.dl-link').on('click', this.click);
    }

    click(e) {
        this.props.click($(e.target).data('id'));
    }

    render () {
        return <div className="row sliding-menu">
            <div ref="menu" className="dl-menuwrapper">
                <ul className="dl-menu dl-menuopen">
                    <Choose>
                        <When condition={this.props.type == 'warmups'}>
                            <li>
                                <a href="#">Warmup</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.warmups.warm_up.map(function (e, index) {
                                            return <li key={index}><a data-id={e.id} className="dl-link" href="#">{e.name}</a></li>
                                        }.bind(this))
                                    }
                                </ul>
                            </li>

                            <li>
                                <a href="#">Dynamic Stretch</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.warmups.dynamic_stretch.map(function(e, index) {
                                    return <li key={index}><a data-id={e.id} className="dl-link" href="#">{e.name}</a></li>
                                }.bind(this))
                                    }
                                </ul>
                            </li>

                            <li>
                                <a href="#">Static Stretch</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.warmups.static_stretch.map(function (e, index) {
                                            return <li key={index}><a data-id={e.id} className="dl-link" href="#">{e.name}</a></li>
                                        }.bind(this))
                                    }
                                </ul>
                            </li>
                        </When>
                        <When condition={this.props.type == 'strength'} >
                            {
                                this.props.exercises.exercises.map(function (e, index) {
                                    return <li key={index}>
                                        <a href="#">{e.type_name}</a>
                                        <ul className="dl-submenu">
                                            {
                                                e.exercises.map(function (e, index) {
                                                    return <li key={index}><a data-id={e.id} className="dl-link" href="#">{e.name}</a></li>
                                                }.bind(this))
                                            }
                                        </ul>
                                    </li>
                                }.bind(this))
                            }
                        </When>
                        <When condition={this.props.type == 'plyometrics'} >
                            {
                                this.props.exercises.plyometrics.map(function (e, index) {
                                    return <li key={index}><a data-id={e.id} className="dl-link" href="#">{e.name}</a></li>
                                }.bind(this))
                            }
                        </When>
                        <When condition={this.props.type == 'sprints'} >
                            <li>
                                <a href="#">Basketball Court</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.sprints.basketball_court.map(function (e, index) {
                                            return <li key={index}><a data-id={e.id} className="dl-link" href="#">{e.name}</a></li>
                                        }.bind(this))
                                    }
                                </ul>
                            </li>

                            <li>
                                <a href="#">Track</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.sprints.track.map(function(e, index) {
                                            return <li key={index}><a data-id={e.id} className="dl-link" href="#">{e.name}</a></li>
                                        }.bind(this))
                                    }
                                </ul>
                            </li>

                            <li>
                                <a href="#">Treadmill</a>
                                <ul className="dl-submenu">
                                    {
                                        this.props.exercises.sprints.treadmill.map(function (e, index) {
                                            return <li key={index}><a data-id={e.id} className="dl-link" href="#">{e.name}</a></li>
                                        }.bind(this))
                                    }
                                </ul>
                            </li>
                        </When>
                    </Choose>
                </ul>
            </div>
        </div>
    }

}

export default SlidingMenu;