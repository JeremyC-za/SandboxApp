class BreakTheRulesEventController < ApplicationController
  def index
    @events = BreakTheRulesEvent.all.order(:event_date)
  end

  def new
    @event = BreakTheRulesEvent.new
  end

  def create
    params.require(:break_the_rules_event).permit!
    @event = BreakTheRulesEvent.new(params[:break_the_rules_event])

    if @event.save
      flash[:notice] = "Event Created Successfully."
      redirect_to break_the_rules_event_path(@event)
    else
      render new_break_the_rules_event_path
    end
  end

  def show
    @event = BreakTheRulesEvent.find(params[:id])
  end

  def edit
    @event = BreakTheRulesEvent.find(params[:id])
  end

  def update
    params.require(:break_the_rules_event).permit!
    @event = BreakTheRulesEvent.find(params[:id])

    if @event.update_attributes(params[:break_the_rules_event])
      flash[:notice] = "Event Has Been Updated."
      redirect_to break_the_rules_event_path(@event)
    else
      render action: :edit
    end
  end

  def destroy
    @event = BreakTheRulesEvent.find(params[:id])
    @event.applicants.delete_all
    @event.delete

    flash[:notice] = "Event Deleted"
    redirect_to break_the_rules_event_index_path
  end

  def download_csv
    @event = BreakTheRulesEvent.find(params[:id])
    respond_to { |format| format.csv { send_data(@event.to_csv, :filename => "#{@event.name}.csv") } }
  end
end
