class BreakTheRulesEvent < ActiveRecord::Base
  self.table_name = "break_the_rules_events"
  has_many :applicants, foreign_key: "break_the_rules_event_id", class_name: "BreakTheRulesApplicant"
  validates_presence_of :event_date

  def name
    "BreakTheRules Event for #{event_date}"
  end
end
