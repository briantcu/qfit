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
        $(this.refs.but)
    }

    render () {
        return <button ref="button" disabled={this.props.disabled} type="button" data-loading-text="..."
                       className="btn btn-default qfButton" autocomplete="off" onClick={this.props.onClick}>
            {this.props.buttonText}
        </button>;
    }
}
export default Button;