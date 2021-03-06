class EventsController < ApplicationController
  
  before_action :set_event, :only => ['show', 'edit', 'update', 'destroy']
  
  def index
    #@events = Event.all
    @events = Event.page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.xml {render :xml => @events.to_xml}
      format.json {render :json => @events.to_json}
      format.atom {@feed_title = "My event list"} #index.atom.builder
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    #@event = Event.new(:name => params[:event][:name])
    if @event.save
      flash[:notice] = 'event was successfully created'
      redirect_to events_path
    else
      flash[:alert] = 'event cerating was failed'
      render :action => :new
    end
  end

  def show
    #@page_title = @event.name
    respond_to do |format|
      #logger.debug "event: #{@event.inspect}"
      format.html {@page_title = @event.name}
      format.xml
      format.json {render :json => {id: @event.id, name: @event.name}.to_json}
    end
  end

  def edit
    @page_title = @event.name
  end

  def update
    @page_title = @event.name
    #if find_or_creat_by_name(@event.location
    if @event.update(event_params)
      flash[:notice] = 'event was successfully updated'
      redirect_to event_path(@event)
      #redirect_to :action => :show, :id => @event
    else
      flash[:alert] = 'event editing was failed'
      render :action => :edit
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = 'event was successfully deleted'
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :category_id,
                                  :location_attributes => [:id, :name, :_destroy])
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
