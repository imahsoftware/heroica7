class PersonastrapracticasController < ApplicationController
  before_filter :require_user

  layout :determine_layout

  def edit
    @personastrapractica = Personastrapractica.find(params[:id])
    respond_to do |format|
      format.html { render :action => "personastrapractica_form" }
    end
  end

  def create
    @personastrapractica = Personastrapractica.new(params[:personastrapractica])
    @personastrapractica.user_id = is_admin
    if @personastrapractica.save
      flash[:notice] = "Evaluación Creado con Exito."
      redirect_to edit_personastrapractica_path(@personastrapractica)
    else
      render :action => "personastrapractica_form"
    end
  end

  def update
    @personastrapractica = Personastrapractica.find(params[:id])
    @personastrapractica.user_id = is_admin
    if @personastrapractica.update_attributes(params[:personastrapractica])
      flash[:notice] = "Evaluación Actualizado con Exito."
      redirect_to edit_personastrapractica_path(@personastrapractica)
    else
      render :action => "personastrapractica_form"
    end
  rescue
    redirect_to edit_personastrapractica_path(@personastrapractica)
  end

  def destroy
    @personastrapractica = Persona.find(params[:id])
    @personastrapractica.destroy
    respond_to do |format|
      format.html { redirect_to(personastrapracticas_url) }
      format.xml  { head :ok }
    end
  end

  def calcularvalor
    pvr0  = params[:pvr0].to_s  # Categoria
    pvr1  = params[:pvr1].to_s  # Campo
    pvr2  = params[:pvr2].to_f  # Dato
    if pvr0 == 'inspeva'
       dato = (20 * pvr2.to_f)/100
    elsif pvr0 == 'desteva' or pvr0 == 'compeva'
      dato = (40 * pvr2.to_f)/100
    end
    render :update do |page|
      if pvr0 == 'inspeva'
        page["personastrapractica_inspcal_#{pvr1}"][:value] = dato
      elsif pvr0 == 'desteva'
        page["personastrapractica_destcal_#{pvr1}"][:value] = dato
      elsif pvr0 == 'compeva'
        page["personastrapractica_compcal_#{pvr1}"][:value] = dato
      end
    end
  end

  private
  def determine_layout
    if ['new2','create2','show','edit2','update2','informepersonastrapractica','verinfo'].include?(action_name)
      "new2"
    elsif ['informepersona','informesiet'].include?(action_name)
      "excel"
    else
      "informes"
    end
  end
end
