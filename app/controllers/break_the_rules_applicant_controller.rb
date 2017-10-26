class BreakTheRulesApplicantController < ApplicationController
  before_filter :get_event_and_applicants

  def index
  end

  def show

  end

  def edit

  end

  def update

  end

  def new

  end

  def create

  end

  private
  def get_event_and_applicants
    @event = BreakTheRulesEvent.find(params[:break_the_rules_event_id])
    @applicants = @event.applicants
  end
end
