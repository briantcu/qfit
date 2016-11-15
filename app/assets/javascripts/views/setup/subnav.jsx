import {render} from 'react-dom';

require('views/setup/subnav.scss');

class Subnav extends React.Component {
    constructor(props) {
        super(props);
    }

    render () {
        return <div className="row subnav no-margin">
                    <div className="col-xs-16 text-center">
                        {
                            this.props.elements.map(function (e, index) {
                                return <span key={index} className={e.class} >{e.label}</span>
                            })
                        }
                    </div>
                </div>
    }

}

export default Subnav;