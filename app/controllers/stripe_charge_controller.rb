class StripeChargeController < ApplicationController
  def index
    @charges = StripeCharge.all
  end

  def new
  end
end