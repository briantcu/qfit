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
        return <span className="vert-circle-check">
                <If condition={!this.props.disabled}>
                    <input ref="check" type="checkbox" className="check" id={`${this.props.id}`}
                           checked={this.props.checked} onChange={ this.props.change}/>
                </If>
                <If condition={this.props.disabled}>
                    <input ref="check" type="checkbox" className="check" id={`${this.props.id}`}
                           checked={this.props.checked} readOnly={true}/>
                </If>
                <label htmlFor={`${this.props.id}`} /><br/>
                <div className="label-text">{this.props.label}</div>
            </span>

    }
}
export default VertCircleCheck;