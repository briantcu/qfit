import React from 'react';
import {render} from 'react-dom';

require('slider.scss');

class Slider extends React.Component {

    constructor(props) {
        super(props);
    }

    render () {
        return <div className="switch">
            <input id="cmn-toggle-4" className="cmn-toggle cmn-toggle-round-flat" type="checkbox" />
                <label htmlFor="cmn-toggle-4" />
        </div>;
    }
}
export default Slider;