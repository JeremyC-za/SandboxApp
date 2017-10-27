class StripeCustomerController < ApplicationController

  before_filter :get_customer_from_params, only: [:edit, :update, :show, :destroy, :save_card_details, :view_all_charges]
  before_filter :permit_attributes, only: [:create, :update]

  def index
    @customers = StripeCustomer.all
  end

  def show
    @active_card = nil
    if @customer.external_id
      external_customer = Stripe::Customer.retrieve(@customer.external_id)
      customer_source = external_customer.sources.data.first
      
      @active_card = {
        external_id: customer_source.id,
        card_information: "#{customer_source.brand} Ending #{customer_source.last4}",
        expiry_date: "#{customer_source.exp_month} / #{customer_source.exp_year}"
      }
    end
  end

  def new
    @customer = StripeCustomer.new
  end

  def create
    new_customer = StripeCustomer.new(params[:stripe_customer])
    if new_customer.save
      flash[:notice] = "Customer Created"
      redirect_to stripe_customer_path(new_customer)
    else
      flash[:error] = "An Error Occurred"
      redirect_to new_stripe_customer_path
    end
  end

  def edit
  end

  def update
    if @customer.update(params[:stripe_customer])
      flash[:notice] = "Customer Details Updated"
      redirect_to stripe_customer_path(@customer)
    else
      flash[:error] = "An Error Occurred"
      redirect_to edit_stripe_customer_path(@customer)
    end
  end

  def save_card_details
    # Edits external stripe customer
    if @customer.external_id
      external_customer = Stripe::Customer.retrieve(@customer.external_id)
      external_customer.source = params[:stripeToken]
      if external_customer.save
        flash[:notice] = "Card Details Updated"
      else
        flash[:error] = "An Error Occurred"
      end

    # Creates a new external stripe customer
    else
      external_customer = Stripe::Customer.create(:email => @customer.email, :source => params[:stripeToken])
      if @customer.update(external_id: external_customer.id)
        flash[:notice] = "Card Details Captured"
      else
        flash[:error] = "An Error Occurred"
      end
    end

    redirect_to stripe_customer_path(@customer)
  end

  def destroy
    @customer.stripe_charges.each do |charge|
      StripeCharge.delete(charge)
    end
    StripeCustomer.delete(@customer)

    flash[:notice] = "Customer #{@customer.human_name} deleted!"
    redirect_to stripe_customer_index_path
  end

  def view_all_charges
    @charges = @customer.stripe_charges
  end

  private
  def get_customer_from_params
    @customer = StripeCustomer.find(params[:id])
  end

  def permit_attributes
    params.require(:stripe_customer).permit!
  end
end
