class EgresosimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_egreso_and_egresosimagen

  def index
    egreso   = Egreso.find(params[:egreso_id])
    @egresosimagenes = egreso.egresosimagenes.all
  end

  def new
    @egresosimagen = Egresosimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @egresosimagen }
    end
  end

  def create
    @egresosimagen = Egresosimagen.new(params[:egresosimagen])
    @egresosimagen.egreso_id = @egreso.id
    @egresosimagen.user_id = is_admin
    respond_to do |format|
      if @egresosimagen.save
        flash[:notice] = "Documento Cargado con Exito."
        format.html { redirect_to edit_egreso_path(@egreso) }
        format.xml  { render :xml => @egresosimagen, :status => :created, :location => @egresosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @egresosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @egresosimagen = Egresosimagen.find(params[:id])
    respond_to do |format|
      if @egresosimagen.update_attributes(params[:egresosimagen])
        format.html { redirect_to egreso_egresosimagenes_path(@egreso) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @egresosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    egresosimagen   = Egresosimagen.find(params[:id])
    @egreso    = egresosimagen.egreso
    @egresosimagen  = Egresosimagen.new
    egresosimagen.destroy
    render :update do |page|
      page.alert "IMAH - Documento eliminado"
    end
  end

  def find_egreso_and_egresosimagen
    @egreso = Egreso.find(params[:egreso_id])
    @egresosimagen = Egresosimagen.find(params[:id]) if params[:id]
  end

end
