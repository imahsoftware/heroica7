class MantenimientosobservacionesController < ApplicationController
  before_filter :require_user

  # GET /mantenimientosobservaciones
  # GET /mantenimientosobservaciones.xml
  def index
    @mantenimientosobservaciones = Mantenimientosobservacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mantenimientosobservaciones }
    end
  end

  # GET /mantenimientosobservaciones/1
  # GET /mantenimientosobservaciones/1.xml
  def show
    @mantenimientosobservacion = Mantenimientosobservacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mantenimientosobservacion }
    end
  end

  # GET /mantenimientosobservaciones/new
  # GET /mantenimientosobservaciones/new.xml
  def new
    @mantenimientosobservacion = Mantenimientosobservacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mantenimientosobservacion }
    end
  end

  # GET /mantenimientosobservaciones/1/edit
  def edit
    @mantenimientosobservacion = Mantenimientosobservacion.find(params[:id])
  end

  # POST /mantenimientosobservaciones
  # POST /mantenimientosobservaciones.xml
  def create
    @mantenimientosobservacion = Mantenimientosobservacion.new(params[:mantenimientosobservacion])

    respond_to do |format|
      if @mantenimientosobservacion.save
        flash[:notice] = 'Mantenimientosobservacion was successfully created.'
        format.html { redirect_to(@mantenimientosobservacion) }
        format.xml  { render :xml => @mantenimientosobservacion, :status => :created, :location => @mantenimientosobservacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mantenimientosobservacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mantenimientosobservaciones/1
  # PUT /mantenimientosobservaciones/1.xml
  def update
    @mantenimientosobservacion = Mantenimientosobservacion.find(params[:id])

    respond_to do |format|
      if @mantenimientosobservacion.update_attributes(params[:mantenimientosobservacion])
        flash[:notice] = 'Mantenimientosobservacion was successfully updated.'
        format.html { redirect_to(@mantenimientosobservacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mantenimientosobservacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mantenimientosobservaciones/1
  # DELETE /mantenimientosobservaciones/1.xml
  def destroy
    @mantenimientosobservacion = Mantenimientosobservacion.find(params[:id])
    @mantenimientosobservacion.destroy

    respond_to do |format|
      format.html { redirect_to(mantenimientosobservaciones_url) }
      format.xml  { head :ok }
    end
  end
end
