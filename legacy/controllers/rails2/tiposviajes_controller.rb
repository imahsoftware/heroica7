class TiposviajesController < ApplicationController
  
    before_filter :require_user
    
  def add_tiposviaje
    @tiposviaje = Tiposviaje.new(params[:tiposviaje])
    @tiposviaje.save
    @tiposviajes = Tiposviaje.all
    respond_to do |format|
      if @tiposviaje.save
        format.html { redirect_to tiposviajes_path }
        format.js
      else
        format.html { redirect_to tiposviajes_path }
        format.js
      end
    end
  end


  # GET /tiposviajes
  # GET /tiposviajes.xml
  def index
    @tiposviajes = Tiposviaje.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposviajes }
    end
  end

  # GET /tiposviajes/1
  # GET /tiposviajes/1.xml
  def show
    @tiposviaje = Tiposviaje.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiposviaje }
    end
  end

  # GET /tiposviajes/new
  # GET /tiposviajes/new.xml
  def new
    @tiposviaje = Tiposviaje.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiposviaje }
    end
  end

  # GET /tiposviajes/1/edit
  def edit
    @tiposviaje = Tiposviaje.find(params[:id])
  end

  # POST /tiposviajes
  # POST /tiposviajes.xml
  def create
    @tiposviaje = Tiposviaje.new(params[:tiposviaje])

    respond_to do |format|
      if @tiposviaje.save
        flash[:notice] = 'Tiposviaje was successfully created.'
        format.html { redirect_to(@tiposviaje) }
        format.xml  { render :xml => @tiposviaje, :status => :created, :location => @tiposviaje }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiposviaje.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposviajes/1
  # PUT /tiposviajes/1.xml
  def update
    @tiposviaje = Tiposviaje.find(params[:id])

    respond_to do |format|
      if @tiposviaje.update_attributes(params[:tiposviaje])
        flash[:notice] = 'Tiposviaje was successfully updated.'
        format.html { redirect_to(@tiposviaje) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiposviaje.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposviajes/1
  # DELETE /tiposviajes/1.xml
  def destroy
    @tiposviaje = Tiposviaje.find(params[:id])
    @tiposviaje.destroy

    respond_to do |format|
      format.html { redirect_to(tiposviajes_url) }
      format.xml  { head :ok }
    end
  end
end
