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
    return [false, "Charge is invalid"] if !self.valid?
    external_customer = Stripe::Customer.retrieve(customer.external_id)
    charge = Stripe::Charge.create(:amount => amount, :currency => currency, :customer => external_customer, :description => "Charge for #{customer.human_name}")

    self.update(external_id: charge.id, status: "succeeded") if charge[:status] = "succeeded"
    self.save!
    return [true, nil]

    rescue Stripe::CardError, Stripe::InvalidRequestError => e
      # error message is nasty for invalid currency code, but meh, is functional...
      body = e.json_body[:error][:message]
      self.update(external_id: "Failed: #{body}", status: "failed")
      self.save!
      return [false, body]
  end
end
