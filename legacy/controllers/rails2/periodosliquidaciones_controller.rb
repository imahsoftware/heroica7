class PeriodosliquidacionesController < ApplicationController
  # GET /periodosliquidaciones
  # GET /periodosliquidaciones.xml
  def index
    @periodosliquidaciones = Periodosliquidacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @periodosliquidaciones }
    end
  end

  # GET /periodosliquidaciones/1
  # GET /periodosliquidaciones/1.xml
  def show
    @periodosliquidacion = Periodosliquidacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @periodosliquidacion }
    end
  end

  # GET /periodosliquidaciones/new
  # GET /periodosliquidaciones/new.xml
  def new
    @periodosliquidacion = Periodosliquidacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @periodosliquidacion }
    end
  end

  # GET /periodosliquidaciones/1/edit
  def edit
    @periodosliquidacion = Periodosliquidacion.find(params[:id])
  end

  # POST /periodosliquidaciones
  # POST /periodosliquidaciones.xml
  def create
    @periodosliquidacion = Periodosliquidacion.new(params[:periodosliquidacion])

    respond_to do |format|
      if @periodosliquidacion.save
        flash[:notice] = 'Periodosliquidacion was successfully created.'
        format.html { redirect_to(@periodosliquidacion) }
        format.xml  { render :xml => @periodosliquidacion, :status => :created, :location => @periodosliquidacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @periodosliquidacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /periodosliquidaciones/1
  # PUT /periodosliquidaciones/1.xml
  def update
    @periodosliquidacion = Periodosliquidacion.find(params[:id])

    respond_to do |format|
      if @periodosliquidacion.update_attributes(params[:periodosliquidacion])
        flash[:notice] = 'Periodosliquidacion was successfully updated.'
        format.html { redirect_to(@periodosliquidacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @periodosliquidacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /periodosliquidaciones/1
  # DELETE /periodosliquidaciones/1.xml
  def destroy
    @periodosliquidacion = Periodosliquidacion.find(params[:id])
    @periodosliquidacion.destroy

    respond_to do |format|
      format.html { redirect_to(periodosliquidaciones_url) }
      format.xml  { head :ok }
    end
  end
end
