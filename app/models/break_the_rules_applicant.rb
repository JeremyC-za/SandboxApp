class BreakTheRulesApplicant < ActiveRecord::Base
  self.table_name = "break_the_rules_applicants"
  belongs_to :break_the_rules_event
  
end
