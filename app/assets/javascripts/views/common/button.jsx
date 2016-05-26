import React from 'react';
import {render} from 'react-dom';

require('common/button.scss');

class Button extends React.Component {

    constructor(props) {
        super(props);
    }

    isDisabled() {

    }

    render () {
        return <button ref="button" disabled={this.props.disabled} type="submit"
                       className="btn btn-default qfButton" onClick={this.props.onClick}>
            {this.props.buttonText}
        </button>;
    }
}
export default Button;