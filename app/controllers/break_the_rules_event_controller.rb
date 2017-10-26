class BreakTheRulesEventController < ApplicationController
  def index
    @break_the_rules_events = BreakTheRulesEvent.all.order(:event_date)
  end

  def new
    @break_the_rules_event = BreakTheRulesEvent.new
  end

  def create
    params.require(:break_the_rules_event).permit!
    @break_the_rules_event = BreakTheRulesEvent.new(params[:break_the_rules_event])

    if @break_the_rules_event.save
      flash[:notice] = "Event Created Successfully."
      redirect_to break_the_rules_event_path(@break_the_rules_event)
    else
      render new_break_the_rules_event_path
    end
  end

  def show
    @break_the_rules_event = BreakTheRulesEvent.find(params[:id])
  end

  def edit
    @break_the_rules_event = BreakTheRulesEvent.find(params[:id])
  end

  def update
    params.require(:break_the_rules_event).permit!
    @break_the_rules_event = BreakTheRulesEvent.find(params[:id])

    if @break_the_rules_event.update_attributes(params[:break_the_rules_event])
      flash[:notice] = "Event Has Been Updated."
      redirect_to break_the_rules_event_path(@break_the_rules_event)
    else
      render action: :edit
    end
  end

  def destroy
    @break_the_rules_event = BreakTheRulesEvent.find(params[:id])
    @break_the_rules_event.applicants.delete_all
    @break_the_rules_event.delete

    flash[:notice] = "Event Deleted"
    redirect_to break_the_rules_event_index_path
  end
end
