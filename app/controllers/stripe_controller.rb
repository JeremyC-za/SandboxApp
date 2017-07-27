class StripeController < ApplicationController
  # Using this controller to manage the Stripe customers and stripe charges
  # Ideally you'd probably want to have those as two separate controllers though
  # But for the sake of this app I'm just putting them together

  before_filter :get_customer_from_params, only: [:customers_show, :customers_edit, :customers_update, :customers_save_card_details]

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
    customer = StripeCustomer.new
    customer.first_name = params[:stripe_customer][:first_name]
    customer.last_name = params[:stripe_customer][:last_name]
    customer.email = params[:stripe_customer][:email]
    
    if customer.save
      flash[:notice] = "Customer Created!"
      redirect_to customers_show_stripe_path(customer)
    else
      flash[:error] = "An Error Occurred"
      redirect_to action: :customers_new
    end
  end

  def customers_save_card_details
    ext_customer = Stripe::Customer.create(:email => @customer.email, :source => params[:stripeToken])
    if @customer.update(external_id: ext_customer.id)
      flash[:notice] = "Card Details Captured"
    else
      flash[:notice] = "An Error Occurred - Card Details Not Captured"
    end

    redirect_to customers_show_stripe_path(@customer)
  end

  def customers_edit
  end

  def customers_update
    @customer.first_name = params[:stripe_customer][:first_name]
    @customer.last_name = params[:stripe_customer][:last_name]
    @customer.email = params[:stripe_customer][:email]

    if @customer.save
      flash[:notice] = "Customer Updated"
    else
      flash[:error] = "An Error Occurred"
      redirect_to :customers_edit
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
