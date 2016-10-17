import {render} from 'react-dom';
import StripeCheckout from 'react-stripe-checkout';
import CoachOptions from 'views/account/coach_options';

class Subscription extends React.Component {
    constructor(props) {
        super(props);
        this.currentSubText = this.currentSubText.bind(this);
        this.displayAccountOptions = this.displayAccountOptions.bind(this);
    }

    currentSubText() {
        if (this.props.user.is_coach) {
            if (this.props.user.num_accts == 30) {
                return 'You have a Bronze Subscription.';
            } else if (this.props.user.num_accts == 100) {
                return 'You have a Silver Subscription.';
            } else if (this.props.user.num_accts > 100) {
                return 'You have a Gold Subscription.';
            } else {
                return 'You have free Trial Subscription.';
            }
        }

        if (this.props.user.is_sub_user) {
            return 'Your coach pays for membership, which is pretty cool.';
        } else {
            if (this.props.user.paid_tier == 1) {
                return "You have a basic Quadfit membership, which is free. " +
                    "<br/><br/>Get access to even more exercises and unlimited reporting on workout progress for only " +
                    "<span className='purple'>$9.99</span> a month!";
            } else {
                return 'You have a Premium Quadfit membership, which is $9.99/mo.';
            }
        }
    }

    displayAccountOptions() {
        if (this.props.user.is_coach) {
            return this.displayCoachOptions();
        } else if (this.props.user.is_individual) {
            return this.displayIndividualOptions();
        }
    }

    displayCoachOptions() {
        return <CoachOptions
            {...this.props}
            changeAccount={this.props.changeAccount}
            deleteSubscription={this.props.deleteSubscription}
            updateBilling={this.props.updateBilling}
            bronzeCheckout={this.props.bronzeCheckout}
            silverCheckout={this.props.silverCheckout}
            goldCheckout={this.props.goldCheckout}
            />
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
                <If condition={this.props.user.status == 3}>
                    <div>Whoa! Looks like we weren't able to bill you this month. Please update your billing info.</div>
                </If>

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
        return <div>
            <div className={this.props.user.is_coach ? "col-xs-12" : "col-xs-12 col-sm-6"}>
                <div className="p-section">
                    <div className="sec-header">Subscription</div>
                    <div className="sec-main">
                        <div>
                            {this.currentSubText()}
                        </div>
                        {this.displayAccountOptions()}


                        <If condition={this.props.user.status == 3}>
                            <div>Whoa! Looks like we weren't able to bill you this month. Please update your billing info.</div>
                        </If>
                        <If condition={this.props.user.status == 4}>
                            <div>Your subscription is set to cancel at the end of this billing period.</div>
                        </If>
                        <If condition={this.props.checkout.status}>
                            <div>Updated successfully!</div>
                        </If>
                        <If condition={!this.props.checkout.status && this.props.checkout.errors}>
                            <div>{this.props.checkout.errors}</div>
                        </If>
                    </div>
                </div>
            </div>
        </div>
    }
}

export default Subscription;