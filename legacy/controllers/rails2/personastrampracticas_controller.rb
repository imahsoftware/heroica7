class PersonastrampracticasController < ApplicationController
  before_filter :require_user

  layout :determine_layout

  def edit
    @personastrampractica = Personastrampractica.find(params[:id])
    respond_to do |format|
      format.html { render :action => "personastrampractica_form" }
    end
  end

  def create
    @personastrampractica = Personastrampractica.new(params[:personastrampractica])
    @personastrampractica.user_id = is_admin
    if @personastrampractica.save
      flash[:notice] = "Evaluación Creado con Exito."
      redirect_to edit_personastrampractica_path(@personastrampractica)
    else
      render :action => "personastrampractica_form"
    end
  end

  def update
    @personastrampractica = Personastrampractica.find(params[:id])
    @personastrampractica.user_id = is_admin
    if @personastrampractica.update_attributes(params[:personastrampractica])
      flash[:notice] = "Evaluación Actualizado con Exito."
      redirect_to edit_personastrampractica_path(@personastrampractica)
    else
      render :action => "personastrampractica_form"
    end
  rescue
    redirect_to edit_personastrampractica_path(@personastrampractica)
  end

  def destroy
    @personastrampractica = Persona.find(params[:id])
    @personastrampractica.destroy
    respond_to do |format|
      format.html { redirect_to(personastrampracticas_url) }
      format.xml  { head :ok }
    end
  end

  def calcularvalor
    pvr0  = params[:pvr0].to_s  # Categoria
    pvr1  = params[:pvr1].to_s  # Campo
    pvr2  = params[:pvr2].to_f  # Dato
    if pvr0 == 'inspeva'
      dato = (20 * pvr2.to_f)/100
    elsif pvr0 == 'desteva' or  pvr0 == 'compeva'
      dato = (40 * pvr2.to_f)/100
    end
    render :update do |page|
      if pvr0 == 'inspeva'
        page["personastrampractica_inspcal_#{pvr1}"][:value] = dato
      elsif pvr0 == 'desteva'
        page["personastrampractica_destcal_#{pvr1}"][:value] = dato
      elsif pvr0 == 'compeva'
        page["personastrampractica_compcal_#{pvr1}"][:value] = dato
      end
    end
  end

  private
  def determine_layout
    if ['new2','create2','show','edit2','update2','informepersonastrampractica','verinfo'].include?(action_name)
      "new2"
    elsif ['informepersona','informesiet'].include?(action_name)
      "excel"
    else
      "informes"
    end
  end
end
