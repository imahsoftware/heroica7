class PersonasController < ApplicationController

  before_filter :require_user

  layout :determine_layout

  def index
    @personas = Persona.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personas }
    end
  end

  def buscar
    #if params[:buscarident].to_s == nil and params[:buscarnombre]
    @personas      = Persona.buscar(params[:buscarident], params[:buscarnombre])
    if @personas.count == 1
      redirect_to edit_persona_path(@personas)
    elsif @personas.count == 0
      flash[:notice] = "No hay informacion de la busqueda"
      redirect_to busqueda_personas_path
    end
  rescue
    flash[:notice] = "Debe digitar datos para la consulta"
    redirect_to busqueda_personas_path
  end


  def new
    @persona = Persona.new
    render :action => "persona_form"
  end

  def listar
      #@personas = Persona.find(:all, :conditions => [' identificacion =  ?', "#{params[:search]}"])
      @personas = Persona.find(:all, :conditions => [' autobuscar LIKE ?', "%#{params[:search]}%"])
  end

  def edit
    @persona = Persona.find(params[:id])
    @personastramite = Personastramite.new
    @personasclase = Personasclase.new
    @teorico = Teorico.new
    respond_to do |format|
      format.html { render :action => "persona_form" }
    end
  end

  def create
    @persona = Persona.new(params[:persona])
    @persona.user_id = is_admin
    if @persona.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit_persona_path(@persona)
    else
      render :action => "persona_form"
     end
  end

  def update
    @persona = Persona.find(params[:id])
    @persona.user_id = is_admin
    if @persona.update_attributes(params[:persona])
     flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit_persona_path(@persona)
    else
      @personastramite = Personastramite.new
      @personasclase = Personasclase.new
      @teorico = Teorico.new
      render :action => "persona_form"
    end
    rescue
      redirect_to edit_persona_path(@persona)
  end

  def destroy
    @persona = Persona.find(params[:id])
    @persona.destroy
    respond_to do |format|
      format.html { redirect_to(personas_url) }
      format.xml  { head :ok }
    end
  end

  def informesiet
    if params[:ubicacion][:inicial].to_s == nil and params[:ubicacion][:final].to_s == nil
      flash[:notice] = "Debe digitar datos para la consulta"
      redirect_to busqueda_personas_path
    else
      var =  params[:ubicacion][:categoria_id].to_i
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="Heroica_SIET_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      if var == 0
        @personas = Persona.find(:all, :conditions=>["date(created_at) between '#{params[:ubicacion][:inicial].to_date}' and '#{params[:ubicacion][:final].to_date}'"], :order=>'created_at asc')
      else
        @personas = Persona.find(:all, :conditions=>["date(created_at) between '#{params[:ubicacion][:inicial].to_date}' and '#{params[:ubicacion][:final].to_date}' and id in (select persona_id from personastramites where categoria_id = #{params[:ubicacion][:categoria_id].to_i})"], :order=>'created_at asc')
      end
    end
  end

  def informeper
    if params[:ubicacion][:inicial1].to_s == nil and params[:ubicacion][:final1].to_s == nil
      flash[:notice] = "Debe digitar datos para la consulta"
      redirect_to busqueda_personas_path
    else
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="Heroica_HV_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @personas = Persona.find(:all, :conditions=>["date(created_at) between '#{params[:ubicacion][:inicial1].to_date}' and '#{params[:ubicacion][:final1].to_date}'"], :order=>'created_at asc')
    end
  end

  private
  def determine_layout
    if ['new2','create2','show','edit2','update2','informepersona','verinfo'].include?(action_name)
      "new2"
    elsif ['informepersona','informesiet','informeper'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end
