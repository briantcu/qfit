import {render} from 'react-dom';
import StripeCheckout from 'react-stripe-checkout';

class CoachOptions extends React.Component {
    constructor(props) {
        super(props);
    }

    displayIndividualOptions() {
        if (this.props.user.paid_tier == 1) {
            return <div className="button-wrap">
                <StripeCheckout
                    token={this.props.premiumCheckout}
                    stripeKey="pk_test_Qn7vO7ACSbGqKp7tBXget5Du"
                    amount={999}
                    name="Quadfit, LLC"
                    image="https://s3.amazonaws.com/quadfit/logo-1.jpg"
                    description="Premium Subscription"
                    panelLabel="Get Premium"
                    label="Get Premium"
                    allowRememberMe={false}
                    email={this.props.user.email}
                    local="auto"
                />
            </div>
        } else {
            return <div className="button-wrap">
                <StripeCheckout
                    token={this.props.updateBilling}
                    stripeKey="pk_test_Qn7vO7ACSbGqKp7tBXget5Du"
                    name="Quadfit, LLC"
                    image="https://s3.amazonaws.com/quadfit/logo-1.jpg"
                    description="Update Billing"
                    panelLabel="Update Billing"
                    label="Update Billing"
                    allowRememberMe={false}
                    email={this.props.user.email}
                    local="auto"
                />
                <Button onClick={this.props.changeAccount} buttonText={"Downgrade"}/>
            </div>
        }
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
                            <td>2 Months Tracking</td>
                            <td>Unlimited Tracking</td>
                            <td>Unlimited Tracking</td>
                            <td>Unlimited Tracking</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    }
}

export default CoachOptions;