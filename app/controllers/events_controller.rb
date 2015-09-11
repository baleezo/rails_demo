class EventsController < ApplicationController
  
  before_action :set_event, :only => ['show', 'edit', 'update', 'destroy']
  
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    #@event = Event.new(:name => params[:event][:name])
    @event.save

    redirect_to :action => :index
  end

  def show
    @page_title = @event.name
  end

  def edit
    @page_title = @event.name
  end

  def update
    @page_title = @event.name
    @event.update(event_params)

    redirect_to :action => :show, :id => @event
  end

  def destroy
    @event.destroy

    redirect_to :action => :index
  end

  private

  def event_params
    params.require(:event).permit(:name, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
