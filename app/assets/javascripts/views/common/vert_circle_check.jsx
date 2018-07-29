import React from 'react';
import {render} from 'react-dom';

require('common/vert_circle_check.scss');

class VertCircleCheck extends React.Component {

    constructor(props) {
        super(props);
    }

    getValue() {
        return this.refs.check.checked;
    }

    render () {
        // This is a controlled component
        return <span className="vert-circle-check">
                <If condition={!this.props.disabled && !this.props.uncontrolled}>
                    <input ref="check" type="checkbox" className="check" id={`${this.props.id}`}
                           checked={this.props.checked} onChange={ this.props.change}/>
                </If>
                <If condition={!this.props.disabled && this.props.uncontrolled}>
                    <input ref="check" type="checkbox" className="check" id={`${this.props.id}`}
                           defaultChecked={this.props.checked} onChange={ this.props.change}/>
                </If>
                <If condition={this.props.disabled}>
                    <input ref="check" type="checkbox" className="check" id={`${this.props.id}`}
                           defaultChecked={this.props.checked} readOnly={true} disabled={this.props.disabled}/>
                </If>
                <label htmlFor={`${this.props.id}`} /><br/>
                <div className="label-text">{this.props.label}</div>
            </span>

    }
}
export default VertCircleCheck;