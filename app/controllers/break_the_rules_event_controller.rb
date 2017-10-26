class BreakTheRulesEventController < ApplicationController
  def index
    @break_the_rules_events = BreakTheRulesEvent.all
  end

  def new
    @break_the_rules_event = BreakTheRulesEvent.new
  end

  def create
    
  end

  def edit

  end

  def update

  end

  def destroy

  end
end
