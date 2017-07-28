class StripeCharge < ActiveRecord::Base
  self.table_name = "stripe_charges"
  belongs_to :stripe_customer

  validates :currency, presence: true, length: { is: 3 }
  validates :amount, presence: true, numericality: true

  scope :successful, -> { where(status: "succeeded") }
  scope :failed, -> { where(status: "failed") }

  def customer
    # nicer to type
    self.stripe_customer
  end

  def charge_customer
    Stripe.max_network_retries = 2 # idempotently retries charges up to 2 times if the initial charge attempt fails
    external_customer = Stripe::Customer.retrieve(customer.external_id)
    charge = Stripe::Charge.create(:amount => amount, :currency => currency, :customer => external_customer, :description => "Charge for #{customer.human_name}")

    rescue Stripe::CardError, Stripe::InvalidRequestError => e
      body = e.json_body[:error][:message]
      self.update!(external_id: "Failed: #{body}", status: "failed")
      raise ActiveRecord::Rollback

    if charge[:status] = "succeeded"
      self.update!(external_id: charge.id, status: "succeeded")
    end

    true
  end
end
