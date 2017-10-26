class BreakTheRulesEvent < ActiveRecord::Base
  self.table_name = "break_the_rules_events"
  has_many :break_the_rules_applicants
  
end
