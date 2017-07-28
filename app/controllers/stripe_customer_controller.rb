class StripeCustomerController < ApplicationController

  before_filter :get_customer_from_params, only: [:edit, :update, :show, :destroy, :save_card_details]
  before_filter :permit_attributes, only: [:create, :update]

  def index
    @customers = StripeCustomer.all
  end

  def show
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
      redirect_to new_stripe_customer_path(@customer)
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
  end

  def destroy
  end

  private
  def get_customer_from_params
    @customer = StripeCustomer.find(params[:id])
  end

  def permit_attributes
    params.require(:stripe_customer).permit!
  end
end