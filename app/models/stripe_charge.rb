class StripeCharge < ActiveRecord::Base
  self.table_name = "stripe_charges"
  belongs_to :stripe_customer
end
