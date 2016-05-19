import React from 'react';
import {render} from 'react-dom';

require('common/circle_check.scss');

class CircleCheck extends React.Component {

    constructor(props) {
        super(props);
    }

    getValue() {
        return this.refs.check.checked
    }

    render () {
        return <span className="circle-check">
                <input ref="check" type="checkbox" className="check" id={`${this.props.id}`} checked={this.props.disabled} />
                <label htmlFor={`${this.props.id}`} />
                <span className="label-text">{this.props.label}</span>
            </span>;
    }
}
export default CircleCheck;