import {render} from 'react-dom';

require('common/header.scss');

class Header extends React.Component {
    constructor(props) {
        super(props);
    }

    render () {
        return <div className="row header">
            <div className="container">
                <div className="row">
                    <div className="col-xs-2">
                        <img src="https://s3.amazonaws.com/quadfit/logo-dark.png" />
                    </div>
                    <div className="col-xs-1 col-xs-offset-9">
                        <img src={`${this.props.user.avatars}`} />
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Header;