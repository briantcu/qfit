import React from 'react';
import {render} from 'react-dom';
require('fancy_input.scss');

class FancyInput extends React.Component {
    render () {
        return <input type="text" className="transparent-input form-text" />;
    }
}
export default FancyInput;