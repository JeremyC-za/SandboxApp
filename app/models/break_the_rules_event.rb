require 'csv'

class BreakTheRulesEvent < ActiveRecord::Base
  self.table_name = "break_the_rules_events"
  has_many :applicants, foreign_key: "break_the_rules_event_id", class_name: "BreakTheRulesApplicant"
  validates_presence_of :event_date

  def name
    "BreakTheRules Event for #{event_date}"
  end

  def to_csv
    CSV.generate(headers: true) do |csv|
      csv << ["Name", "Email", "Year of Study", "Optional Message"]
      applicants.each do |applicant|
      csv << [
        applicant.display_name,
        applicant.email,
        BreakTheRulesApplicant::YEARS_OF_STUDY[applicant.year_of_study],
        applicant.optional_message
      ]
      end
    end
  end
end