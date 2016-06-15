import React from 'react';
import {render} from 'react-dom';

require('common/square_check.scss');

class SquareCheck extends React.Component {

    constructor(props) {
        super(props);
    }

    getValue() {
        return this.refs.check.checked;
    }

    render () {
        return <span className="square-check-wrapper">
            <span className="square-check">
                <If condition={!this.props.disabled}>
                    <input ref="check" type="checkbox" className="check" id={`${this.props.id}`}
                           checked={this.props.checked} onChange={ this.props.change}/>
                </If>
                <If condition={this.props.disabled}>
                    <input ref="check" type="checkbox" className="check" id={`${this.props.id}`}
                           checked={this.props.checked} readOnly={true}/>
                </If>
                <label htmlFor={`${this.props.id}`} />
                <span className="label-text">{this.props.label}</span>
            </span>
        </span>
    }
}
export default SquareCheck;