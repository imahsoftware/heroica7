class PersonasclasesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @personasclases = persona.personasclases.all
  end

 def edit
    @personasclase  = Personasclase.find(params[:id], :include => "persona")
    @persona  = @personasclase.persona
    respond_to do |format|
      format.js { render :action => "edit_personasclase" }
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @personasclase = Personasclase.new(params[:personasclase])
    @personasclase.user_id = is_admin
    if @personasclase.valid?
      @persona.personasclases << @personasclase
      @persona.save
      @personasclase = Personasclase.new
      flash[:personasclase] = "Creado con exito"
    else
      flash[:personasclase] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personasclases" }
    end
  end

  def update
    @personasclase        = Personasclase.new
    personasclase         = Personasclase.find(params[:id])
    params[:personasclase][:user_actualiza] = is_admin
    @persona        = personasclase.persona
    ok = personasclase.update_attributes(params[:personasclase])
    if ok == true
      flash[:personasclase] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "personasclases" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    personasclase   = Personasclase.find(params[:id])
    @persona  = personasclase.persona
    @personasclase  = Personasclase.new
    personasclase.destroy
    flash[:personasclase] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personasclases" }
    end
  end

  private
  def determine_layout
    if ['crearfactura'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end
