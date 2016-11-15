import { Router, Route, Link, browserHistory } from 'react-router'
import {render} from 'react-dom';

require('common/footer.scss');

class Footer extends React.Component {
    constructor(props) {
        super(props);
    }

    render () {

        return <div className="row footer no-margin">
                <div className="col-sm-5 col-xs-6 logo">
                    <img src="https://s3.amazonaws.com/quadfit/logo.png" />
                </div>
                <div className="col-sm-7 col-xs-6 text-right links">
                    <span>Made with grit in San Francisco</span>
                </div>
            </div>;
    }
}

export default Footer;
