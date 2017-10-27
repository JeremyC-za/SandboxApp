class BreakTheRulesApplicantController < ApplicationController
  before_filter :get_event_and_applicants

  def index
  end

  def show
  end

  def edit
  end

  def update
    params.require(:break_the_rules_applicant).permit!
    if @applicant.update_attributes(params[:break_the_rules_applicant])
      redirect_to thank_you_break_the_rules_event_break_the_rules_applicant_path(@event, @applicant)
    else
      render action: :edit
    end
  end

  def new
    @applicant = BreakTheRulesApplicant.new(break_the_rules_event_id: @event.id)
  end

  def create
    params.require(:break_the_rules_applicant).permit!
    @applicant = BreakTheRulesApplicant.new(break_the_rules_event_id: @event.id)
    if @applicant.update_attributes(params[:break_the_rules_applicant])
      redirect_to thank_you_break_the_rules_event_break_the_rules_applicant_path(@event, @applicant)
    else
      render action: :new
    end
  end

  def thank_you
  end

  def destroy
    @applicant.delete
    flash[:notice] = "Applicant Deleted"
    redirect_to break_the_rules_event_path(@event)
  end

  def export_as_csv
    # TODO
  end

  private
  def get_event_and_applicants
    @event = BreakTheRulesEvent.find(params[:break_the_rules_event_id])
    @applicant = BreakTheRulesApplicant.find_by(id: params[:id])
    @applicants = @event.applicants
  end
end
