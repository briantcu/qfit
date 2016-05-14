import React from 'react';
import {render} from 'react-dom';

import Floatl from 'floatl';
require('fancy_input.scss');

class FancyInput extends React.Component {

    constructor(props) {
        super(props);
    }

    componentDidMount() {
        new Floatl(this.refs.fancyInput);
    }

    render () {
        return <span ref="fancyInput" className="floatl">
                    <label className="floatl__label">Name</label>
                    <input type="text" className="transparent-input form-text floatl__input" placeholder="Name" />
            </span>;
    }
}
export default FancyInput;