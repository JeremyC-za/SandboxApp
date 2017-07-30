require 'test_helper'

class StripeChargeTest < ActiveSupport::TestCase
  UNSUCCESSFUL_CUSTOMER = Stripe::Customer.retrieve("cus_B7WKEdNOMTvf1y")
  SUCCESSFUL_CUSTOMER = Stripe::Customer.retrieve("cus_B7Wgytsfh4SwjL")

  test "successful_stripe_charge" do
    customer = StripeCustomer.create!(first_name: "First", last_name: "Last", email: "nah", external_id: SUCCESSFUL_CUSTOMER.id)
    charge = StripeCharge.new(amount: 2000, currency: 'ZAR', external_id: "none yet", stripe_customer_id: customer.id, status: "failed")

    assert_equal StripeCharge.count, 0
    assert_equal customer.stripe_charges.count, 0

    result = charge.charge_customer

    assert_equal result[0], true
    assert_nil result[1]
    assert_equal StripeCharge.count, 1
    assert_equal charge.reload.status, "succeeded"
    assert_equal customer.reload.stripe_charges.count, 1
  end

  test "unsuccessful_stripe_charge" do
    customer = StripeCustomer.create!(first_name: "First", last_name: "Last", email: "nah", external_id: UNSUCCESSFUL_CUSTOMER.id)
    charge = StripeCharge.new(amount: 2000, currency: 'ZAR', external_id: "none yet", stripe_customer_id: customer.id, status: "failed")

    assert_equal StripeCharge.count, 0
    assert_equal customer.stripe_charges.count, 0

    result = charge.charge_customer

    assert_equal result[0], false
    assert_equal result[1], "Your card was declined."
    assert_equal StripeCharge.count, 1
    assert_equal charge.reload.status, "failed"
    assert_equal customer.reload.stripe_charges.count, 1
  end
end
