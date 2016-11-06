import React from 'react';
import {render} from 'react-dom';
import util from 'helpers/util';

import Floatl from 'floatl';
require('common/fancy_input.scss');

class FancyInput extends React.Component {

    constructor(props) {
        super(props);
        this.state = {strength: 0}
    }

    componentDidMount() {
        new Floatl(this.refs.fancyInput);
    }

    getValue() {
        return this.refs.inputField.value.trim();
    }

    changed() {
        if (this.props.changedCallback) {
            this.props.changedCallback(this.getValue());
        }

        if (this.props.type == 'password') {
            var strength = util.getPasswordStrength(this.getValue());
            this.setState({strength: strength});
        }
    }

    getStrength() {
        return util.getPasswordStrength(this.getValue());
    }

    render () {
        return <span ref="fancyInput" className={`floatl fancy-input ${this.props.errors && this.props.errors.length > 0 ? ' floatl--active' : null}`}>
                    <Choose>
                        <When condition={this.props.errors && this.props.errors.length > 0} >
                            <label className="floatl__label error-text">{this.props.errors.join(', ')}</label>
                        </When>
                        <When condition={!this.props.errors || this.props.errors.length == 0} >
                            <label className="floatl__label">{this.props.placeholder}</label>
                        </When>
                    </Choose>
                    <input ref="inputField" type={this.props.type} className="transparent-input standard-text floatl__input" defaultValue={this.props.value}
                           name={`${this.props.name}`} placeholder={`${this.props.placeholder}`} onChange={() => this.changed()} maxlength="50" />
                    <If condition={(this.props.type == 'password') && !this.props.hideMeter }>
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