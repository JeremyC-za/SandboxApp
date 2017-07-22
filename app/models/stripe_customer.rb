class StripeCustomer < ActiveRecord::Base
  self.table_name = "stripe_customers"
  has_many :stripe_charges

  def full_name
    "#{self.last_name}, #{self.first_name}"
  end
end
