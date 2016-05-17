import React from 'react';
import {render} from 'react-dom';

require('common/slider.scss');

class Slider extends React.Component {

    constructor(props) {
        super(props);
        this.state = { label: this.props.unchecked};
    }

    getValue() {
        if (this.refs.slider.checked) {
            return this.props.checked;
        }

        return this.props.unchecked;
    }

    handleLabel() {
        console.log(this.refs.slider.checked);
        if (this.refs.slider.checked) {
            this.setState({label: this.props.checked});
        } else {
            this.setState({label: this.props.unchecked});
        }
    }

    render () {
        return <span><div className="switch">
                <input ref="slider" id="cmn-toggle-4" className="cmn-toggle cmn-toggle-round-flat" type="checkbox" onChange={ () => this.handleLabel()}/>
                <label htmlFor="cmn-toggle-4" />
        </div><span className="selected-text standard-text">{this.state.label}</span></span>;
    }
}
export default Slider;