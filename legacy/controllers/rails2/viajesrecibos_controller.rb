class ViajesrecibosController < ApplicationController
  before_filter :require_user
    layout :determine_layout
  
  def crearrecibo
    @viajeid = params[:viaje_id]
    tiposviaje = Tiposviaje.find(params[:tiposviaje])
    @viajesrecibos = Viajesrecibo.find_by_sql("select max(nro_recibo) recibo from viajesrecibos")
    @viajesrecibos.each do |viaje|
      if viaje.recibo == nil
        nro_recibo = 1000
      else
        nro_recibo = viaje.recibo.to_i + 1
      end    
      viajesrecibo = Viajesrecibo.new
      viajesrecibo.viaje_id = @viajeid
      viajesrecibo.nro_recibo = nro_recibo
      viajesrecibo.estado = '0'
      viajesrecibo.valor = tiposviaje.valor
      viajesrecibo.save
      flash[:notice] = "El recibo ha sido generado con Exito."
      redirect_to edit_viaje_path(@viajeid)
    end
  end

  def eliminar
    @viajesrecibo = Viajesrecibo.find_all_by_viaje_id_and_estado(params[:viaje_id],'0')
    @viajesrecibo.each do |viajesrecibo|
      viajesrecibo.estado = '1'
      viajesrecibo.save
    end
    flash[:notice] = "El recibo ha sido Anulado con Exito."
    redirect_to edit_viaje_path(params[:viaje_id])
  end

  def index
    @viajesrecibos = Viajesrecibo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @viajesrecibos }
    end
  end

  # GET /viajesrecibos/1
  # GET /viajesrecibos/1.xml
  def show
    @viajesrecibo = Viajesrecibo.find_by_viaje_id_and_estado(params[:viaje_id],'0')
#    @viajesrecibo = Viajesrecibo.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @viajesrecibo }
#    end
  end

  # GET /viajesrecibos/new
  # GET /viajesrecibos/new.xml
  def new
    @viajesrecibo = Viajesrecibo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @viajesrecibo }
    end
  end

  # GET /viajesrecibos/1/edit
  def edit
    @viajesrecibo = Viajesrecibo.find(params[:id])
  end

  # POST /viajesrecibos
  # POST /viajesrecibos.xml
  def create
    @viajesrecibo = Viajesrecibo.new(params[:viajesrecibo])

    respond_to do |format|
      if @viajesrecibo.save
        flash[:notice] = 'Viajesrecibo was successfully created.'
        format.html { redirect_to(@viajesrecibo) }
        format.xml  { render :xml => @viajesrecibo, :status => :created, :location => @viajesrecibo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @viajesrecibo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /viajesrecibos/1
  # PUT /viajesrecibos/1.xml
  def update
    @viajesrecibo = Viajesrecibo.find(params[:id])

    respond_to do |format|
      if @viajesrecibo.update_attributes(params[:viajesrecibo])
        flash[:notice] = 'Viajesrecibo was successfully updated.'
        format.html { redirect_to(@viajesrecibo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @viajesrecibo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /viajesrecibos/1
  # DELETE /viajesrecibos/1.xml
  def destroy
    @viajesrecibo = Viajesrecibo.find(params[:id])
    @viajesrecibo.destroy

    respond_to do |format|
      format.html { redirect_to(viajesrecibos_url) }
      format.xml  { head :ok }
    end
  end

    private
  def determine_layout
    if ['show'].include?(action_name)
      "cartas"
    else
      "application"
    end
  end
end
