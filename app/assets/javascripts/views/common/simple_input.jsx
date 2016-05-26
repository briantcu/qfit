import React from 'react';
import {render} from 'react-dom';
require('common/simple_input.scss');

class SimpleInput extends React.Component {

    constructor(props) {
        super(props);
    }

    getValue() {
        return this.refs.inputField.value.trim();
    }

    render () {
        return <span ref="simpleInput" className="simpleInput" >
                    <input ref="inputField" type={this.props.type} className="transparent-input standard-text"
                           name={`${this.props.name}`} placeholder={`${this.props.placeholder}`} onChange={this.props.onChange}/>
                <span className="inputLabel">{this.props.label}</span>
            </span>;
    }
}
export default SimpleInput;