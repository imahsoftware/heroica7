# frozen_string_literal: true

class PersonasController < ApplicationController
  before_action :set_persona, only: [:edit, :update, :destroy]
  before_action :set_etapa, only: [:edit, :update]

  layout :set_layout
  #before_action :checkaccess

  def checkaccess
    return is_permit('personas')
  end

  # GET /personas/busqueda
  def busqueda
    # Pantalla principal de búsqueda + accesos a informes
  end

  # GET /personas/buscar  — búsqueda por identificación y/o nombre
  def buscar
    resultados = Persona.buscar(params[:buscarident], params[:buscarnombre])

    # Redirige directo al edit solo cuando la búsqueda es por identificación exacta
    if params[:buscarident].present? && params[:buscarnombre].blank? && resultados.count == 1
      redirect_to edit_persona_path(resultados.first, etapa: 'A') and return
    end

    if resultados.count == 0
      flash[:notice] = 'No hay informacion de la busqueda'
      redirect_to busqueda_personas_path and return
    end

    @personas       = resultados.paginate(page: params[:page], per_page: 20)
    @total_personas = resultados.count
  rescue StandardError
    flash[:notice] = 'Debe digitar datos para la consulta'
    redirect_to busqueda_personas_path
  end

  # GET /personas/listar  — autocomplete AJAX
  def listar
    @personas = Persona.where('autobuscar LIKE ?', "%#{params[:search]}%")
    render layout: false
  end

  # GET /personas/new
  def new
    @persona = Persona.new
  end

  # GET /personas/:id/edit
  def edit
    @personastramite = Personastramite.new
    @personasclase   = Personasclase.new
    @teorico         = Teorico.new
  end

  # POST /personas
  def create
    @persona = Persona.new(persona_params)
    @persona.user_id = is_admin
    if @persona.save
      flash[:notice] = 'Usuario Creado con Exito.'
      redirect_to edit_persona_path(@persona, etapa: 'A')
    else
      render :new
    end
  end

  # PATCH/PUT /personas/:id
  def update
    @persona.user_id = is_admin
    if @persona.update(persona_params)
      flash[:notice] = 'Usuario Actualizado con Exito.'
      redirect_to edit_persona_path(@persona, etapa: @etapa)
    else
      @personastramite = Personastramite.new
      @personasclase   = Personasclase.new
      @teorico         = Teorico.new
      render :edit
    end
  rescue StandardError
    redirect_to edit_persona_path(@persona, etapa: (@etapa.presence || 'A'))
  end

  # DELETE /personas/:id
  def destroy
    @persona.destroy
    respond_to do |format|
      format.html { redirect_to busqueda_personas_path }
      format.xml  { head :ok }
    end
  end

  # GET /personas/informesiet  — exporta Excel SIET
  def informesiet
    if params[:ubicacion].blank? ||
       params[:ubicacion][:inicial].blank? ||
       params[:ubicacion][:final].blank?
      flash[:notice] = 'Debe digitar datos para la consulta'
      redirect_to busqueda_personas_path and return
    end

    set_excel_headers("Heroica_SIET_#{Time.now.strftime('%Y%m%d_%X')}.xls")

    var = params[:ubicacion][:categoria_id].to_i
    fecha_ini = params[:ubicacion][:inicial].to_date
    fecha_fin = params[:ubicacion][:final].to_date

    @personas = if var.zero?
                  Persona.where('DATE(created_at) BETWEEN ? AND ?', fecha_ini, fecha_fin)
                         .order(:created_at)
                else
                  Persona.where(
                    'DATE(created_at) BETWEEN ? AND ? AND id IN (SELECT persona_id FROM personastramites WHERE categoria_id = ?)',
                    fecha_ini, fecha_fin, var
                  ).order(:created_at)
                end
  end

  # GET /personas/informeper  — exporta Excel datos básicos
  def informeper
    if params[:ubicacion].blank? ||
       params[:ubicacion][:inicial1].blank? ||
       params[:ubicacion][:final1].blank?
      flash[:notice] = 'Debe digitar datos para la consulta'
      redirect_to busqueda_personas_path and return
    end

    set_excel_headers("Heroica_HV_#{Time.now.strftime('%Y%m%d_%X')}.xls")

    @personas = Persona.where(
      'DATE(created_at) BETWEEN ? AND ?',
      params[:ubicacion][:inicial1].to_date,
      params[:ubicacion][:final1].to_date
    ).order(:created_at)
  end

  private

  def set_persona
    @persona = Persona.find(params[:id])
  end

  def set_etapa
    @etapa = params[:etapa].presence || 'A'
    @etapa = 'A' if @persona&.new_record? && @etapa != 'A'
  end

  def persona_params
    params.require(:persona).permit!
  end

  def set_layout
    if %w[informesiet informeper].include?(action_name)
      'excel'
    else
      'application_personas'
    end
  end

  def set_excel_headers(filename)
    response.headers['Content-Type']        = 'application/vnd.ms-excel'
    response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
    response.headers['Cache-Control']       = 'max-age=0'
    response.headers['pragma']              = 'public'
  end
end
