import {render} from 'react-dom';
import StripeCheckout from 'react-stripe-checkout';

class Subscription extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <div>
            <If condition={this.props.user.paid_tier == 1}>
                <div className="col-xs-12 col-sm-6">
                    <div className="p-section">
                        <div className="sec-header">Premium Account</div>
                        <div className="sec-main">
                            <div>Get access to even more exercises and unlimited reporting on workout progress
                                for only <span className="purple">$9.99</span> a month!
                            </div>
                            <div className="button-wrap">
                                <StripeCheckout
                                    token={this.props.onToken}
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
                            <If condition={this.props.checkout.status}>
                                <div>Checkout success!</div>
                            </If>
                            <If condition={!this.props.checkout.status && this.props.checkout.errors}>
                                <div>{this.props.checkout.errors}</div>
                            </If>
                        </div>
                    </div>
                </div>
            </If>
            <If condition={this.props.user.paid_tier == 2}>
                <div className="col-xs-12 col-sm-6">
                    <div className="p-section">
                        <div className="sec-header">Your Account</div>
                        <div className="sec-main">
                            <div>You have a premium account, which gives you access to the complete Quadfit library of
                                exercises
                                and unlimited reporting for only <span className="purple">$9.99</span> a month!
                            </div>
                            <br/>
                            If you choose to downgrade your account you'll lose access to the complete Quadfit library,
                            and you'll only be able to see your progress for the last month.
                            <div className="button-wrap">
                                <Button onClick={this.changeAccount} buttonText={"Downgrade"}/>
                            </div>
                        </div>
                    </div>
                </div>
            </If>
        </div>
    }
}

export default Subscription;