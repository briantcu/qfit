import {render} from 'react-dom';

require('common/sliding_menu.scss');

class SlidingMenu extends React.Component {
    constructor(props) {
        super(props);
        this.click = this.click.bind(this);
    }

    componentDidMount() {
        $(this.refs.menu).dlmenu({
            animationClasses : { classin : 'dl-animate-in-2', classout : 'dl-animate-out-2' }
        });
        $('.dl-link').on('click', this.click);
    }

    click(e) {
        this.props.click($(e.target).data('id'));
    }

    render () {
        return <div className="row sliding-menu">
            <div ref="menu" className="dl-menuwrapper">
                <ul className="dl-menu dl-menuopen">
                    <li>
                        <a href="#">Fashion</a>
                        <ul className="dl-submenu">
                            <li>
                                <a href="#">Men</a>
                                <ul className="dl-submenu">
                                    <li><a href="#">Shirts</a></li>
                                    <li><a href="#">Jackets</a></li>
                                    <li><a href="#">Chinos &amp; Trousers</a></li>
                                    <li><a href="#">Jeans</a></li>
                                    <li><a href="#">T-Shirts</a></li>
                                    <li><a href="#">Underwear</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">Women</a>
                                <ul className="dl-submenu">
                                    <li><a href="#">Jackets</a></li>
                                    <li><a href="#">Knits</a></li>
                                    <li><a href="#">Jeans</a></li>
                                    <li><a href="#">Dresses</a></li>
                                    <li><a href="#">Blouses</a></li>
                                    <li><a href="#">T-Shirts</a></li>
                                    <li><a href="#">Underwear</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">Children</a>
                                <ul className="dl-submenu">
                                    <li><a data-id="3" className="dl-link" href="#">Boys</a></li>
                                    <li><a href="#">Girls</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    }

}

export default SlidingMenu;