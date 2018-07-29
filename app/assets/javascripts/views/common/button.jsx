window.jQuery = $;
import React from 'react';
import {render} from 'react-dom';
require ('bootstrap');

require('common/button.scss');

class Button extends React.Component {

    constructor(props) {
        super(props);
    }

    loading() {
        $(this.refs.button);
    }

    render () {
        var classes = (this.props.inverse) ? "btn btn-default qfInverseButton" : "btn btn-default qfButton";
        return <button ref="button" disabled={this.props.disabled} type="button" data-loading-text="..."
                       className={classes} autoComplete="off" onClick={this.props.onClick}>
            {this.props.buttonText}
        </button>;
    }
}
export default Button;