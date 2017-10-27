class AddBreakTheRulesEventTable < ActiveRecord::Migration
  def change
    create_table :break_the_rules_events do |t|
      t.date :event_date
      t.timestamps null: false
    end
  end
end
