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

    getValue() {
        return this.refs.inputField.value
    }

    render () {
        return <span ref="fancyInput" className="floatl">
                    <label className="floatl__label">{this.props.placeholder}</label>
                    <input ref="inputField" type="text" className="transparent-input standard-text floatl__input" placeholder={`${this.props.placeholder}`} />
            </span>;
    }
}
export default FancyInput;