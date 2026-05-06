class TeoricosController < ApplicationController
  before_filter :require_user, :except=>"index"
  layout :determine_layout

  def index
#    persona   = Persona.find(params[:persona_id])
#    @teoricos = persona.teoricos.all
  end

  def busqueda
    @personas      = Persona.find_by_identificacion(params[:buscarident])
    if @personas.id
      if Teorico.exists?(["persona_id = #{@personas.id} and estado = 'PENDIENTE'"])
        @teorico = Teorico.find(:first, :conditions=>["persona_id = #{@personas.id} and estado = 'PENDIENTE'"], :order=>"id", :limit=>1)
        @teoricosresultados = Teoricosresultado.find(:first, :conditions=>["teorico_id = #{@teorico.id}"], :order=>"id", :limit=>1)
        redirect_to edit_teoricosresultado_path(@teoricosresultados)
      else
        flash[:warninglogin] = "El usuario no tiene prueba programada"
        redirect_to teoricos_path
      end
    else
      flash[:warninglogin] = "La usuario no existe"
      redirect_to teoricos_path
    end
  rescue
    flash[:warninglogin] = "Debe digitar datos para la consulta"
    redirect_to teoricos_path
  end
  
  def edit
    @teorico  = Teorico.find(params[:id], :include => "persona")
    @persona  = @teorico.persona
    respond_to do |format|
      format.js { render :action => "edit_teorico" }
    end
  end

  def informe
    @teorico  = Teorico.find(params[:id])
    @teoricosresultados = Teoricosresultado.find_all_by_teorico_id(@teorico.id)
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @teorico = Teorico.new(params[:teorico])
    @teorico.user_id = is_admin
    if @teorico.valid?
      @persona.teoricos << @teorico
      @persona.save
      @teorico = Teorico.new
      flash[:teorico] = "Creado con exito"
    else
      flash[:teorico] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "teoricos" }
    end
  end

  def update
    @teorico        = Teorico.new
    teorico         = Teorico.find(params[:id])
    teorico.user_actualiza = is_admin
    @persona        = teorico.persona
    ok = teorico.update_attributes(params[:teorico])
    if ok == true
      flash[:teorico] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "teoricos" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    teorico   = Teorico.find(params[:id])
    @persona  = teorico.persona
    @teorico  = Teorico.new
    teorico.destroy
    flash[:teorico] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "teoricos" }
    end
  end

  private
  def determine_layout
    if ['crearfactura','index','iniciarteorico'].include?(action_name)
      "basico"
    elsif ['informe'].include?(action_name)
      "informes"
    else
      "application"
    end
  end
end
