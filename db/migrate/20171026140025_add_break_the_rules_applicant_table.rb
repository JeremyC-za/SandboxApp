class AddBreakTheRulesApplicantTable < ActiveRecord::Migration
  def change
    create_table :break_the_rules_applicants do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :year_of_study, null: false
      t.integer :break_the_rules_event_id, null: false
      t.text :optional_message
      t.timestamps null: false
    end
  end
end
