class PersonastramitesController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @personastramites = persona.personastramites.all
  end

  def registroclase
    @personastramite = Personastramite.find(params[:id])
  end

  def diploma
    @personastramite = Personastramite.find(params[:id])
    @nombre = params[:nombredip]
  end

  def registrosolicitud
    @personastramite = Personastramite.find(params[:id])
  end

  def acuerdocomercial
    @personastramite = Personastramite.find(params[:id])
  end

  def teorico
    @personastramite = Personastramite.find(params[:id])
    if Teorico.exists?(["persona_id = #{@personastramite.persona_id} and categoria_id = #{@personastramite.categoria_id} and estado = 'PENDIENTE'"])
      flash[:teorico] = "Ya tiene un examen teorico programado. Verifique!!!"
    else
      @teorico = Teorico.new
      @teorico.persona_id = @personastramite.persona_id
      @teorico.user_id = is_admin
      @teorico.categoria_id = @personastramite.categoria_id
      @teorico.estado = 'PENDIENTE'
      @teorico.save
      flash[:teorico] = "Examen teorico programado con exito"
    end
  end

  def edit
    @personastramite  = Personastramite.find(params[:id], :include => "persona")
    @persona  = @personastramite.persona
    respond_to do |format|
      format.js { render :action => "edit_personastramite" }
    end
  end

  def crearfactura
    if Personastramite.exists?(['id = ? and factura_id is null',params[:personastramite_id]])
      @personastramite = Personastramite.find(params[:personastramite_id])
      nrofactura = is_factura
      # Crea la Factura
      factura = Factura.new
      factura.persona_id = params[:persona_id]
      factura.personastramite_id = params[:personastramite_id]
      factura.tipostramite_id = @personastramite.tipostramite_id
      factura.categoria_id = @personastramite.categoria_id
      factura.nro_factura = nrofactura
      factura.user_id = is_admin
      factura.estado = 'P'
      factura.save
      last_id = Factura.maximum('id')
      valortotalfact = 0
      # Crea la det_factura
      @cobrostramites = Cobrostramite.find(:all, :conditions=>["tipostramite_id = ? and categoria_id = ?",params[:tipostramite_id], params[:categoria_id]])
      @cobrostramites.each do |cobrostramite|
        detallesfactura = Detallesfactura.new
        detallesfactura.factura_id = last_id
        detallesfactura.tipostramite_id = cobrostramite.tipostramite_id
        detallesfactura.categoria_id = cobrostramite.categoria_id
        detallesfactura.concepto_id = cobrostramite.concepto_id
        detallesfactura.valor = Concepto.find(cobrostramite.concepto_id).valor
        valortotalfact = valortotalfact + Concepto.find(cobrostramite.concepto_id).valor
        detallesfactura.user_id = is_admin
        detallesfactura.save
      end
      ActiveRecord::Base.connection.execute(
            "update personastramites set factura_id = #{last_id}
             where  id = #{params[:personastramite_id]}")
      ActiveRecord::Base.connection.execute(
            "update facturas set valor = #{valortotalfact}
             where  id = #{last_id}")
      flash[:factura] = "Factura Nro. #{nrofactura} Creada con exito."
    else
      flash[:factura] = "Este tramite ya fue facturado."
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @personastramite = Personastramite.new(params[:personastramite])
    @personastramite.user_id = is_admin
    if @personastramite.valid?
      @persona.personastramites << @personastramite
      @persona.save
      @personastramite = Personastramite.new
      flash[:personastramite] = "Creado con exito"
    else
      flash[:personastramite] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personastramites" }
    end
  end

  def update
    @personastramite        = Personastramite.new
    personastramite         = Personastramite.find(params[:id])
    personastramite.user_actualiza = is_admin
    @persona        = personastramite.persona
    ok = personastramite.update_attributes(params[:personastramite])
    if ok == true
      flash[:personastramite] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "personastramites" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    personastramite   = Personastramite.find(params[:id])
    @persona  = personastramite.persona
    @personastramite  = Personastramite.new
    personastramite.respaldo(is_admin)
    personastramite.destroy
    flash[:personastramite] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personastramites" }
    end
  end

  def practica
    @personastramite = Personastramite.find(params[:id])
    if Personastrapractica.exists?(["personastramite_id = #{@personastramite.id}"]) == true
      pra = Personastrapractica.find(:first, :conditions=>["personastramite_id = #{@personastramite.id}"])
      redirect_to edit_personastrapractica_path(pra.id)
    else
      pra = Personastrapractica.new
      pra.personastramite_id = @personastramite.id
      pra.user_id = is_admin
      pra.save
      redirect_to edit_personastrapractica_path(pra.id)
    end
  end

  def practicam
    @personastramite = Personastramite.find(params[:id])
    if Personastrampractica.exists?(["personastramite_id = #{@personastramite.id}"]) == true
      pra = Personastrampractica.find(:first, :conditions=>["personastramite_id = #{@personastramite.id}"])
      redirect_to edit_personastrampractica_path(pra.id)
    else
      pra = Personastrampractica.new
      pra.personastramite_id = @personastramite.id
      pra.user_id = is_admin
      pra.save
      redirect_to edit_personastrampractica_path(pra.id)
    end
  end

  private
  def determine_layout
    if ['crearfactura','teorico'].include?(action_name)
      "basico"
    elsif ['registroclase','registrosolicitud'].include?(action_name)
      "informes"
    elsif ['diploma','acuerdocomercial'].include?(action_name)
      "cartas"
    else
      "application"
    end
  end
end
