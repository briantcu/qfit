import {render} from 'react-dom';

require('common/sliding_menu.scss');

class SlidingMenu extends React.Component {
    constructor(props) {
        super(props);
    }

    componentDidMount() {

        $(this.refs.menu).dlmenu({
            animationClasses : { classin : 'dl-animate-in-2', classout : 'dl-animate-out-2' }
        });
    }

    render () {
        return <div className="row sliding-menu">
            <div ref="menu" id="dl-menu" className="dl-menuwrapper">
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
                                    <li><a href="#">Boys</a></li>
                                    <li><a href="#">Girls</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">Electronics</a>
                        <ul className="dl-submenu">
                            <li><a href="#">Camera &amp; Photo</a></li>
                            <li><a href="#">TV &amp; Home Cinema</a></li>
                            <li><a href="#">Phones</a></li>
                            <li><a href="#">PC &amp; Video Games</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">Furniture</a>
                        <ul className="dl-submenu">
                            <li>
                                <a href="#">Living Room</a>
                                <ul className="dl-submenu">
                                    <li><a href="#">Sofas &amp; Loveseats</a></li>
                                    <li><a href="#">Coffee &amp; Accent Tables</a></li>
                                    <li><a href="#">Chairs &amp; Recliners</a></li>
                                    <li><a href="#">Bookshelves</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">Bedroom</a>
                                <ul className="dl-submenu">
                                    <li>
                                        <a href="#">Beds</a>
                                        <ul className="dl-submenu">
                                            <li><a href="#">Upholstered Beds</a></li>
                                            <li><a href="#">Divans</a></li>
                                            <li><a href="#">Metal Beds</a></li>
                                            <li><a href="#">Storage Beds</a></li>
                                            <li><a href="#">Wooden Beds</a></li>
                                            <li><a href="#">Children's Beds</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Bedroom Sets</a></li>
                                    <li><a href="#">Chests &amp; Dressers</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Home Office</a></li>
                            <li><a href="#">Dining &amp; Bar</a></li>
                            <li><a href="#">Patio</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">Jewelry &amp; Watches</a>
                        <ul className="dl-submenu">
                            <li><a href="#">Fine Jewelry</a></li>
                            <li><a href="#">Fashion Jewelry</a></li>
                            <li><a href="#">Watches</a></li>
                            <li>
                                <a href="#">Wedding Jewelry</a>
                                <ul className="dl-submenu">
                                    <li><a href="#">Engagement Rings</a></li>
                                    <li><a href="#">Bridal Sets</a></li>
                                    <li><a href="#">Women's Wedding Bands</a></li>
                                    <li><a href="#">Men's Wedding Bands</a></li>
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