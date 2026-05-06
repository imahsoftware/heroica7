class TeoricosresultadosController < ApplicationController
  layout :determine_layout

  def index
    @teoricosresultados = Teoricosresultado.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teoricosresultados }
    end
  end


  def edit
    @teoricosresultado = Teoricosresultado.find(params[:id])
    respond_to do |format|
      format.html { render :action => "teoricosresultado_form" }
    end
  end

  def next
    @teoricosresultado = Teoricosresultado.find(:first, :conditions=>["teorico_id = #{params[:id]} and consecutivo = #{params[:consecutivo]}"])
    redirect_to edit_teoricosresultado_path(@teoricosresultado)
  end

  def marcar
    @teoricosresultado = Teoricosresultado.find(params[:id])
    @teoricosresultado.respuesta = params[:opc]
    @teoricosresultado.estado = Teoricosresultado.estadopregunta(@teoricosresultado.pregunta_id,params[:opc])
    @teoricosresultado.save
    #flash[:notice] = "Opcion marcada con exito"
    redirect_to edit_teoricosresultado_path(@teoricosresultado)
  end

  def desmarcar
    @teoricosresultado = Teoricosresultado.find(params[:id])
    @teoricosresultado.respuesta = nil
    @teoricosresultado.estado = nil
    @teoricosresultado.save
    flash[:notice] = "Opcion desmarcada con exito"
    redirect_to edit_teoricosresultado_path(@teoricosresultado)
  end

  def previous
    @teoricosresultado = Teoricosresultado.find(:first, :conditions=>["teorico_id = #{params[:id]} and consecutivo = #{params[:consecutivo]}"])
    redirect_to edit_teoricosresultado_path(@teoricosresultado)
  end

  def finalizar
    @teoricosresultado = Teoricosresultado.find(params[:id])
    @teorico = Teorico.find(@teoricosresultado.teorico_id)
    @teorico.correctas   = Teoricosresultado.count(:conditions => [" teorico_id = #{@teoricosresultado.teorico_id} and estado = 'C'"]).to_i
    @teorico.incorrectas = Teoricosresultado.count(:conditions => [" teorico_id = #{@teoricosresultado.teorico_id} and estado = 'I'"]).to_i
    if @teorico.correctas.to_i >= 38
      @teorico.estado = 'APROBADO'
    else
      @teorico.estado = 'REPROBADO'
    end
    @teorico.save
    flash[:notice] = "Examen teorico finalizado con exito..."
    redirect_to teoricos_path
  end

  def create
    @teoricosresultado = Teoricosresultado.new(params[:teoricosresultado])
    if @teoricosresultado.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit_teoricosresultado_path(@teoricosresultado)
    else
      render :action => "teoricosresultado_form"
     end
  end

  def update
    @teoricosresultado = Teoricosresultado.find(params[:id])
    if @teoricosresultado.update_attributes(params[:teoricosresultado])
      flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit_teoricosresultado_path(@teoricosresultado)
    else
      @teoricosresultadostramite = Teoricosresultadostramite.new
      @teoricosresultadosclase = Teoricosresultadosclase.new
      @teorico = Teorico.new
      render :action => "teoricosresultado_form"
    end
    rescue
      redirect_to edit_teoricosresultado_path(@teoricosresultado)
  end

  def destroy
    @teoricosresultado = Teoricosresultado.find(params[:id])
    @teoricosresultado.destroy
    respond_to do |format|
      format.html { redirect_to(teoricosresultados_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['crearfactura','index','iniciarteorico'].include?(action_name)
      "basico"
    else
      "basico"
    end
  end
end
