import {render} from 'react-dom';

require('views/quad-pod/friends.scss');

class Friends extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="qp-section friends">
            <div className="sec-header">Your Pod</div>
            <div className="sec-main">
                <Choose>
                <When condition={this.props.quad_pod && this.props.quad_pod.length > 0} >
                        {
                            this.props.quad_pod.map(function(e) {
                                return <div key={e.id} className="friend gray-border">
                                    <span onClick={ () => this.props.showConversation(e.id)}>Message flag</span>
                                    <span>Avatar</span>
                                    <span>{e.user_name}</span>
                                    <span>PowerIndex: {e.power_index}</span>
                                    <span>x</span>
                                </div>
                            }.bind(this))
                        }
                </When>
                <Otherwise >
                    <div>You don't have anyone in your Quad Pod yet! Invite friends below, or connect
                        with other Quadfit users through the <a href="/leaderboards">Leaderboards</a>.
                        You can also meet other Quadfit users in our <a href="">Reddit sub</a>.
                    </div>
                </Otherwise>
                </Choose>
            </div>
        </div>;
    }


}

export default Friends;