class StripeChargeController < ApplicationController
  def index
    @charges = StripeCharge.all
  end

  def new
    @customer = StripeCustomer.find(params[:stripe_customer_id])
    @charge = StripeCharge.new
  end

  def create
    # treat the charge as if it failed until we confirm it succeeded
    @customer = StripeCustomer.find(params[:stripe_customer_id])
    params.require(:stripe_charge).permit!
    charge = StripeCharge.new(params[:stripe_charge])
    charge.external_id = "Not Attemped Yet"
    charge.status = "failed"
    charge.stripe_customer_id = @customer.id

    StripeCharge.transaction do
      if charge.save && charge.charge_customer
        flash[:notice] = "Customer Has Been Charged"
        redirect_to stripe_customer_stripe_charge_path(@customer, charge)
      else
        flash[:error] = "An Error Occurred"
        redirect_to new_stripe_customer_stripe_charge_path(@customer)
      end
    end
  end
end