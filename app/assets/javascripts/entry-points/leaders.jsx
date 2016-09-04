import {render} from 'react-dom';
import Header from 'views/common/header';
import Footer from 'views/common/footer';
import UserStore from 'stores/user_store';
import UserActions from 'actions/user_actions';
import Leader from 'views/leaders/leader';
import SocialActions from 'actions/social_actions';
import SocialStore from 'stores/social_store';

require('pages/leaders.scss');

class Leaders extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {},
            leaders: {
                male_power_index: [],
                female_power_index: [],
                male_power_index_ratio: [],
                female_power_index_ratio: [],
                sprints_performed: [],
                plyos_performed: [],
                sets_performed: [],
                reps_performed: []
            }
        }

    }

    componentDidMount () {
        UserStore.addChangeListener(this.onChange.bind(this));
        SocialStore.addChangeListener(this.onChange.bind(this));
        UserActions.getUser(gon.current_user_id);
        SocialActions.getLeaders();
    }

    componentWillUnmount () {
        UserStore.removeChangeListener(this.onChange.bind(this));
        SocialStore.removeChangeListener(this.onChange.bind(this));
    }

    onChange () {
        var data = UserStore.getData();
        var social = SocialStore.getData();
        this.setState( {
            user: data.user,
            leaders: social.leaders
        });

    }

    render () {
        return <div>
            <Header user={this.state.user} showWorkoutNav={true} active={''} trueLinks={true} />
            <div className="leaders">
                <div className="row main">
                    <div className="container">
                        <div className="row">
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">
                                        Male PowerIndex
                                        <div className="details">
                                            Highest PowerIndex among male Quadfit members.
                                        </div>
                                    </div>
                                    <div className="sec-main">
                                        {
                                            this.state.leaders.male_power_index.map(function (e, index) {
                                                return <Leader key={index} leader={e.leader} val={e.leader.value} />
                                            }.bind(this))
                                        }
                                    </div>
                                </div>
                            </div>
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">
                                        Female PowerIndex
                                        <div className="details">
                                            Highest PowerIndex among female Quadfit members.
                                        </div>
                                    </div>
                                    <div className="sec-main">
                                        {
                                            this.state.leaders.female_power_index.map(function (e, index) {
                                                return <Leader key={index} leader={e.leader} val={e.leader.value} />
                                            }.bind(this))
                                        }
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">
                                        Male PowerIndex/Weight Ratio
                                        <div className="details">
                                            Highest PowerIndex to member weight ratio for males. This is like a "pound for pound" PowerIndex ranking.
                                        </div>
                                    </div>
                                    <div className="sec-main">
                                        {
                                            this.state.leaders.male_power_index_ratio.map(function (e, index) {
                                                return <Leader key={index} leader={e.leader} val={index + 1} />
                                            }.bind(this))
                                        }
                                    </div>
                                </div>
                            </div>
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">
                                        Female PowerIndex/Weight Ratio
                                        <div className="details">
                                            Highest PowerIndex to member weight ratio for females. This is like a "pound for pound" PowerIndex ranking.
                                        </div>
                                    </div>
                                    <div className="sec-main">
                                        {
                                            this.state.leaders.female_power_index_ratio.map(function (e, index) {
                                                return <Leader key={index} leader={e.leader} val={index + 1}/>
                                            }.bind(this))
                                        }
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">
                                        Most Sprints Performed
                                        <div className="details">
                                            Quadfit members that have completed the most sprints for this time period.
                                        </div>
                                    </div>
                                    <div className="sec-main">
                                        {
                                            this.state.leaders.sprints_performed.map(function (e, index) {
                                                return <Leader key={index} leader={e.leader} val={e.leader.value} />
                                            }.bind(this))
                                        }
                                    </div>
                                </div>
                            </div>
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">
                                        Most Plyometric Exercises Performed
                                        <div className="details">
                                            Quadfit members that have completed the most plyometric exercises for this time period.
                                        </div>
                                    </div>
                                    <div className="sec-main">
                                        {
                                            this.state.leaders.plyos_performed.map(function (e, index) {
                                                return <Leader key={index} leader={e.leader} val={e.leader.value} />
                                            }.bind(this))
                                        }
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">
                                        Most Sets Performed
                                        <div className="details">
                                            Quadfit members that have completed the most strength training sets for this time period.
                                        </div>
                                    </div>
                                    <div className="sec-main">
                                        {
                                            this.state.leaders.sets_performed.map(function (e, index) {
                                                return <Leader key={index} leader={e.leader} val={e.leader.value} />
                                            }.bind(this))
                                        }
                                    </div>
                                </div>
                            </div>
                            <div className="col-xs-12 col-sm-6">
                                <div className="p-section">
                                    <div className="sec-header">
                                        Most Reps Performed
                                        <div className="details">
                                            Quadfit members that have completed the most strength training repetitions for this time period.
                                        </div>
                                    </div>
                                    <div className="sec-main">
                                        {
                                            this.state.leaders.reps_performed.map(function (e, index) {
                                                return <Leader key={index} leader={e.leader} val={e.leader.value} />
                                            }.bind(this))
                                        }
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <Footer />
        </div>;
    }
}

render(<Leaders/>, document.getElementById('app'));