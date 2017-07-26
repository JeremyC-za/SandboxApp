class StripeCustomer < ActiveRecord::Base
  self.table_name = "stripe_customers"
  has_many :stripe_charges

  validates_presence_of :first_name, :last_name, :email

  def full_name
    "#{self.last_name}, #{self.first_name}"
  end

  def human_name
    "#{self.first_name} #{self.last_name}"
  end
end
