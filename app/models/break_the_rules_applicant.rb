class BreakTheRulesApplicant < ActiveRecord::Base
  self.table_name = "break_the_rules_applicants"
  belongs_to :event, foreign_key: "break_the_rules_event_id", class_name: "BreakTheRulesEvent"

  validates_presence_of :first_name, :last_name, :email, :year_of_study
  validates_numericality_of :year_of_study

  YEARS_OF_STUDY = {
    (FIRST = '1') => 'First Year',
    (SECOND = '2') => 'Second Year',
    (THIRD = '3') => 'Third Year',
    (FOURTH = '4') => 'Fourth Year',
    (HONOURS = '5') => 'Honours',
    (MASTERS = '6') => 'Masters',
    (PHD = '7') => 'PhD',
    (OTHER = '8') => 'Other'}

  def display_name
    "#{first_name} #{last_name}"
  end
end
