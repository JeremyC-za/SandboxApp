class StripeController < ApplicationController
  # Using this controller to manage the Stripe customers and stripe charges
  # Ideally you'd probably want to have those as two separate controllers though
  # But for the sake of this app I'm just putting them together

  before_filter :get_customer_from_params, only: [:customers_show, :customers_edit, :customers_update]

  def index
  end

  def customers_index
    @customers = StripeCustomer.all
  end

  def customers_show
  end

  def customers_new
    @customer = StripeCustomer.new
  end

  def customers_create
    binding.pry
  end

  def customers_edit
  end

  def customers_update
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

  private
  def get_customer_from_params
    @customer = StripeCustomer.find(params[:id])
  end
end
