class CreateStripeCharges < ActiveRecord::Migration
  def change
    create_table :stripe_customers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :external_id, null: false
      t.timestamps null: false
    end

    create_table :stripe_charges do |t|
      t.integer :amount, null: false
      t.string :currency, null: false
      t.string :external_id, null: false
      t.integer :stripe_customer_id, null: false
      t.boolean :status, null: false
      t.timestamps null: false
    end
  end
end
