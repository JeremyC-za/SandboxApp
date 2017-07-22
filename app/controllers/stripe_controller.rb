class StripeController < ApplicationController
  # Using this controller to manage the Stripe customers and stripe charges
  # Ideally you'd probably want to have those as two separate controllers though

  def index
  end

  def customers_index
    @customers = StripeCustomer.all
  end

  def customers_show
    @customer = StripeCustomer.find(params[:id])
  end

  def customers_new
  end

  def customers_create
  end

  def customers_edit
    @customer = StripeCustomer.find(params[:id])
  end

  def customers_update
    @customer = StripeCustomer.find(params[:id])

    # this should use strong params, but I'm too lazy right now...
    @customer.first_name = params[:stripe_customer][:first_name]
    @customer.last_name = params[:stripe_customer][:last_name]

    if @customer.save
      flash[:notice] = "Customer Updated"
    else
      flash[:error] = "No"
      render :customers_edit
      return
    end

    redirect_to customers_show_stripe_path(@customer)
  end

  def charges_index
    @charges = StripeCharge.all
  end

  def charges_new
  end

  def charges_create
  end
end
