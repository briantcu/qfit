import React from 'react';
import {render} from 'react-dom';

import Floatl from 'floatl';
require('fancy_input.scss');

class FancyInput extends React.Component {

    constructor(props) {
        super(props);
        this.state = {strength: 0}
    }

    componentDidMount() {
        new Floatl(this.refs.fancyInput);
    }

    getValue() {
        return this.refs.inputField.value
    }

    changed() {
        if (this.props.changedCallback) {
            this.props.changedCallback(this.getValue());
        }

        if (this.props.type == 'password') {
            this.setState({strength: 2});
        }
    }

    render () {
        return <span ref="fancyInput" className="floatl fancy-input">
                    <label className="floatl__label">{this.props.placeholder}</label>
                    <input ref="inputField" type={this.props.type} className="transparent-input standard-text floatl__input"
                           name={`${this.props.name}`} placeholder={`${this.props.placeholder}`} onChange={() => this.changed()}/>
                    <If condition={this.props.type == 'password'}>
                        <span className="pw-strength">
                            <div className={this.state.strength > 3 ? 'indicator full' : 'indicator'}></div>
                            <div className={this.state.strength > 2 ? 'indicator full' : 'indicator'}></div>
                            <div className={this.state.strength > 1 ? 'indicator full' : 'indicator'}></div>
                            <div className={this.state.strength > 0 ? 'indicator full' : 'indicator'}></div>
                        </span>
                    </If>
            </span>;
    }
}
export default FancyInput;