# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require 'digest'

  helper :all

  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: [:validatesession, :formulario_validacion]
  before_action :enforce_password_change, if: :user_signed_in?
  before_action :validatesession
  # before_action :soportespendientes, :soportespendientescant, :agendasmenus
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :allow_iframe_requests

  def validatesession
    if current_user.nil?
      cookies.delete(:_session_id)
      cookies.delete(:user_id)
      cookies.delete(:username)
    end
  end

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

  def soportespendientes
    @soportesp = Soporte.where("solucionado = 'PE'").limit(5).order('id desc')
  end

  def soportespendientescant
    @soportespcant = Soporte.where("solucionado = 'PE'").count
  end

  def agendasmenus
    @noticias = Noticia.where(active: true).order(updated_at: :desc)
    @agendas = begin
      Agenda.where("user_id = #{is_admin} and estado ='PENDIENTE' and trunc(fecha) <= (trunc(sysdate) + (15 / 1440))").order(fecha: :asc)
    rescue StandardError
      nil
    end
    @agendasmenu = begin
      Agenda.where("user_id = #{is_admin} and portafolio_id = #{is_portafolio} and estado ='PENDIENTE' and trunc(fecha) <= (trunc(sysdate) + 30)").order('fecha asc')
    rescue StandardError
      nil
    end
  end

  # ── Usuario admin activo (memo por request) ───────────────────────────────
  # is_admin / is_portafolio: sin reconsultar current_user ni portafolio_id.
  # current_admin_user: un solo User.find con portafolio precargado.
  # En vistas/controladores usar current_admin_user, no User.find(is_admin).
  helper_method :current_admin_user, :is_admin, :is_portafolio

  def is_admin
    return @is_admin_id if instance_variable_defined?(:@is_admin_id)

    @is_admin_id = current_user.user2_id.presence || current_user.id
  end

  def is_portafolio
    return @is_portafolio_id if instance_variable_defined?(:@is_portafolio_id)
    return nil unless user_signed_in?

    @is_portafolio_id = current_admin_user.portafolio_id
  end

  def current_admin_user
    @current_admin_user ||= User.includes(:portafolio).find(is_admin)
  end

  helper_method :is_tipocliente
  def is_tipocliente
    current_user.tipocliente
  end

  helper_method :is_cohorte
  def is_cohorte
    current_admin_user.cohorte_id
  end

  helper_method :is_portafolioname
  def is_portafolioname
    current_admin_user.portafolio.nombrecorto
  rescue StandardError
    nil
  end

  helper_method :is_usuario
  def is_usuario
    current_admin_user.nombre
  end

  helper_method :is_nextmandamiento

  def is_nextmandamiento
    begin
      lastconsecutivo = Personascoactivo.maximum('nro_radicado')
    rescue StandardError
      lastconsecutivo = 0
    end
    if lastconsecutivo.to_i.zero?
      10001
    else
      10001 + 1
    end
  end

  helper_method :quita_acento1
  def quita_acento1(dato)
    valor = dato.gsub('Á', 'A')
    valor = valor.gsub('É', 'E')
    valor = valor.gsub('Í', 'I')
    valor = valor.gsub('Ó', 'O')
    valor = valor.gsub('Ú', 'U')
    valor = valor.gsub('Ñ', 'N')
    valor.to_s
  end

  helper_method :permiso
  # Evento debe ser A:Actualiza, E:Elimina, C:Crea
  def permiso(objeto, evento)
    objetoid = Objeto.find_by_descripcion(objeto)
    if objetoid.to_s != ''
      userspermisos = Userspermiso.where('user_id = ? and objeto_id = ?', is_admin, objetoid)
      userspermisos.each do |data|
        case evento
        when 'A'
          return data.actualiza
        when 'E'
          return data.elimina
        when 'C'
          return data.crea
        end
      end
    end
  end

  helper_method :descmes
  def descmes(mes)
    case mes.to_s
    when '1'
      'ENERO'
    when '2'
      'FEBRERO'
    when '3'
      'MARZO'
    when '4'
      'ABRIL'
    when '5'
      'MAYO'
    when '6'
      'JUNIO'
    when '7'
      'JULIO'
    when '8'
      'AGOSTO'
    when '9'
      'SEPTIEMBRE'
    when '10'
      'OCTUBRE'
    when '11'
      'NOVIEMBRE'
    when '12'
      'DICIEMBRE'
    else
      '------'
    end
  end

  helper_method :descmesmin
  def descmesmin(mes)
    case mes.to_i
    when 1
      'Enero'
    when 2
      'Febrero'
    when 3
      'Marzo'
    when 4
      'Abril'
    when 5
      'Mayo'
    when 6
      'Junio'
    when 7
      'Julio'
    when 8
      'Agosto'
    when 9
      'Septiembre'
    when 10
      'Octubre'
    when 11
      'Noviembre'
    when 12
      'Diciembre'
    else
      '------'
    end
  end

  helper_method :fechaprog
  def fechaprog(fechainicial, dias)
    return nil if fechainicial.to_s.blank? || dias.to_s.blank?

    fechawork      = fechainicial.to_date
    fechaprog_date = fechawork + dias.to_i

    # Contar festivos entre fechawork y fechaprog_date (comparación SQL con Date objects)
    cantidad = Festivo.where('fecha >= ? AND fecha <= ?',
                             fechawork.strftime('%Y-%m-%d'),
                             fechaprog_date.strftime('%Y-%m-%d')).count

    fechaprogramacion = cantidad.positive? ? fechaprog_date + cantidad : fechaprog_date

    # Avanzar si cae en festivo
    loop do
      break unless Festivo.where('fecha = ?', fechaprogramacion.strftime('%Y-%m-%d')).exists?
      fechaprogramacion += 1
    end

    fechaprogramacion
  end

  helper_method :fechaprogx
  def fechaprogx(fechainicial, dias)
    if (fechainicial.to_s != '') && (dias.to_s != '')
      @objetos = Objeto.find_by_sql(["select fnc_fecha('#{fechainicial.to_date}',#{dias.to_i}) fch from dual"])
      @objetos.each do |objeto|
        return objeto.fch
      end
    end
  end

  helper_method :diferenciadias
  def diferenciadias(fechasolicitud)
    if fechasolicitud.to_s != ''
      fechawork = fechasolicitud.to_time
      festivos = Festivo.find_by_sql("select trunc(sysdate) - to_date('#{fechasolicitud}','dd/mm/yyyy') resta from dual")
      dias = 0
      festivos.each do |festivo|
        dias = festivo.resta
      end
      cantidad = Festivo.where('fecha between ? and trunc(sysdate)', fechawork).count
      dias -= cantidad if cantidad.positive?
    end
    if dias.positive?
      dias
    else
      (dias * -1)
    end
  end

  helper_method :is_fechamas
  def is_fechamas(fch1)
    Objeto.find_by_sql("select fnc_fechamasmes('#{fch1.to_date}',1) fch from dual")[0].fch
  end

  helper_method :namedate
  def namedate(fecha)
    day_names = %w[Domingo Lunes Martes Miercoles Jueves Viernes Sábado]
    month_names = ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
    dia = fecha.strftime('%w').to_i
    ndia = day_names[dia]
    mes = fecha.strftime('%m').to_i
    nmes = month_names[mes]
    "#{ndia} #{fecha.strftime('%d')} de #{nmes} de #{fecha.strftime('%Y')}"
  end

  helper_method :namedate2
  def namedate2(fecha)
    day_names = %w[domingo lunes martes miércoles jueves viernes sábado]
    month_names = ['', 'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']
    dia = fecha.strftime('%w').to_i
    ndia = day_names[dia]
    mes = fecha.strftime('%m').to_i
    nmes = month_names[mes]
    "#{ndia} #{fecha.strftime('%d')} de #{nmes} de #{fecha.strftime('%Y')}"
  end

  def helpers
    ActionController::Base.helpers
  end

  helper_method :camponumericoinforme
  def camponumericoinforme(campo)
    campo1 = campo.to_f
    if campo1.zero?
      campo
    else
      helpers.number_to_currency(campo, precision: 0, unit: '', delimiter: '.')
      # campo1 = number_to_currency( campo.to_i, :precision => 0, :unit=>"", :delimiter =>".")
    end
  end

  helper_method :replaceenter
  def replaceenter(campo)
    b = campo.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b = b.sub("\n", '<br/>')
    b.sub("\n", '<br/>')
  end
  #
  #   rescue_from CanCan::AccessDenied do |exception|
  #    flash[:warning] = "Usted no tiene acceso a este Modulo"
  #    redirect_to menus_url
  #  end

  helper_method :is_host
  def is_host
    Parametro.find(16).valor.to_s
  end

  helper_method :numero_a_palabras
  def numero_a_palabras(numero)
    de_tres_en_tres = numero.to_i.to_s.reverse.scan(/\d{1,3}/).map { |n| n.reverse.to_i }

    millones = [
      { true => nil, false => nil },
      { true => 'MILLÓN', false => 'MILLONES' },
      { true => 'BILLÓN', false => 'BILLONES' },
      { true => 'TRILLÓN', false => 'TRILLONES' }
    ]

    centena_anterior = 0
    contador = -1
    palabras = de_tres_en_tres.map do |numeros|
      contador += 1
      if contador.even?
        centena_anterior = numeros
        [centena_a_palabras(numeros), millones[contador / 2][numeros == 1]].compact if numeros.positive?
      elsif centena_anterior.zero?
        [centena_a_palabras(numeros), 'MIL', millones[contador / 2][false]].compact if numeros.positive?
      elsif numeros.positive?
        [centena_a_palabras(numeros), 'MIL']
      end
    end

    palabras.compact.reverse.join(' ')
  end

  helper_method :centena_a_palabras
  def centena_a_palabras(numero)
    especiales = {
      11 => 'ONCE', 12 => 'DOCE', 13 => 'TRECE', 14 => 'CATORCE', 15 => 'QUINCE',
      10 => 'DIEZ', 20 => 'VEINTE', 100 => 'CIEN'
    }
    return especiales[numero] if especiales.key?(numero)

    centenas = [nil, 'CIENTO', 'DOSCIENTOS', 'TRESCIENTOS', 'CUATROCIENTOS', 'QUINIENTOS', 'SEISCIENTOS', 'SETECIENTOS', 'OCHOCIENTOS', 'NOVECIENTOS']
    decenas = [nil, 'DIECI', 'VEINTI', 'TREINTA', 'CUARENTA', 'CINCUENTA', 'SESENTA', 'SETENTA', 'OCHENTA', 'NOVENTA']
    unidades = [nil, 'UN', 'DOS', 'TRES', 'CUATRO', 'CINCO', 'SEIS', 'SIETE', 'OCHO', 'NUEVE']

    centena, decena, unidad = numero.to_s.rjust(3, '0').scan(/\d/).map(&:to_i)

    palabras = []
    palabras << centenas[centena]

    if especiales.key?(decena * 10 + unidad)
      palabras << especiales[decena * 10 + unidad]
    else
      tmp = "#{decenas[decena]}#{' Y ' if decena > 2 && unidad.positive?}#{unidades[unidad]}"
      palabras << (tmp.blank? ? nil : tmp)
    end
    palabras.compact.join(' ')
  end

  helper_method :is_trigger_mej
  def is_trigger_mej(id, userid, blo, tipo)
    mej = Mejoramientosactualizacion.new
    mej.mejoramiento_id = id
    mej.bloque = blo
    mej.tipo_transaccion = tipo
    mej.user_id = userid
    mej.save
  end

  helper_method :is_trigger_tit
  def is_trigger_tit(id, userid, blo, tipo)
    mej = Titulacionesactualizacion.new
    mej.titulacion_id = id
    mej.bloque = blo
    mej.tipo_transaccion = tipo
    mej.user_id = userid
    mej.save
  end

  helper_method :is_quita_acento
  def is_quita_acento(dato)
    valor = begin
      dato.gsub('Á', 'A')
    rescue StandardError
      nil
    end
    valor = begin
      valor.gsub('É', 'E')
    rescue StandardError
      nil
    end
    valor = begin
      valor.gsub('Í', 'I')
    rescue StandardError
      nil
    end
    valor = begin
      valor.gsub('Ó', 'O')
    rescue StandardError
      nil
    end
    valor = begin
      valor.gsub('Ú', 'U')
    rescue StandardError
      nil
    end
    valor = begin
      valor.gsub('Ñ', 'N')
    rescue StandardError
      nil
    end
    valor.to_s
  end

  helper_method :is_fechahoy
  def is_fechahoy
    @fchsytem = ''
    @objetos = if Parametro.find(4).valor.to_s == 'PRUEBA'
                 Plan.find_by_sql(['select fecha from param'])
               else
                 Plan.find_by_sql(['select trunc(sysdate) fecha from dual'])
               end
    @objetos.each do |objeto|
      @fchsytem = begin
        objeto.fecha
      rescue StandardError
        nil
      end
    end
    @fchsytem
  end

  helper_method :is_select_tiposestado
  def is_select_tiposestado
    @tiposestados = Tiposestado.where('estado = ?', 'ACTIVO').order(:descripcion)
    @tiposestados
  end

  helper_method :is_select_estado
  def is_select_estado
    @estados = Estado.where(["id in (select estado_id from estadosportafolios where portafolio_id = #{is_portafolio})"]).order(:descripcion)
    @estados
  end

  helper_method :is_help_lastcopermisonse
  def is_help_lastconse
    # logger.error("Ingresoooo....")
    begin
      lastconsecutivo = Personasobligacion.where("fondo = 'ENLAZAMUNDOS'").maximum('nro_obligacion')
      # logger.error("Valor lastId...."+lastid.to_s)
      # lastconsecutivo = Personasobligacion.find(lastid).nro_obligacion
    rescue StandardError
      lastconsecutivo = 0
    end
    if lastconsecutivo.to_i.zero?
      20150001
    else
      lastconsecutivo + 1
    end
  end

  helper_method :is_select_oficinaregistro
  def is_select_oficinaregistro
    @oficinas = Oficina.all.order('descripcion')
    @oficinas
  end

  helper_method :is_select_municipio
  def is_select_municipio
    @municipios = Municipio.where("pais = '#{is_pais}'").order('descripcion')
    @municipios
  end

  helper_method :is_select_notaria
  def is_select_notaria
    @notarias = Notaria.all.order('descripcion')
    @notarias
  end

  helper_method :is_convocatoria
  def is_convocatoria
    'N'
  end

  helper_method :is_select_user
  def is_select_user
    @users = User.all.order('nombre')
    @users
  end

  helper_method :is_select_useractivo
  def is_select_useractivo
    @users = User.where(["activo = 'S' and portafolio_id = #{is_portafolio}"]).all.order('nombre')
    @users
  end

  helper_method :is_select_useredupol
  def is_select_useredupol
    @users = User.where(["activo = 'S' and portafolio_id = #{is_portafolio}
                          and id in (select distinct user_id from personasobligaciones where portafolio_id = #{is_portafolio})"]).all.order('nombre')
    @users
  end

  helper_method :is_select_parorigenespago
  def is_select_parorigenespago
    Parorigenespago.where(["portafolio_id = #{is_portafolio}"]).order('descripcion')
  end

  helper_method :is_select_tipodocumento
  def is_select_tipodocumento
    @datos = Tiposdocumento.all.order('id')
    @datos
  end

  helper_method :is_select_cliente
  def is_select_cliente
    @datos = Cliente.where("portafolio_id = #{is_portafolio}").order('nombre')
    @datos
  end

  helper_method :is_select_partiposcartera
  def is_select_partiposcartera
    @datos = Partiposcartera.where(estado: 'ACTIVO').order('cod_cifin')
    @datos
  end

  helper_method :is_select_lineacredito
  def is_select_lineacredito
    @datos = Lineacredito.where("portafolio_id = #{is_portafolio}").order('descripcion')
    @datos
  end

  helper_method :is_select_partiposproducto
  def is_select_partiposproducto
    @datos = Partiposproducto.where(estado: 'ACTIVO').order('cod_cifin')
    @datos
  end

  helper_method :is_addmonths
  def is_addmonths(dtfecha)
    d1 = Parametro.find(1).valor.to_s
    d2 = Parametro.find(2).valor.to_s
    d3 = Parametro.find(3).valor.to_s
    plsql.connection = OCI8.new(d1, d2, d3)
    valor = plsql.fnc_fechamasmes(dtfecha, 1)
    plsql.logoff
  end

  helper_method :is_uvrdia
  def is_uvrdia
    # last_id = Recordacion.maximum('id')
    # dtfecha = Recordacion.find(last_id).fecha
    partasasuvr = Partasasuvr.where('fecha = trunc(sysdate)').first
    partasasuvr.pesos_uvr.to_f
  end

  helper_method :is_uvrdia_dia
  def is_uvrdia_dia(dtfecha)
    partasasuvr = Partasasuvr.where("fecha = '#{dtfecha.strftime('%Y-%m-%d')}'").first
    partasasuvr.pesos_uvr.to_f
  end

  helper_method :is_select_cuenta
  def is_select_cuenta
    @objetos = Cuenta.order('descripcion')
    @objetos
  end

  helper_method :is_factura
  def is_factura
    Factura.find_by_sql('select max(nro_factura) nro from facturas')[0].nro.to_i + 1
  end

  helper_method :facturacero
  def facturacero(campo)
    @facturas = Objeto.find_by_sql("select lpad(#{campo},8,'0') fact from dual")
    @facturas.each do |factura|
      return factura.fact
    end
  end

  helper_method :facturacero6
  def facturacero6(campo)
    @facturas = Objeto.find_by_sql("select lpad(#{campo},6,'0') fact from dual")
    @facturas.each do |factura|
      return factura.fact
    end
  end

  helper_method :replacespace
  def replacespace(campo)
    b = campo.sub(' ', '%%')
    b = b.sub(' ', '%%')
    b = b.sub(' ', '%%')
    b = b.sub(' ', '%%')
    b.sub(' ', '%%')
  end

  helper_method :is_select_pagaduria
  def is_select_pagaduria
    @objetos = Pagaduria.order('nombre')
    @objetos
  end

  helper_method :is_select_cooperativa
  def is_select_cooperativa
    @objetos = Cooperativa.order('nombre')
    @objetos
  end

  helper_method :is_select_inversionista
  def is_select_inversionista
    @objetos = Inversionista.order('nombre')
    @objetos
  end

  helper_method :is_select_razonespago
  def is_select_razonespago
    @objetos = Razonespago.includes(:razonesportafolios).where(razonesportafolios: { portafolio_id: is_portafolio }).order(:descripcion)
    @objetos
  end

  helper_method :is_authport
  def is_authport(port)
    User.exists?(["id = #{is_admin} and portafolio_id in (#{port})"])
  rescue StandardError
    nil
  end

  helper_method :is_garantia
  def is_garantia
    current_admin_user.portafolio.garantia.to_s
  rescue StandardError
    nil
  end

  helper_method :cohorte_metodopago
  def cohorte_metodopago(programa)
    programa.cohorte.forma_pago == 'SI'
  rescue StandardError
  end

  helper_method :is_obligaciones
  def is_obligaciones
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.obligaciones.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_consolidado
  def is_consolidado
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.consolidado.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_credito
  def is_credito
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.credito.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_normalizacion
  def is_normalizacion
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.normalizacion.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_gestionpagaduria
  def is_gestionpagaduria
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.gestionpagaduria.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_gestioncobro
  def is_gestioncobro
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.gestioncobro.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_cobranzajuridica
  def is_cobranzajuridica
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.cobranzajuridica.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_coactivo
  def is_coactivo
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.coactivo.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_digital
  def is_digital
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.digital.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_campanas
  def is_campanas
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.campanas.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_academico
  def is_academico
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.academico.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_giros
  def is_giros
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.giros.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_liquidacionpac
  def is_liquidacionpac
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.liquidacionpac.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_gestionmundial
  def is_gestionmundial
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.gestionmundial.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_gestioncovinoc
  def is_gestioncovinoc
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.gestioncovinoc.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_gestionkfg
  def is_gestionkfg
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.gestionkfg.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_gestiongintac
  def is_gestiongintac
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.gestiongintac.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_helenas
  def is_helenas
    if current_admin_user.geintac.to_s == 'SI'
      'SI'
    else
      begin
        current_admin_user.portafolio.helenas.to_s
      rescue StandardError
        nil
      end
    end
  end

  helper_method :is_nextpagare
  def is_nextpagare
    maxpagar = begin
      Personasacuerdo.where("portafolio_id = #{current_admin_user.portafolio_id} and numero_pagare is not null ").maximum('numero_pagare')
    rescue StandardError
      0
    end
    nextdato = if maxpagar.to_i.zero?
                 1
               else
                 maxpagar + 1
               end
    nextdato.to_s
  end

  helper_method :is_dash
  def is_dash
    if is_portafolio != 10100
      current_admin_user.dashboard.to_s != 'NO'
    else
      true
    end
  end

  helper_method :is_tipoconsulta
  def is_tipoconsulta
    current_admin_user.tipoconsulta.to_s
  end

  helper_method :is_portafoliossucursal
  def is_portafoliossucursal
    current_admin_user.portafoliossucursal_id
  end

  helper_method :is_select_originador
  def is_select_originadors
    @objetos = Portafolioscontrato.where(portafolio_id: is_portafolio).order(:originador).select(:originador).distinct
    @objetos
  end

  helper_method :is_consecutivo
  def is_consecutivo
    @facturas = Objeto.find_by_sql("select fnc_consecutivorecaudo(#{is_portafolio}) vlr from dual")
    @facturas.each do |factura|
      return factura.vlr
    end
  end

  helper_method :is_adminext
  def is_adminext
    current_admin_user.extension.to_s
  end

  helper_method :is_consecutivootrosrecaudo
  def is_consecutivootrosrecaudo
    @facturas = Objeto.find_by_sql("select fnc_consecutivorecaudootros(#{is_portafolio}) vlr from dual")
    @facturas.each do |factura|
      return factura.vlr
    end
  end

  helper_method :is_bloqueo
  def is_bloqueo
    current_admin_user.portafolio.bloqueo.to_s == 'SI'
  end

  helper_method :is_agenda
  def is_agenda
    Agenda.exists?(["user_id = #{is_admin} and estado = 'PENDIENTE' and TO_DATE(fecha, 'YYYY-MM-DD HH24:MI:SS') <= TO_DATE(sysdate, 'YYYY-MM-DD HH24:MI:SS') + (15 / 1440)"]) == true
  end

  helper_method :is_sygma
  def is_sygma
    current_admin_user.geintac.to_s == 'S'
  end

  helper_method :is_supersygma
  def is_supersygma
    current_admin_user.supersygma.to_s == 'YES'
  end

  helper_method :is_edupol
  def is_edupol
    is_portafolio == 10100
  end

  helper_method :is_etapa
  def is_etapa
    current_admin_user.etapa.to_s
  end

  helper_method :is_select_portafolioscuenta
  def is_select_portafolioscuenta
    @objetos = Portafolioscuenta.where(portafolio_id: is_portafolio).order(:cod_cuenta)
    @objetos
  end

  helper_method :is_select_portafolios
  def is_select_portafolios
    @objetos = Portafolio.all
    @objetos
  end

  helper_method :is_auth_c
  def is_auth_c(objeto)
    objetoid = begin
      Objeto.find_by_descripcion(objeto.to_s).id
    rescue StandardError
      0
    end
    if objetoid.to_s != ''
      Userspermiso.exists?(["user_id = ? and objeto_id = ? and crea = 'S'", is_admin, objetoid])
    else
      false
    end
  end

  helper_method :is_auth_e
  def is_auth_e(objeto)
    objetoid = begin
      Objeto.find_by_descripcion(objeto.to_s).id
    rescue StandardError
      0
    end
    if objetoid.to_s != ''
      Userspermiso.exists?(["user_id = ? and objeto_id = ? and elimina = 'S'", is_admin, objetoid])
    else
      false
    end
  end

  helper_method :is_auth_a
  def is_auth_a(objeto)
    objetoid = begin
      Objeto.find_by_descripcion(objeto.to_s).id
    rescue StandardError
      0
    end
    if objetoid.to_s != ''
      Userspermiso.exists?(["user_id = ? and objeto_id = ? and actualiza = 'S'", is_admin, objetoid])
    else
      false
    end
  end

  helper_method :is_permiso
  def is_permiso(permiso)
    permisoid = begin
      Permiso.find_by_descripcion(permiso).id
    rescue StandardError
      0
    end
    return Portafoliospermiso.exists?(['portafolio_id = ? and permiso_id = ?', is_portafolio, permisoid]) if permisoid.to_s != ''
  end

  helper_method :is_gcsconse
  def is_gcsconse
    begin
      lastconsecutivo = Personasobligacion.where('portafolio_id = 10011').maximum('nro_obligacion')
    rescue StandardError
      lastconsecutivo = 0
    end
    if lastconsecutivo.to_i.zero?
      201700001
    else
      (lastconsecutivo.to_i + 1).to_s
    end
  end

  helper_method :is_consecredito2
  def is_consecredito2
    begin
      lastconsecutivo = Personasobligacion.where('portafolio_id = 10018').maximum('nro_obligacion')
    rescue StandardError
      lastconsecutivo = 0
    end
    (lastconsecutivo.to_i + 1).to_s
  end

  helper_method :is_edupolconse
  def is_edupolconse
    is_edupolconseobligacion
  end

  helper_method :is_edupolconseobligacion
  def is_edupolconseobligacion
    nextconsecutivo = begin
      Objeto.find_by_sql(['select CONSOBLEDUPOL_SEQ.nextval cons from dual']).first
    rescue StandardError
      0
    end
    nextconsecutivo.cons.to_s
    # lastconsecutivo = Personasprogrecaudo.maximum('id')
    # nextconsecutivo = (Personasprogrecaudo.find(lastconsecutivo).consecutivo.to_s[9..15].to_i + 1).to_s.rjust(7,'0')
    # return nextconsecutivo
  end

  helper_method :is_secuenciainmgastosbanco
  def is_secuenciainmgastosbanco
    nextcons = begin
      Objeto.find_by_sql(['select inm_gastosreobanco.nextval cons from dual']).first
    rescue StandardError
      0
    end
    nextcons.cons.to_s
  end

  helper_method :is_consecutivocertificados
  def is_consecutivocertificados
    Objeto.find_by_sql(['select CERTIFICADOS_SEQ.nextval cons from dual'])[0].cons.to_s.rjust(8, '0')
  rescue StandardError
    0
  end

  helper_method :is_consecutivoletras1
  def is_consecutivoletras1
    Objeto.find_by_sql(["select dbms_random.string('F',1) cons from dual"])[0].cons.upcase
  rescue StandardError
    0
  end

  helper_method :is_consecutivoletras2
  def is_consecutivoletras2
    Objeto.find_by_sql(["select dbms_random.string('D',1) cons from dual"])[0].cons.upcase
  rescue StandardError
    0
  end

  helper_method :is_consecutivoletras3
  def is_consecutivoletras3
    Objeto.find_by_sql(["select dbms_random.string('A',1) cons from dual"])[0].cons.upcase
  rescue StandardError
    0
  end

  helper_method :is_select_tasas2gca
  def is_select_tasas2gca
    @objetos = Tasas2gca.all.order('id')
    @objetos
  end

  # Rutinas nuevas para agrupar las funcionalidades
  # 2017-05-13 Fabian Fernandez A.
  helper_method :is_group1
  def is_group1
    datoid = is_portafolio.to_i
    # if datoid.to_i == 10000 or datoid.to_i == 10003 or datoid.to_i == 10006 or datoid.to_i == 10007 or datoid.to_i == 10008 or datoid.to_i == 10009 or datoid.to_i == 10010 or datoid.to_i == 10011
    return true if Portafoliosreporte.exists?(["portafolio_id = #{datoid} and reporte_id = 23"])
  end

  helper_method :is_group2
  def is_group2
    datoid = is_portafolio.to_i
    # if datoid.to_i == 10001 or datoid.to_i == 10004 or datoid.to_i == 10005
    return true if Portafoliosreporte.exists?(["portafolio_id = #{datoid} and reporte_id = 24"])
  end

  helper_method :is_group3
  def is_group3
    datoid = is_portafolio.to_i
    # if datoid.to_i == 10003 or datoid.to_i == 10006 or datoid.to_i == 10007 or datoid.to_i == 10008 or datoid.to_i == 10009 or datoid.to_i == 10010 or datoid.to_i == 10011
    return true if Portafoliosreporte.exists?(["portafolio_id = #{datoid} and reporte_id = 25"])
  end

  helper_method :is_group4
  def is_group4
    datoid = is_portafolio.to_i
    # if datoid.to_i == 10006 or datoid.to_i == 10007 or datoid.to_i == 10008 or datoid.to_i == 10009
    return true if Portafoliosreporte.exists?(["portafolio_id = #{datoid} and reporte_id = 26"])
  end

  helper_method :is_group5
  def is_group5
    datoid = is_portafolio.to_i
    # if datoid.to_i == 10000 or datoid.to_i == 10006 or datoid.to_i == 10007 or datoid.to_i == 10008 or datoid.to_i == 10009 or datoid.to_i == 10010 or datoid.to_i == 10011
    return true if Portafoliosreporte.exists?(["portafolio_id = #{datoid} and reporte_id = 27"])
  end

  helper_method :is_select_estadosdeudor
  def is_select_estadosdeudor
    @objetos = Estado.includes(:estadosportafolios).where(estadosportafolios: { portafolio_id: is_portafolio }).order(:descripcion)
    @objetos
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])

    devise_parameter_sanitizer.permit(:sign_up, &:permit!)
    devise_parameter_sanitizer.permit(:account_update, &:permit!)
  end

  helper_method :is_autoreporte
  def is_autoreporte(reporte_id)
    datoid = is_portafolio.to_i
    return true if Portafoliosreporte.exists?(["portafolio_id = #{datoid} and reporte_id = #{reporte_id}"])
  end

  helper_method :is_select_sucursal
  def is_select_sucursal(portafolioid)
    @objetos = Portafoliossucursal.where(portafolio_id: portafolioid).order(:descripcion)
    @objetos
  end

  helper_method :is_select_vehiculo
  def is_select_vehiculo(portafolioid)
    @objetos = Portafoliosvehiculo.where(portafolio_id: portafolioid).order(:descripcion)
    @objetos
  end

  helper_method :is_permit
  def is_permit(controlador)
    dato = "/#{controlador}"
    if (controlador == 'clientes') && (is_tipoconsulta.to_s == 'CLIENTE')
      true
    else
      mod = begin
        Modulo.find_by(controlador: dato)
      rescue StandardError
        nil
      end
      if mod.nil?
        flash[:warning] = 'Usted no tiene Acceso a este modulo'
        redirect_to root_path
      elsif Usersmodulo.where(user_id: is_admin, modulo_id: mod.id).exists?
        true
      else
        flash[:warning] = 'Usted no tiene Acceso a este modulo'
        redirect_to root_path
      end
    end
  end

  helper_method :is_estudiante
  def is_estudiante
    is_tipoconsulta.to_s == 'CLIENTE'
  end

  helper_method :is_cliente
  def is_cliente
    current_user.cliente_id
  end

  helper_method :is_barbero
  def is_barbero
    is_tipoconsulta.to_s == 'BARBERO'
  end

  helper_method :is_funcionario
  def is_funcionario
    if ((is_tipoconsulta.to_s == 'FUNCIONARIO') || (is_tipoconsulta.to_s == 'TODO')) && (is_portafolio == 10100)
      true
    else
      false
    end
  end

  helper_method :is_edupolespecial
  def is_edupolespecial
    if (is_tipoconsulta.to_s == 'EDUPOLESPECIAL') && (is_portafolio == 10100)
      true
    else
      false
    end
  end

  helper_method :is_konfiguracolpatria
  def is_konfiguracolpatria
    if ((@personasobligacion.cliente == 10244) || (@personasobligacion.cliente == 10245) || (@personasobligacion.cliente == 10246) || (@personasobligacion.cliente == 10247) || (@personasobligacion.cliente == 10248) || (@personasobligacion.cliente == 10249) || (@personasobligacion.cliente == 10250) || (@personasobligacion.cliente == 10251) || (@personasobligacion.cliente == 10252) ||
        (@personasobligacion.cliente == 10253) || (@personasobligacion.cliente == 10254) || (@personasobligacion.cliente == 10255) || (@personasobligacion.cliente == 10256) || (@personasobligacion.cliente == 10257) || (@personasobligacion.cliente == 10258) || (@personasobligacion.cliente == 10259) || (@personasobligacion.cliente == 10260) || (@personasobligacion.cliente == 10261) ||
        (@personasobligacion.cliente == 10262) || (@personasobligacion.cliente == 10263) || (@personasobligacion.cliente == 10264) || (@personasobligacion.cliente == 10265) || (@personasobligacion.cliente == 10266) || (@personasobligacion.cliente == 10267) || (@personasobligacion.cliente == 10268) || (@personasobligacion.cliente == 10269) || (@personasobligacion.cliente == 10270)) && (is_portafolio == 10013)
      true
    else
      false
    end
  end

  helper_method :is_konfigurarai
  def is_konfigurarai
    if ((@personasobligacion.cliente == 11003) || (@personasobligacion.cliente == 11004) || (@personasobligacion.cliente == 11005) || (@personasobligacion.cliente == 11006) || (@personasobligacion.cliente == 11007) || (@personasobligacion.cliente == 11008) || (@personasobligacion.cliente == 11009) || (@personasobligacion.cliente == 11010) || (@personasobligacion.cliente == 11011) ||
        (@personasobligacion.cliente == 11012) || (@personasobligacion.cliente == 11014) || (@personasobligacion.cliente == 11013)) && (is_portafolio == 10013)
      true
    else
      false
    end
  end

  helper_method :is_centro
  def is_centro
    if ((is_tipoconsulta.to_s == 'CENTROAPOYO') || (is_tipoconsulta.to_s == 'COMERCIAL')) && (is_portafolio == 10100)
      true
    else
      false
    end
  end

  helper_method :is_centroapoyo
  def is_centroapoyo
    if (is_tipoconsulta.to_s == 'CENTROAPOYO') && (is_portafolio == 10100)
      true
    else
      false
    end
  end

  helper_method :is_universidad
  def is_universidad
    if (is_tipoconsulta.to_s == 'UNIVERSIDAD') && (is_portafolio == 10100)
      true
    else
      false
    end
  end

  helper_method :is_tecnico
  def is_tecnico
    if (is_tipoconsulta.to_s == 'TECNICO') && (is_portafolio == 10100)
      true
    else
      false
    end
  end

  helper_method :is_estudiantepersonaid
  def is_estudiantepersonaid
    return current_admin_user.cliente_id if is_tipoconsulta.to_s == 'CLIENTE'
  end

  helper_method :is_disabled
  def is_disabled
    is_auth_c('actualizadatos') != true
  end

  helper_method :is_edupolauto
  def is_edupolauto
    if (is_edupolespecial || is_centroapoyo || is_estudiante) && (is_portafolio == 10100)
      true
    else
      false
    end
  end

  helper_method :is_datosedupol
  def is_datosedupol(dato, referencia)
    case referencia.to_s
    when 'CENTRO'
      dato = begin
        Centro.where(id_edupol: dato).first.id
      rescue StandardError
        nil
      end
    when 'TIPODOCUMENTO'
      dato = begin
        Tiposdocumento.where(id_edupol: dato).first.id
      rescue StandardError
        nil
      end
    when 'ESTADOCIVIL'
      dato = begin
        Estadoscivil.where(descripcion_edupol: dato).first.id
      rescue StandardError
        nil
      end
    when 'CIUDAD'
      dato = begin
        Municipio.where(id_edupol: dato).first.id
      rescue StandardError
        nil
      end
    when 'UNIVERSIDAD'
      dato = begin
        Universidad.where(id_edupol: dato).first.id
      rescue StandardError
        nil
      end
    when 'PROGRAMA'
      dato = begin
        Universidadesprograma.where(id_edupol: dato).first.id
      rescue StandardError
        nil
      end
    when 'COHORTE'
      dato = begin
        Cohorte.where(id_edupol: dato).first.id
      rescue StandardError
        nil
      end
    when 'TIPOSOLICITUD'
      if dato == 'NUEVO (POR PRIMERA VEZ)'
        dato = 'NUEVO'
      elsif dato == 'RENOVACION'
        dato = 'RENOVACION'
      elsif dato.nil?
        dato = 'NN'
      end
    when 'GENERO'
      case dato
      when 'M'
        dato = 'MASCULINO'
      when 'F'
        dato = 'FEMENINO'
      end
    end
    dato
  end

  helper_method :is_activo_cohorte
  def is_activo_cohorte(cohorteId, universidadesprogramaId)
    if Cohortesprograma.exists?(["cohorte_id = #{cohorteId} and universidadesprograma_id = #{universidadesprogramaId} and estado_doc = 'ACTIVO'"])
      true
    # elsif Cohortesprograma.exists?(["cohorte_id <> #{cohorteId} and universidadesprograma_id <> #{universidadesprogramaId}"])
    #  return true
    else
      false
    end
  end

  helper_method :is_edupolconseobl
  def is_edupolconseobl
    is_edupolconseobligacion
  end

  helper_method :is_barcode
  def is_barcode(tipo, dato, size, nombre)
    name = "#{::Rails.root}/public/codes/#{nombre}.png"
    if File.exist?(name) == false
      # @blob = Barby::GS1128.new('1','B',p.consecutivo.to_s).to_png(height: 20, margin: 5)
      # @blob2 = Barby::QrCode.new(p.consecutivo.to_s).to_png(:xdim => 2)
      if (tipo.to_s == 'GS1128') && (dato.to_s != '') && size.to_i.positive? && (nombre.to_s != '')
        blob = Barby::GS1128.new(nil, 'C', dato.to_s).to_png(margin: 2, height: 55)
        # blob = Barby::GS1128.new(nil,'B',dato.to_s).to_png(height: 40, width: size.to_i)
        File.open(name.to_s, 'wb') { |f| f.write blob }
      elsif (tipo.to_s == 'QRCODE') && (dato.to_s != '') && size.to_i.positive?
        name = "#{::Rails.root}/public/qr/#{nombre}.png"
        blob = Barby::QrCode.new(dato.to_s).to_png(xdim: size.to_i)
        File.open(name.to_s, 'wb') { |f| f.write blob }
      end
    end
  end

  helper_method :is_pazysalvo
  def is_pazysalvo
    case is_portafolio
    when 10025
      nextconsecutivo = begin
        Objeto.find_by_sql(['select sistem_pazysalvos.nextval valor from dual'])[0].valor.to_i
      rescue StandardError
        0
      end
    when 10026
      nextconsecutivo = begin
        Objeto.find_by_sql(['select sistemhon_pazysalvos.nextval valor from dual'])[0].valor.to_i
      rescue StandardError
        0
      end
    else
      begin
        lastconsecutivo = Personasobligacion.where(['portafolio_id = 10014 and nro_pazysalvo is not null']).maximum('nro_pazysalvo')
      rescue StandardError
        lastconsecutivo = 0
      end
      nextconsecutivo = if lastconsecutivo.to_i.zero?
                          201800001
                        else
                          lastconsecutivo + 1
                        end
    end
    nextconsecutivo
  end

  helper_method :is_keymd5
  def is_keymd5(message)
    Digest::MD5.hexdigest(message)
  end

  helper_method :is_keysha256
  def is_keysha256(message)
    Digest::SHA256.hexdigest(message)
  end

  helper_method :is_edad
  def is_edad(fecha_nacimiento)
    @objetos = Objeto.find_by_sql(["select trunc(months_between(sysdate, to_date('#{fecha_nacimiento.to_date}','yyyy/mm/dd'))/12) fecha_nacimiento from dual"])
    @objetos.each do |objeto|
      return objeto.fecha_nacimiento
    end
  end

  helper_method :diferenciadias
  def diferenciadias(fecha)
    (Date.today - fecha).to_i
  end

  helper_method :diferenciadiasfechas
  def diferenciadiasfechas(fecha1, fecha2)
    (fecha2 - fecha1).to_i
  end

  helper_method :is_simbolo
  def is_simbolo(dato)
    dato = begin
      dato.strip.to_s
    rescue StandardError
      nil
    end
    var = case dato.to_s
          when 'COP'
            "<label class='label label-success'>#{dato}</label>".html_safe
          when 'UVR'
            "<label class='label label-primary'>#{dato}</label>".html_safe
          when 'USD'
            "<label class='label label-info'>#{dato}</label>".html_safe
          when 'PEN', 'SOLES'
            "<label class='label label-warning'>#{dato}</label>".html_safe
          when 'EUR'
            "<label class='label label-danger'>#{dato}</label>".html_safe
          when 'HNL'
            "<label class='label label-primary'>#{dato}</label>".html_safe
          else
            "<label class='label label-danger'>#{dato}</label>".html_safe
          end
    begin
      var
    rescue StandardError
      nil
    end
  end

  helper_method :is_moneda
  def is_moneda(dato)
    dato = begin
      dato.strip.to_s
    rescue StandardError
      nil
    end
    var = case dato.to_s
          when 'COP'
            'PESOS'
          when 'UVR'
            'UVRS'
          when 'USD'
            'DOLARES'
          when 'PEN', 'SOLES'
            'SOLES'
          when 'EUR'
            'EUROS'
          when 'HNL'
            'LEMPIRAS'
          else
            dato
          end
    begin
      var
    rescue StandardError
      nil
    end
  end

  helper_method :is_estadosbancos
  def is_estadosbancos(dato)
    dato = begin
      dato.strip.to_s
    rescue StandardError
      nil
    end
    case dato.to_s
    when 'POR ENVIAR'
      var = "<label class='label label-warning'>#{dato}</label>".html_safe
    when 'ENVIADO'
      var =  "<label class='label label-primary'>#{dato}</label>".html_safe
    when 'FINALIZADO'
      var =  "<label class='label label-success'>#{dato}</label>".html_safe
    end
    begin
      var
    rescue StandardError
      nil
    end
  end

  helper_method :is_select_estadotanque
  def is_select_estadotanque
    @objetos = Tanque.where(portafolio_id: is_portafolio).order(:estado).select(:estado).distinct
    @objetos
  end

  helper_method :is_select_cuentatanque
  def is_select_cuentatanque
    @objetos = Tanque.where(portafolio_id: is_portafolio).order(:cuenta).select(:cuenta).distinct
    @objetos
  end

  helper_method :is_select_tipoinmueblebuscador
  def is_select_tipoinmueblebuscador(portafolioid)
    @objetos = Tiposinmueble.where(["id in (select distinct tiposinmueble_id from inmuebles where portafolio_id =  #{portafolioid})"]).order('descripcion')
    @objetos
  end

  helper_method :is_select_perumunicipio
  def is_select_perumunicipio
    @municipios = Perumunicipio.order('ciudad').all
    @municipios
  end

  helper_method :select_naturalezapersona
  def select_naturalezapersona
    @naturalezapersonas = Parnaturalezadeudor.all.order('cod_cifin')
    @naturalezapersonas
  end

  helper_method :select_situaciondeudor
  def select_situaciondeudor
    @situaciondeudores = Parsituaciondeudor.all.order('cod_cifin')
    @situaciondeudores
  end

  helper_method :is_valida_cierre
  def is_valida_cierre
    if is_sygma
      true
    else
      isportafolio = is_portafolio
      por = Portafolio.find(isportafolio)
      if por.bloqueo_recaudo.to_s == 'SI'
        false
      elsif por.valida_cierre.to_s == 'SI'
        valida = begin
          Portafolioscierre.where(["portafolio_id = #{isportafolio} and anno||'_'||mes = to_char(ADD_MONTHS(sysdate,-1),'YYYY_MM')"]).select(:tipo).distinct
        rescue StandardError
          nil
        end
        if valida.count.to_i.positive?
          valida[0].tipo.to_s == 'CONSOLIDADO'
        else
          false
        end
      else
        true
      end
    end
  end

  helper_method :is_dashboard
  def is_dashboard
    if is_sygma
      true
    else
      isportafolio = is_portafolio
      por = Portafolio.find(isportafolio)
      por.act_dash.to_s == 'SI'
    end
  end

  helper_method :is_consecutivotanque
  def is_consecutivotanque
    lastConsecutivo = begin
      Objeto.find_by_sql(['select constanques_seq.nextval cons from dual']).first
    rescue StandardError
      0
    end
    lastConsecutivo.cons
  end

  helper_method :parametrizacioncolombia
  def parametrizacioncolombia
    isportafolio = is_portafolio
    por = Portafolio.find(isportafolio)
    por.nacional.to_s != 'NO'
  end

  helper_method :seleccionar_tiposdocumentos
  def seleccionar_tiposdocumentos
    if parametrizacioncolombia == true
      @documentos = if [10023, 10025, 10026, 10027, 10028, 10029, 10030, 10031, 10032, 10033, 10034, 10035].include?(is_portafolio)
                      Tiposdocumento.where("id in (select tiposdocumento_id from tiposdocumentosportafolios where portafolio_id = #{is_portafolio})").order('cod_cifin')
                    else
                      Tiposdocumento.where(co: 'SI').order('cod_cifin')
                    end

      @documentos
    else
      @documentos = Tiposdocumento.where(pe: 'SI').order('descripcion')
      @documentos
    end
  end

  helper_method :select_origenespago
  def select_origenespago
    @origenes = Parorigenespago.where(activo_manual: 'SI').order('descripcion')
    @origenes
  end

  helper_method :select_lotespendientes
  def select_lotespendientes
    @lotes = Inmueblesgastosbanco.select(:num_archivo).distinct.where(estado: 'ENVIADO')
    @lotes
  end

  helper_method :is_select_broker
  def is_select_broker(portafolioid)
    @objetos = Broker.where(["id in (select broker_id from inmueblesbrokers where inmueble_id in (select id from inmuebles where portafolio_id =  #{portafolioid}))"]).order('nombre')
    @objetos
  end

  helper_method :is_controlmigracion
  def is_controlmigracion
    c = begin
      Objeto.find_by_sql(['select CONTROLMIGRACIONES_SEQ.nextval cons from dual']).first
    rescue StandardError
      0
    end
    c.cons.to_s
  end

  helper_method :is_sumardias
  def is_sumardias(dias)
    Objeto.find_by_sql("select (trunc(sysdate) + #{dias}) fch from dual")[0].fch
  end

  helper_method :is_select_estado_bloqueo
  def is_select_estado_bloqueo
    Objeto.find_by_sql("select distinct bloqueo, decode(bloqueo,null,'SIN Codigo',bloqueo) descripcion from personasobldatacreditos")
  end

  helper_method :is_pais
  def is_pais
    if is_portafolio == 10026
      'HONDURAS'
    else
      'COLOMBIA'
    end
  end

  helper_method :is_cargohabilitado
  def is_cargohabilitado(isadmin)
    if User.exists?(["id = #{isadmin} and portafolioscargo_id in (11243,11242)"])
      true
    else
      false
    end
  end

  helper_method :is_cargoconsulta
  def is_cargoconsulta
    if User.exists?(["id = #{is_admin} and portafolioscargo_id = 11342"])
      false
    else
      true
    end
  end

  helper_method :is_cargoconsulta2
  def is_cargoconsulta2
    if User.exists?(["id = #{is_admin} and portafolioscargo_id = 11422"])
      false
    else
      true
    end
  end

  helper_method :is_ambito
  def is_ambito
    current_admin_user.ambito
  rescue StandardError
    nil
  end

  helper_method :is_personaid
  def is_personaid
    current_admin_user.persona_id
  rescue StandardError
    nil
  end

  helper_method :is_fit
  def is_fit(dato)
    dato = begin
      dato.strip.to_s
    rescue StandardError
      nil
    end
    var = if (dato.to_s == 'NO') || (dato.to_s == 'NO MATCH') || (dato.to_s == 'RECHAZADO')
            "<label class='label label-danger'>#{dato}</label>".html_safe
          else
            dato.to_s
          end
    begin
      var
    rescue StandardError
      nil
    end
  end

  helper_method :is_select_sedes
  def is_select_sedes
    @objetos = Portis_personaafolio.where(["estado = 'ACTIVO' and id not in (1)"]).order('nombre')
    @objetos
  end

  helper_method :is_persona
  def is_persona
    current_user.tipoconsulta.to_s == 'PERSONA'
  end

  helper_method :is_estudiante
  def is_estudiante
    current_user.tipoconsulta.to_s == 'ESTUDIANTE'
  end

  helper_method :is_nombreestudiante
  def is_nombreestudiante
    Persona.find(is_admin.persona_id).autobuscar
  rescue StandardError
    nil
  end

  helper_method :is_select_preguntas
  def is_select_preguntas(categoriaId)
    @objetos = Objeto.find_by_sql("(SELECT p.id FROM preguntas p, preguntascategorias c WHERE p.id = c.pregunta_id
                                    AND c.categoria_id = #{categoriaId} AND p.grupo = 1 AND p.multiple = 'N' ORDER BY RAND() LIMIT 8)
                                    UNION
                                    (SELECT p.id FROM preguntas p, preguntascategorias c WHERE p.id = c.pregunta_id
                                    AND c.categoria_id = #{categoriaId}  AND p.grupo = 2 AND p.multiple = 'N' ORDER BY RAND() LIMIT 12)
                                    UNION
                                    (SELECT p.id FROM preguntas p, preguntascategorias c WHERE p.id = c.pregunta_id
                                    AND c.categoria_id = #{categoriaId}  AND p.grupo = 3 AND p.multiple = 'N' ORDER BY RAND() LIMIT 8)
                                    UNION
                                    (SELECT p.id FROM preguntas p, preguntascategorias c WHERE p.id = c.pregunta_id
                                    AND c.categoria_id = #{categoriaId}  AND p.grupo = 4 AND p.multiple = 'N' ORDER BY RAND() LIMIT 12)")
    # puts @objetos
    @objetos
  end

  helper_method :is_random
  def is_random(vcDetalle)
    Objeto.find_by_sql("select valor from random where descripcion = '#{vcDetalle}' order by rand() limit 1")[0].valor.to_i
  rescue StandardError
    0
  end

  helper_method :is_progminfecha
  def is_progminfecha
    minfecha = begin
      Programacionesfecha.where(["(hora1 > 0 and estado1 is null) or (hora2 > 0 and estado2 is null) or
                                                           (hora3 > 0 and estado3 is null) or (hora4 > 0 and estado4 is null) or
                                                           (hora5 > 0 and estado5 is null) or (hora6 > 0 and estado6 is null) or
                                                           (hora7 > 0 and estado7 is null) or (hora8 > 0 and estado8 is null) or
                                                           (hora9 > 0 and estado9 is null) or (hora10 > 0 and estado10 is null) or
                                                           (hora11 > 0 and estado11 is null) or (hora12 > 0 and estado12 is null) or
                                                           (hora13 > 0 and estado13 is null) or (hora14 > 0 and estado14 is null) or
                                                           (hora15 > 0 and estado15 is null) or (hora16 > 0 and estado16 is null) or
                                                           (hora17 > 0 and estado17 is null)"]).minimum('fecha')
    rescue StandardError
      nil
    end
    if minfecha.to_s == ''
      minfecha = begin
        Programacionesfecha.where(["hora1 > 0 OR hora2 > 0 OR hora3 > 0 OR hora4 > 0 OR hora5 > 0 OR hora6 > 0 OR hora7 > 0 OR hora8 > 0 OR hora9 > 0
                                                                OR hora10 > 0 OR hora11 > 0 OR hora12 > 0 OR hora13 > 0 OR hora14 > 0 OR hora15 > 0 OR hora16 > 0 OR hora17 > 0"]).maximum('fecha')
      rescue StandardError
        nil
      end
    end
    minfecha.to_date
  end

  helper_method :is_progmaxfecha
  def is_progmaxfecha
    fechaprog(is_progminfecha, 180).to_date
  end

  helper_method :nameday
  def nameday(dia)
    day_names = %w[Domingo Lunes Martes Miercoles Jueves Viernes Sabado]
    day_names[dia]
  end

  helper_method :is_fechaprueba
  def is_fechaprueba(fechainicial, dias)
    Objeto.find_by_sql("select ADDDATE('#{fechainicial}', INTERVAL #{dias} DAY) fch from dual")[0].fch.to_date
  rescue StandardError
    nil
  end

  helper_method :is_showdate
  def is_showdate
    # if Parametro.find(32).valor.to_s == 'S'
    'S'
    # end
  end

  helper_method :is_username
  def is_username
    current_user.username
  end

  helper_method :is_programacionagenda
  def is_programacionagenda(placaid, _fecha)
    Objeto.find_by_sql(["
        SELECT a.id,a.placa_id,a.fecha,a.idhorario,a.horario,a.personastramite_id,a.estado,a.autobuscar,a.celular,
              (SELECT respuesta FROM personasbitacoras WHERE personastramite_id = a.personastramite_id AND placa_id = a.placa_id AND fecha = a.fecha AND tiposhorario_id = a.idhorario) respuestaclase,
              (SELECT clase FROM personasbitacoras WHERE personastramite_id = a.personastramite_id AND placa_id = a.placa_id AND fecha = a.fecha AND tiposhorario_id = a.idhorario) clase,
              (SELECT id FROM personasbitacoras WHERE personastramite_id = a.personastramite_id AND placa_id = a.placa_id AND fecha = a.fecha AND tiposhorario_id = a.idhorario) personasbitacora_id
        FROM (SELECT p.id,p.placa_id,p.fecha,1 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 1) horario, p.hora1 personastramite_id,p.estado1 estado,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora1 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,2 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 2) horario, p.hora2 personastramite_id,p.estado2,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora2 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,3 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 3) horario, p.hora3 personastramite_id,p.estado3,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora3 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,4 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 4) horario, p.hora4 personastramite_id,p.estado4,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora4 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,5 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 5) horario, p.hora5 personastramite_id,p.estado5,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora5 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,6 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 6) horario, p.hora6 personastramite_id,p.estado6,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora6 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,7 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 7) horario, p.hora7 personastramite_id,p.estado7,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora7 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,8 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 8) horario, p.hora8 personastramite_id,p.estado8,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora8 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,9 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 9) horario, p.hora9 personastramite_id,p.estado9,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora9 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,10 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 10) horario, p.hora10 personastramite_id,p.estado10,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora10 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,11 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 11) horario, p.hora11 personastramite_id,p.estado11,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora11 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,12 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 12) horario, p.hora12 personastramite_id,p.estado12,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora12 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,13 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 13) horario, p.hora13 personastramite_id,p.estado13,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora13 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,14 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 14) horario, p.hora14 personastramite_id,p.estado14,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora14 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,15 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 15) horario, p.hora15 personastramite_id,p.estado15,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora15 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,16 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 16) horario, p.hora16 personastramite_id,p.estado16,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora16 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id
              UNION ALL
              SELECT p.id,p.placa_id,p.fecha,17 idhorario, (SELECT descripcion FROM tiposhorarios WHERE id = 17) horario, p.hora17 personastramite_id,p.estado17,pe.autobuscar,pe.celular
              FROM   programacionesfechas p, personastramites t, personas pe
              WHERE  p.hora17 = t.id and p.fecha = '#{_fecha.to_date}' AND t.persona_id = pe.id) a
        WHERE  a.placa_id = #{placaid} AND a.fecha = '#{_fecha.to_date}'"])
  end

  helper_method :is_programacionpersona
  def is_programacionpersona(personastramiteid)
    ActiveRecord::Base.connection.execute("CALL prc_personastrapractica(#{personastramiteid})")
    Objeto.find_by_sql(["select * from personastrapracticas where personastramite_id = #{personastramiteid}"])
  end

  helper_method :is_liq
  def is_liq
    nroliq = 0
    @abonos = Abono.find_by_sql('select max(cast(nro_abono as signed)) nro from abonos')
    @abonos.each do |abono|
      nroliq = abono.nro
    end
    nroliq.to_i + 1
  end

  private

  def enforce_password_change
    return if password_change_exempt?

    needs_change = session[:must_change_password] || current_user.must_change_password?
    return unless needs_change

    session[:must_change_password] = true
    redirect_to editpass_user_path(current_user), alert: 'Debe cambiar su contraseña antes de continuar.'
  end

  def password_change_exempt?
    return true if devise_controller? && controller_name == 'passwords'
    return true if controller_path == 'users/sessions'
    return true if controller_path == 'users' && %w[editpass updatepass].include?(action_name)
    return true if devise_controller? && controller_name == 'registrations'
    return true if controller_path.include?('two_factor')

    false
  end
end
