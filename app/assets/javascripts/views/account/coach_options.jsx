import {render} from 'react-dom';
import StripeCheckout from 'react-stripe-checkout';
import C from 'constants/profile_constants';
import Button from 'views/common/button';

class CoachOptions extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <div className="row" id="pricing">
            <div className="col-xs-12">
                <table className="table">
                    <col width="180" />
                    <col width="180"/>
                    <col width="180"/>
                    <col width="180"/>
                    <tbody>
                        <tr>
                            <td className="clear">$0</td>
                            <td className="clear">$29.99 <span className="monthly">Monthly</span></td>
                            <td className="clear">$79.99 <span className="monthly">Monthly</span></td>
                            <td className="clear">$279.99 <span className="monthly">Monthly</span></td>
                        </tr>
                        <tr>
                            <td>5 Users</td>
                            <td>30 Users</td>
                            <td>100 Users</td>
                            <td>Unlimited Users</td>
                        </tr>
                        <tr>
                            <td>Limited Exercises</td>
                            <td>All Exercises</td>
                            <td>All Exercises</td>
                            <td>All Exercises</td>
                        </tr>
                        <tr>
                            <td>2 Months Tracking</td>
                            <td>Unlimited Tracking</td>
                            <td>Unlimited Tracking</td>
                            <td>Unlimited Tracking</td>
                        </tr>
                        <tr>
                            <td>
                                <Choose>
                                    <When condition={this.props.user.has_subscription} >
                                        <Button onClick={this.props.deleteSubscription} buttonText={"Trial"}/>
                                    </When>
                                    <Otherwise>
                                        <Button disabled={true} buttonText={"Trial"}/>
                                        <div className="current">Your Current Plan</div>
                                    </Otherwise>
                                </Choose>
                            </td>
                            <td>
                                <Choose>
                                    <When condition={this.props.user.has_subscription} >
                                        <Choose>
                                            <When condition={this.props.user.num_accts == 30} >
                                                <Button disabled={true} buttonText={"Bronze"}/>
                                                <div className="current">Your Current Plan</div>
                                            </When>
                                            <Otherwise>
                                                <Button onClick={() => this.props.changeAccount(C.BRONZE_CHECKOUT)} buttonText={"Bronze"}/>
                                            </Otherwise>
                                        </Choose>
                                    </When>
                                    <Otherwise>
                                        <StripeCheckout
                                            token={this.props.bronzeCheckout}
                                            stripeKey="pk_test_Qn7vO7ACSbGqKp7tBXget5Du"
                                            amount={2999}
                                            name="Quadfit, LLC"
                                            image="https://s3.amazonaws.com/quadfit/logo-1.jpg"
                                            description="Bronze Subscription"
                                            panelLabel="Get Bronze"
                                            label="Get Bronze"
                                            allowRememberMe={false}
                                            email={this.props.user.email}
                                            local="auto"
                                        />
                                    </Otherwise>
                                </Choose>
                            </td>
                            <td>
                                <Choose>
                                    <When condition={this.props.user.has_subscription} >
                                        <Choose>
                                            <When condition={this.props.user.num_accts == 100} >
                                                <Button disabled={true} buttonText={"Silver"}/>
                                                <div className="current">Your Current Plan</div>
                                            </When>
                                            <Otherwise>
                                                <Button onClick={() => this.props.changeAccount(C.SILVER_CHECKOUT)} buttonText={"Silver"}/>
                                            </Otherwise>
                                        </Choose>
                                    </When>
                                    <Otherwise>
                                        <StripeCheckout
                                            token={this.props.silverCheckout}
                                            stripeKey="pk_test_Qn7vO7ACSbGqKp7tBXget5Du"
                                            amount={7999}
                                            name="Quadfit, LLC"
                                            image="https://s3.amazonaws.com/quadfit/logo-1.jpg"
                                            description="Silver Subscription"
                                            panelLabel="Get Silver"
                                            label="Get Silver"
                                            allowRememberMe={false}
                                            email={this.props.user.email}
                                            local="auto"
                                        />
                                    </Otherwise>
                                </Choose>
                            </td>
                            <td>
                                <Choose>
                                    <When condition={this.props.user.has_subscription} >
                                        <Choose>
                                            <When condition={this.props.user.num_accts > 100} >
                                                <Button disabled={true} buttonText={"Gold"}/>
                                                <div className="current">Your Current Plan</div>
                                            </When>
                                            <Otherwise>
                                                <Button onClick={() => this.props.changeAccount(C.GOLD_CHECKOUT)} buttonText={"Gold"}/>
                                            </Otherwise>
                                        </Choose>
                                    </When>
                                    <Otherwise>
                                        <StripeCheckout
                                            token={this.props.goldCheckout}
                                            stripeKey="pk_test_Qn7vO7ACSbGqKp7tBXget5Du"
                                            amount={27999}
                                            name="Quadfit, LLC"
                                            image="https://s3.amazonaws.com/quadfit/logo-1.jpg"
                                            description="Gold Subscription"
                                            panelLabel="Get Gold"
                                            label="Get Gold"
                                            allowRememberMe={false}
                                            email={this.props.user.email}
                                            local="auto"
                                        />
                                    </Otherwise>
                                </Choose>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    }
}

export default CoachOptions;