# frozen_string_literal: true

class MenusController < ApplicationController
  layout :set_layout

  # before_action :verificardatos, if: :user_signed_in?

  before_action :validatesession

  def menu; end

  def verificardatos
    if User.find(is_admin).sign_in_count == 1
      redirect_to edit_user_registration_path
      flash[:warning] = 'Por favor actualiza tus datos'
    end
  end

  def control_firma_digital
    cf = Controlformato.find(params[:controlfirma_id])
    persona = Persona.find(params[:id_registro])
    @controlador = cf.controlador
    @url = cf.url
    @modelo = cf.modelo
    @tipo_documento = cf.tipo_documento
    @idRegistro = params[:id_registro]
    @user_firma = params[:user_firma]
    @portafolio = is_portafolio
    @control = Controlfirma.where(controlador: @controlador, id_registro: @idRegistro, estado: 'PENDIENTE',
                                  url: @url, tipo_documento: @tipo_documento, modelo: @modelo, portafolio_id: @portafolio,
                                  user_firma: @user_firma, controlformato_id: cf.id).first_or_create
    redirect_to edit_persona_path(persona)
=begin
    respond_to do |format|
      flash[:notice] = ""
      format.js { render inline: "location.reload();" }
    end
=end
  end

  def aceptartratamiento
    @user = User.find(is_admin)
    @user.autotratamiento_fecha = Time.now
    @user.autotratamiento_ip = @user.current_sign_in_ip
    @user.save(validate: false)
    redirect_to root_path
  end

  def validatesession
    if current_user
      idc = cookies.signed[:user_id]
      usernamec = cookies.signed[:username]
      if (idc.to_s == '') && (usernamec.to_s == '')
        redirect_to logout_path
      elsif (idc != current_user.id) && (usernamec != current_user.username)
        redirect_to logout_path
      end
    end
  end

  def captura_rostro
    @persona = Persona.find(current_user.persona_id)
    if @persona.personasimagenes.where("descripcion = 'FOTO'").present?
      @persona.personasimagenes.where("descripcion = 'FOTO'").delete_all
    end
    data = params[:image][:image_data]
    image_data = Base64.decode64(data)
    new_file = File.new("public/webcam/rostro_#{@persona.identificacion}.png", 'wb')
    new_file.write(image_data)
    file = File.open(new_file, 'rb')
    @persona.foto = 'OK'
    @persona.save(validate: false)
    @personasimagen = Personasimagen.new
    @personasimagen.persona_id = @persona.id
    @personasimagen.user_id = is_admin
    @personasimagen.descripcion = "FOTO"
    @personasimagen.documentos = file
    @personasimagen.save(validate: false)
  end

  def index


  end

  def call
    # @call = "http://google.com"
  end

  def searchall
    redirect_to edit_persona_path(params[:persona_id], etapa: 'A')
  end

  def autocomplete_persona_nombre
    term = params[:term]
    personas = Persona.where('upper(autobuscar) LIKE ? or identificacion = ? or upper(celular) LIKE ?', "%#{replacespace(term.upcase)}%", "#{term.to_i}", "%#{replacespace(term.upcase)}%").limit(10).order(:autobuscar).all
    render :json => personas.map { |persona| { id: persona.id, label: persona.search_input, value: persona.search_input } }
  end

  private

  def set_layout
    if ['call'].include?(action_name)
      'call'
    elsif is_persona
      'application'
    elsif is_estudiante
      'application_estudiante'
    else
      'application_admin'
    end
  end
end
