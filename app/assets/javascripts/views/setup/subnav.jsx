import {render} from 'react-dom';

require('views/setup/subnav.scss');

class Subnav extends React.Component {
    constructor(props) {
        super(props);
    }

    render () {
        return <div className="row subnav">
            <div className="container">
                <div className="row">
                    <div className="col-xs-16 text-center">
                        {
                            this.props.elements.map(function (e) {
                                return <span className={e.class} >{e.label}</span>
                            }.bind(this))
                        }
                    </div>
                </div>
            </div>
        </div>
    }

}

export default Subnav;