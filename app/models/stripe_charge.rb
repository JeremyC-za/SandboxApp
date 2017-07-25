class StripeCharge < ActiveRecord::Base
  self.table_name = "stripe_charges"
  belongs_to :stripe_customer

  scope :successful, -> { where(status: "succeeded") }
  scope :failed, -> { where(status: "failed") }
end
