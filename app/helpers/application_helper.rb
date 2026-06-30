# frozen_string_literal: true

module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def user_account_locked?(user)
    return false unless user

    user.access_locked? || user.failed_attempts.to_i >= Devise.maximum_attempts
  end

  def user_account_active?(user)
    user&.activo.to_s == 'S'
  end

  def modulo_sidebar_icon(modulo)
    imagen = modulo.imagen.to_s.strip
    if imagen.match?(/\Afa[\s-]/i)
      return imagen.sub('fa-file-text-o', 'fa-info-circle')
    end

    path = modulo.controlador.to_s.downcase
    name = modulo.descripcion.to_s.downcase

    icon =
      case path
      when /alertas/ then 'fa-bell'
      when /combustible/ then 'fa-fire'
      when /factura/ then 'fa-info-circle'
      when /horario/ then 'fa-calendar'
      when /mantenimiento/ then 'fa-wrench'
      when /nomina/ then 'fa-info-circle'
      when /parqueadero/ then 'fa-car'
      when /persona/ then 'fa-users'
      when /viaje/ then 'fa-road'
      when /tour/ then 'fa-map-marker'
      when /user/ then 'fa-user'
      when /categoria/ then 'fa-tags'
      when /cobro/ then 'fa-info-circle'
      when /compra/ then 'fa-shopping-cart'
      when /concepto/ then 'fa-list-alt'
      when /egreso/ then 'fa-info-circle'
      when /empleado/ then 'fa-id-card'
      when /empresa/ then 'fa-building'
      when /instructor/ then 'fa-graduation-cap'
      when /modulo/ then 'fa-cubes'
      when /objeto/ then 'fa-cube'
      when /placa/ then 'fa-info-circle'
      when /producto/ then 'fa-cube'
      when /proveedor/ then 'fa-truck'
      when /tramite/ then 'fa-clipboard'
      else
        case name
        when /usuario/ then 'fa-user'
        when /persona/ then 'fa-users'
        when /factura/ then 'fa-info-circle'
        when /tour/ then 'fa-map-marker'
        when /alerta/ then 'fa-bell'
        when /combustible/ then 'fa-fire'
        when /nomina/ then 'fa-info-circle'
        when /cobro/ then 'fa-info-circle'
        when /egreso/ then 'fa-info-circle'
        when /placa/ then 'fa-info-circle'
        when /parqueadero/ then 'fa-car'
        when /mantenimiento/ then 'fa-wrench'
        when /horario/ then 'fa-calendar'
        else 'fa-circle-o'
        end
      end

    icon = 'fa-info-circle' if icon == 'fa-file-text-o'

    "fa #{icon}"
  end

  def irregular_types(type)
    case type
    when 'alert'
      'danger'
    when 'notice'
      'success'
    else
      type
    end
  end

  def select_tipoingreso
    [
      %w[PROPIO PROPIO],
      %w[TERCERO TERCERO]
    ]
  end

  def select_diassemana
    [
      %w[LUNES LUNES],
      %w[MARTES MARTES],
      %w[MIÉRCOLES MIÉRCOLES],
      %w[JUEVES JUEVES],
      %w[VIERNES VIERNES],
      %w[SÁBADO SÁBADO],
      %w[DOMINGO DOMINGO]
    ]
  end

  def select_claseicetexestados
    [
      %w[ICETEX ICETEX],
      %w[EDUPOL EDUPOL]
    ]
  end

  def select_ambitogps
    [
      %w[GPS GPS],
      %w[AGENCIA AGENCIA],
      ['AGENCIA JURIDICA', 'AGENCIA JURIDICA'],
      %w[ESTUDIO ESTUDIO]
    ]
  end

  def estados_documentacion
    [
      ['Sin solicitud Web', 'Sin solicitud Web'],
      ['Con Web - Sin documentos', 'Con Web - Sin documentos'],
      ['Con Web - Documentos con inconsistencias', 'Con Web - Documentos con inconsistencias'],
      ['Con Web - Documentos Completos', 'Con Web - Documentos Completos'],
      ['Admitido IES', 'Admitido IES'],
      ['No admitido por estar fuera de fecha', 'No admitido por estar fuera de fecha']
    ]
  end

  def select_tipoedupol
    [
      %w[ANTIGUOS ANTIGUOS],
      %w[NUEVOS NUEVOS]
    ]
  end

  def select_charterbank
    [
      %w[HUANCAYO HUANCAYO],
      %w[SULLANA SULLANA]
    ]
  end

  def select_tipogeneracionmasiva
    [
      ['PAZ Y SALVO', 'PAZ Y SALVO'],
      ['ESTADOS DE CUENTA', 'ESTADOS DE CUENTA']
    ]
  end

  def select_tipodemograficos
    [
      %w[TELEFONOS TELEFONOS],
      %w[DIRECCIONES DIRECCIONES],
      %w[CORREOS CORREOS],
      %w[LABORALES LABORALES]
    ]
  end

  def select_tipoestudios
    [
      %w[ESTUDIOS ESTUDIOS],
      %w[ABOGADO ABOGADO],
      %w[DIRECTOR DIRECTOR]
    ]
  end

  def select_tipometodourl
    [
      %w[GET GET],
      %w[POST POST]
    ]
  end

  def select_resultado
    [
      %w[POSITIVO POSITIVO],
      %w[NEGATIVO NEGATIVO]
    ]
  end

  def select_diasmora
    [
      ['Al Día', '0 and 0'],
      ['1 - 30', '1 and 30'],
      ['31 - 60', '31 and 60'],
      ['61 - 90', '61 and 90'],
      ['91 - 180', '91 and 180'],
      ['181 - 360', '181 and 360'],
      ['Mas de 360 Días', '361 and 100000']
    ]
  end

  def select_tipoprogramaedupol
    [
      ['TECNICA PROFESIONAL', 'TECNICA PROFESIONAL'],
      %w[TECNOLOGÍA TECNOLOGIA],
      %w[PROFESIONAL PROFESIONAL],
      ['CURSOS ESPECIALES', 'CURSOS ESPECIALES'],
      %w[ESPECIALIZACIÓN ESPECIALIZACION],
      %w[MAESTRÍA MAESTRIA],
      %w[DIPLOMADOS DIPLOMADOS]
    ]
  end

  def select_tipogastojudicial
    [
      %w[JUDICIAL JUDICIAL],
      %w[NOTARIAL NOTARIAL],
      %w[REGISTRAL REGISTRAL],
      %w[DILIGENCIAMIENTO DILIGENCIAMIENTO]
    ]
  end

  def estado_edupolgeneral(est)
    case est
    when 'APPROVED'
      'Aprobada'
    when 'DECLINED'
      'Rechazada'
    when 'EXPIRED'
      'Expirada'
    when 'PENDING'
      'Pendiente'
    else
      'Error'
    end
  end

  def metodospago(metodo)
    case metodo
    when 'CREDIT_CARD'
      'Tarjeta de Crédito'
    when 'PSE'
      'PSE'
    when 'ACH'
      'Tarjeta Débito'
    when 'CASH'
      'Efectivo'
    when 'REFERENCED'
      'Pago Referenciado'
    when 'BANK_REFERENCED'
      'Pago en Banco'
    end
  end

  def estado_edupol(estado)
    case estado
    when 'APPROVED'
      'Transacción aprobada'
    when 'PAYMENT_NETWORK_REJECTED'
      'Transacción rechazada por entidad financiera'
    when 'ENTITY_DECLINED'
      'Transacción rechazada por el banco'
    when 'INSUFFICIENT_FUNDS'
      'Fondos insuficientes'
    when 'INVALID_CARD'
      'Tarjeta inválida'
    when 'CONTACT_THE_ENTITY'
      'Contactar entidad financiera'
    when 'BANK_ACCOUNT_ACTIVATION_ERROR'
      'Débito automático no permitido'
    when 'BANK_ACCOUNT_NOT_AUTHORIZED_FOR_AUTOMATIC_DEBIT'
      'Débito automático no permitido'
    when 'INVALID_BANK'
      'Débito automático no permitido'
    when 'INVALID_BANK_ACCOUNT'
      'Débito automático no permitido'
    when 'INVALID_AGENCY_BANK_ACCOUNT'
      'Débito automático no permitido'
    when 'EXPIRED_CARD'
      'Tarjeta vencida'
    when 'RESTRICTED_CARD'
      'Tarjeta restringida'
    when 'INVALID_EXPIRATION_DATE_OR_SECURITY_CODE'
      'Fecha de expiración o código de seguridad inválidos'
    when 'REPEAT_TRANSACTION'
      'Reintentar pago'
    when 'INVALID_TRANSACTION'
      'Transacción inválida'
    when 'EXCEEDED_AMOUNT'
      'El valor excede el máximo permitido por la entidad'
    when 'ABANDONED_TRANSACTION'
      'Transacción abandonada por el pagador'
    when 'CREDIT_CARD_NOT_AUTHORIZED_FOR_INTERNET_TRANSACTIONS'
      'Tarjeta no autorizada para comprar por internet'
    when 'ANTIFRAUD_REJECTED'
      'Transacción rechazada por sospecha de fraude'
    when 'DIGITAL_CERTIFICATE_NOT_FOUND'
      'Certificado digital no encontrado'
    when 'BANK_UNREACHABLE'
      'Error tratando de cominicarse con el banco'
    when 'ENTITY_MESSAGING_ERROR'
      'Error comunicándose con la entidad financiera'
    when 'NOT_ACCEPTED_TRANSACTION'
      'Transacción no permitida al tarjeta habiente'
    when 'PAYMENT_NETWORK_NO_CONNECTION'
      'No fue posible establecer comunicación con la entidad financiera'
    when 'PAYMENT_NETWORK_NO_RESPONSE'
      'No se recibió respuesta de la entidad financiera'
    when 'EXPIRED_TRANSACTION'
      'Transacción expirada'
    when 'PENDING_TRANSACTION_REVIEW'
      'Transacción en validación manual'
    when 'PENDING_TRANSACTION_CONFIRMATION'
      'Recibo de pago generado. En espera de pago'
    when 'PENDING_TRANSACTION_TRANSMISSION'
      'Transacción no permitida'
    when 'PENDING_PAYMENT_IN_ENTITY'
      'Recibo de pago generado. En espera de pago'
    when 'PENDING_PAYMENT_IN_BANK'
      'Recibo de pago generado. En espera de pago'
    when 'PENDING_AWAITING_PSE_CONFIRMATION'
      'En espera de confirmación de PSE'
    when 'PENDING_NOTIFYING_ENTITY'
      'Recibo de pago generado. En espera de pago'
    else
      'Error'
    end
  end

  def select_tipocode
    [
      %w[VISTA VISTA],
      %w[CONTROLADOR CONTROLADOR],
      %w[MODELO MODELO]
    ]
  end

  def select_fuente
    [
      ['RECAUDO MES', 'RECAUDO MES'],
      ['RECAUDO TANQUE', 'RECAUDO TANQUE']
    ]
  end

  def select_tipoviv
    [
      %w[VIS S],
      ['NO VIS', 'N']
    ]
  end

  def tipousercentro
    [
      %w[COMERCIAL COMERCIAL],
      %w[ANALISTA ANALISTA]
    ]
  end

  def calcular_porcentaje(value1, value2)
    val = value2.to_f / value1
    val.to_f * 100
  end

  def calcular_restante(value1, value2)
    value1.to_f - value2.to_f
  end

  def log_actions(value)
    case value
    when 'destroy'
      'Eliminar'
    when 'create'
      'Crear'
    when 'update'
      'Actualizar'
    end
  end

  def selectnumdiasprioridades
    [
      ['15', 15],
      ['30', 30],
      ['60', 60],
      ['90', 90],
      ['120', 120],
      ['180', 180]
    ]
  end

  def select_plazo_edu
    [
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5]
    ]
  end

  def select_sino
    [
      %w[SI SI],
      %w[NO NO]
    ]
  end

  def select_sinoingles
    [
      %w[YES YES],
      %w[NO NO]
    ]
  end

  def select_hipoteca
    [
      %w[SI SI],
      %w[NO NO],
      ['SIN ESCRITURA', 'SIN ESCRITURA'],
      ['SIN HIPOTECA', 'SIN HIPOTECA']
    ]
  end

  def select_sinopayu
    [
      ['SI', 1],
      ['NO', 0]
    ]
  end

  def select_monedapayu
    [
      ['Peso Argentino', 'ARS'],
      ['Real Brasileño', 'BRL'],
      ['Peso Chileno', 'CLP'],
      ['Peso Colombiano', 'COP'],
      ['Peso Mexicano', 'MXN'],
      ['Nuevo Sol Peruano', 'PEN'],
      ['Dólar Americano', 'USD']
    ]
  end

  def select_no
    [
      %w[NO NO]
    ]
  end

  def select_genero
    [
      %w[MASCULINO MASCULINO],
      %w[FEMENINO FEMENINO]
    ]
  end

  def select_clasedeudor
    [
      ['DEUDOR PRINCIPAL', 'DEUDOR PRINCIPAL'],
      ['DEUDOR SOLIDARIO', 'DEUDOR SOLIDARIO']
    ]
  end

  def select_situacion_bene
    [
      ['CULMINO EXITOSAMENTE PROGRAMA FINANCIADO', 'CULMINO EXITOSAMENTE PROGRAMA FINANCIADO'],
      ['CULMINO EXITOSAMENTE PROGRAMA DIFERENTE AL FINANCIADO', 'CULMINO EXITOSAMENTE PROGRAMA DIFERENTE AL FINANCIADO'],
      ['DESERTO DE ESTUDIOS SUPERIORES', 'DESERTO DE ESTUDIOS SUPERIORES'],
      ['CONTINUA ESTUDIANDO EL PROGRAMA FINANCIADO', 'CONTINUA ESTUDIANDO EL PROGRAMA FINANCIADO'],
      ['INICIO ESTUDIOS DIFERENTES AL FINANCIADO', 'INICIO ESTUDIOS DIFERENTES AL FINANCIADO'],
      ['SIN DATO', 'SIN DATO']
    ]
  end

  def select_situacion_econo
    [
      %w[EMPLEADO EMPLEADO],
      %w[INDEPENDIENTE INDEPENDIENTE],
      %w[DESEMPLEADO DESEMPLEADO],
      %w[PENSIONADO PENSIONADO],
      ['SIN DATO', 'SIN DATO']
    ]
  end

  def select_tiposatencion
    [
      %w[PERSONALIZADA PERSONALIZADA],
      %w[TELEFONICA TELEFONICA],
      %w[DOMICILIARIA DOMICILIARIA],
      ['CORREO FISICO', 'CORREO FISICO'],
      ['CORREO ELECTRONICO', 'CORREO ELECTRONICO'],
      %w[OTRA OTRA]
    ]
  end

  def select_tipogecasr
    [
      %w[PERSONALIZADA PERSONALIZADA],
      %w[TELEFONICA TELEFONICA],
      %w[DOMICILIARIA DOMICILIARIA],
      ['CORREO FISICO', 'CORREO FISICO'],
      ['CORREO ELECTRONICO', 'CORREO ELECTRONICO'],
      ['PROMESA PAGO', 'PROMESA PAGO'],
      %w[OTRA OTRA]
    ]
  end

  def select_oficinaregistro
    is_select_oficinaregistro
  end

  def select_municipio
    is_select_municipio
  end

  def select_notaria
    is_select_notaria
  end

  def select_tipoproceso
    [
      ['EJECUTIVO SINGULAR', 'EJECUTIVO SINGULAR'],
      ['EJECUTIVO MIXTO', 'EJECUTIVO MIXTO'],
      ['EJECUTIVO HIPOTECARIO', 'EJECUTIVO HIPOTECARIO'],
      ['EJECUTIVO PRENDARIO', 'EJECUTIVO PRENDARIO']
    ]
  end

  def select_caracteristicatitulo
    [
      ['REAL CON GARANTIA HIPOTECARIA', 'REAL CON GARANTIA HIPOTECARIA'],
      ['REAL CON GARANTIA PRENDARIA', 'REAL CON GARANTIA PRENDARIA'],
      %w[QUIROGRAFARIO QUIROGRAFARIO]
    ]
  end

  def select_tipojuzgado
    [
      ['CIVIL MUNICIPAL', 'CIVIL MUNICIPAL'],
      ['CIVIL DEL CIRCUITO', 'CIVIL DEL CIRCUITO'],
      ['PROMISCUO MUNICIPAL', 'PROMISCUO MUNICIPAL'],
      ['PROMISCUO DE CIRCUITO', 'PROMISCUO DE CIRCUITO'],
      ['TRIBUNAL SUPERIOR', 'TRIBUNAL SUPERIOR'],
      ['CORTE SUPREMA', 'CORTE SUPREMA']
    ]
  end

  def select_estadoproceso
    [
      %w[ACTIVO ACTIVO],
      ['ACUERDO DE PAGO ORIGINADOR', 'ACUERDO DE PAGO ORIGINADOR'],
      %w[ADMINITIDA ADMINITIDA],
      %w[ARCHIVADO ARCHIVADO],
      ['ARCHIVO DEFINITIVO', 'ARCHIVO DEFINITIVO'],
      %w[BRP BRP],
      %w[DEVUELTA DEVUELTA],
      ['EN TERMINACIÓN', 'EN TERMINACION'],
      ['EN TRAMITE', 'EN TRAMITE'],
      %w[INACTIVO INACTIVO],
      ['INACTIVO INCIERTO', 'INACTIVO INCIERTO'],
      %w[INADMITEN INADMITEN],
      %w[INADMITIDA INADMITIDA],
      %w[INSOLVENCIA INSOLVENCIA],
      ['PROCESO EN CONTRA', 'PROCESO EN CONTRA'],
      %w[RECHAZADA RECHAZADA],
      ['RECEPCION GARANTIAS', 'RECEPCION GARANTIAS'],
      %w[RECOMPRA RECOMPRA],
      %w[REMATADO REMATADO],
      %w[RETIRADA RETIRADA],
      ['SIN INFORMACION DEL ORIGINADOR', 'SIN INFORMACION DEL ORIGINADOR'],
      ['SIN UBICACION', 'SIN UBICACION'],
      ['SOLICITUD TERMINACION', 'SOLICITUD TERMINACION'],
      %w[SUSPENDIDO SUSPENDIDO],
      %w[SUSPENCION SUSPENCION],
      ['SUSPENCION DEL PROCESO', 'SUSPENCION DEL PROCESO'],
      %w[TERMINADO TERMINADO],
      ['TERMINADO POR JUZGADO', 'TERMINADO POR JUZGADO'],
      ['DEVOLUCION GARANTIA', 'DEVOLUCION GARANTIA'],
      ['TERMINADO POR DESISTIMIENTO TACITO', 'TERMINADO POR DESISTIMIENTO TACITO'],
      ['TERMINADO POR PAGO', 'TERMINADO POR PAGO'],
      ['TERMINADO POR PAGO TOTAL', 'TERMINADO POR PAGO TOTAL'],
      ['TERMINADO PAGO CUOTAS EN MORA', 'TERMINADO PAGO CUOTAS EN MORA'],
      ['VENTA DE DERECHOS DE CREDITO', 'VENTA DE DERECHOS DE CREDITO'],
      ['VERIFICAR ACUERDO DE PAGO', 'VERIFICAR ACUERDO DE PAGO'],
      ['VERIFICAR TERMINACION', 'VERIFICAR TERMINACION']
    ]
  end

  def select_estadodetalleproceso
    [
      %w[CLOSED CLOSED],
      %w[OPEN OPEN],
      ['MIX PERFORMING', 'MIX PERFORMING'],
      %w[PUTBACK PUTBACK]
    ]
  end

  def select_estadogca_proceso
    [
      %w[ACTIVO ACTIVO],
      %w[DEVUELTA DEVUELTA],
      %w[RECOMPRA RECOMPRA],
      %w[SUSPENSION SUSPENSION],
      %w[TERMINADO TERMINADO],
      ['TRAMITE DE CESION', 'TRAMITE DE CESION'],
      ['VENTA DE DERECHOS DE CREDITO', 'VENTA DE DERECHOS DE CREDITO']
    ]
  end

  def select_user
    is_select_user
  end

  def select_useractivo
    is_select_useractivo
  end

  def select_useredupol
    is_select_useredupol
  end

  def select_parorigenespago
    is_select_parorigenespago
  end

  def select_tipodocumento
    is_select_tipodocumento
  end

  def select_tipopersona
    [
      ['PERSONA NATURAL', 'PERSONA NATURAL'],
      ['PERSONA JURIDICA', 'PERSONA JURIDICA']
    ]
  end

  def select_estadocivil
    [
      %w[CASADO CASADO],
      %w[DIVORCIADO DIVORCIADO],
      %w[ND ND],
      ['Q.E.P.D.', 'Q.E.P.D.'],
      %w[SEPARADO SEPARADO],
      %w[SOLTERO SOLTERO],
      ['UNION LIBRE', 'UNION LIBRE'],
      %w[VIUDO VIUDO]
    ]
  end

  def select_cliente
    is_select_cliente
  end

  def select_partiposcartera
    is_select_partiposcartera
  end

  def select_lineacredito
    is_select_lineacredito
  end

  def select_partiposproducto
    is_select_partiposproducto
  end

  def select_canal
    [
      ['ALMACENES CADENA', 'ALMACENES CADENA'],
      %w[BALOTTO BALOTTO],
      ['BOTON DE PAGOS', 'BOTON DE PAGOS'],
      %w[OFICINA OFICINA],
      %w[TRANSFERENCIA TRANSFERENCIA],
      %w[CONSIGNACION CONSIGNACION]
    ]
  end

  def select_entidad
    [
      %w[BANCOLOMBIA BANCOLOMBIA],
      %w[BBVA BBVA],
      %w[CITIBANK CITIBANK],
      %w[DAVIVIENDA DAVIVIENDA],
      %w[FCPII FCPII],
      ['BANCO CAJA SOCIAL', 'BANCO CAJA SOCIAL'],
      ['BANCO AGRARIO', 'BANCO AGRARIO'],
      ['BANCO COLPATRIA', 'BANCO COLPATRIA'],
      %w[CONFIAR CONFIAR],
      ['BANCO DE OCCIDENTE', 'BANCO DE OCCIDENTE'],
      %w[FIDUCENTRAL FIDUCENTRAL]
    ]
  end

  def select_modelo
    [
      ['CUOTA CONSTANTE', 'CUOTA CONSTANTE'],
      ['ABONO CONSTANTE CAPITAL CON INTERESES', 'ABONO CONSTANTE CAPITAL CON INTERESES'],
      ['PLAN DE PAGOS FLEXIBLE', 'PLAN DE PAGOS FLEXIBLE']
    ]
  end

  def select_tipo_afecta
    [
      ['AJUSTE CUOTA', 'AJUSTE CUOTA'],
      ['AJUSTE PLAZO', 'AJUSTE PLAZO']
    ]
  end

  def select_tipo_afectaajuste
    [
      ['AJUSTE CUOTA', 'AJUSTE CUOTA'],
      ['AJUSTE PLAZO', 'AJUSTE PLAZO'],
      ['AJUSTE', 'AJUSTE AUTOMATICO']
    ]
  end

  def select_tipo_resoljud
    [
      %w[ACUERDO ACUERDO],
      %w[CANCELACION CANCELACION],
      %w[REMATE REMATE]
    ]
  end

  def select_tipo_obsresoljud
    [
      ['RETRASO POR JUEZ', 'RETRASO POR JUEZ'],
      ['RETRASO POR TASADOR', 'RETRASO POR TASADOR'],
      ['RETRASO MARTILLEROS', 'RETRASO MARTILLEROS'],
      ['RETRASO UBICACION DE PARTES', 'RETRASO UBICACION DE PARTES'],
      ['DEUDOR LITIGANTE', 'DEUDOR LITIGANTE'],
      ['PROCESO COMPLEJO', 'PROCESO COMPLEJO'],
      %w[OTROS OTROS]
    ]
  end

  def select_tipo_accion
    [
      ['IMPULSO PROCESAL', 'IMPULSO PROCESAL'],
      ['CONTACTO AL CLIENTE', 'CONTACTO AL CLIENTE']
    ]
  end

  def select_tipo_afectafit
    [
      ['PAGO NORMAL', 'PAGO NORMAL'],
      %w[AMORTIZACION AMORTIZACION]
    ]
  end

  def select_tipopago
    [
      %w[EFECTIVO EFECTIVO],
      %w[CHEQUE CHEQUE],
      %w[CONSIGNACION CONSIGNACION]
    ]
  end

  def select_tipopagofit
    [
      %w[EFECTIVO EFECTIVO],
      %w[CHEQUE CHEQUE],
      %w[CONSIGNACION CONSIGNACION],
      ['DEBITO AUTOMATICO', 'DEBITO AUTOMATICO']
    ]
  end

  def select_tipopagosistem
    [
      %w[EFECTIVO EFECTIVO],
      %w[CHEQUE CHEQUE],
      ['DACIÓN EN PAGO', 'DACION EN PAGO'],
      %w[REMATE REMATE],
      ['VENTA DE DERECHOS', 'VENTA DE DERECHOS'],
      %w[RECOMPRA RECOMPRA],
      %w[SUSTITUCIÓN SUSTITUCION],
      %w[SEGUROS SEGUROS],
      ['TRASLADO DEL ORIGINADOR', 'TRASLADO DEL ORIGINADOR'],
      ['TÍTULO JUDICIAL CXC', 'TITULO JUDICIAL CXC'],
      ['TÍTULO JUDICIAL BANCO', 'TITULO JUDICIAL BANCO'],
      ['HONORARIOS DE ABOGADO', 'HONORARIOS DE ABOGADO']
    ]
  end

  def select_tipopagokfg
    [
      %w[EFECTIVO EFECTIVO],
      %w[CHEQUE CHEQUE]
    ]
  end

  def select_cuenta
    is_select_cuenta
  end

  def select_clasepago
    [
      %w[ABONO ABONO],
      ['PAGO TOTAL', 'PAGO TOTAL'],
      ['NO APLICA', 'NO APLICA']
    ]
  end

  def select_formapago
    [
      %w[EFECTIVO EFECTIVO],
      %w[CONSIGNACION CONSIGNACION],
      %w[TRANSFERENCIA TRANSFERENCIA],
      %w[CHEQUE CHEQUE]
    ]
  end

  def select_claseagenda
    [
      %w[AUDIENCIAS AUDIENCIAS],
      ['PASO A INSTANCIA JURIDICA', 'PASO A INSTANCIA JURIDICA'],
      ['RECORDACION DE LLAMADA', 'RECORDACION DE LLAMADA'],
      ['VERIFICACION DE PAGO', 'VERIFICACION DE PAGO'],
      ['VENCIMIENTO DE TERMINOS', 'VENCIMIENTO DE TERMINOS'],
      ['VISITA DOMICILIARIA', 'VISITA DOMICILIARIA'],
      ['VISITA A SITIO LABORAL', 'VISITA A SITIO LABORAL'],
      ['AGENDAR VISITA AL INMUEBLE', 'AGENDAR VISITA AL INMUEBLE'],
      ['LLAMADA GESTION COMERCIAL', 'LLAMADA GESTION COMERCIAL']

    ]
  end

  def select_diashabilitados
    [
      ['1', 1],
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5],
      ['6', 6],
      ['7', 7],
      ['8', 8],
      ['9', 9],
      ['10', 10],
      ['11', 11],
      ['12', 12],
      ['13', 13],
      ['14', 14],
      ['15', 15],
      ['16', 16],
      ['17', 17],
      ['18', 18],
      ['19', 19],
      ['20', 20],
      ['21', 21],
      ['22', 22],
      ['23', 23],
      ['24', 24],
      ['25', 25],
      ['26', 26],
      ['27', 27],
      ['28', 28],
      ['29', 29],
      ['30', 30]
    ]
  end

  def select_pagaduria
    is_select_pagaduria
  end

  def select_cooperativa
    is_select_cooperativa
  end

  def select_inversionista
    is_select_inversionista
  end

  def select_estadopagaduria
    [
      ['FALLECIMIENTO DEUDOR', 'FALLECIMIENTO DEUDOR'],
      ['EMBARGO SALARIAL CON PRELACIÓN LEGAL', 'EMBARGO SALARIAL CON PRELACIÓN LEGAL'],
      ['DEUDOR DESVINCULADO LABORALMENTE', 'DEUDOR DESVINCULADO LABORALMENTE'],
      ['EMPRESA PAGADURÍA ILIQUIDA', 'EMPRESA PAGADURÍA ILIQUIDA'],
      ['EMPRESA PAGADURÍA EN PROCESO LIQUIDATORIO', 'EMPRESA PAGADURÍA EN PROCESO LIQUIDATORIO']
    ]
  end

  def select_tipogestioncovinoc
    [
      ['SIN GESTION', 'SIN GESTION'],
      %w[DIRECTO DIRECTO],
      %w[INDIRECTO INDIRECTO],
      %w[ILOCALIZADO ILOCALIZADO],
      ['NO CONTACTADO', 'NO CONTACTADO'],
      %w[OTROS OTROS]
    ]
  end

  def select_razonespago
    is_select_razonespago
  end

  def select_tipodeudor
    [
      %w[DEUDOR DEUDOR],
      %w[CODEUDOR CODEUDOR]
    ]
  end

  def select_modelog
    [
      ['PLAN DE PAGOS FLEXIBLE', 'PLAN DE PAGOS FLEXIBLE']
    ]
  end

  ######################  Andres 20160909 ###########
  def select_originador
    is_select_originador
  end

  def select_rango
    [
      ['Menos de 1.000.000', '0 and 1000000'],
      ['1.000.001 a 3.000.000', '1000001 and 3000000'],
      ['3.000.001 a 5.000.000', '3000001 and 5000000'],
      ['5.000.001 a 10.000.000', '5000001 and 10000000'],
      ['10.000.001 a 20.000.000', '10000001 and 20000000'],
      ['20.000.001 a 50.000.000', '20000001 and 50000000'],
      ['50.000.001 a 100.000.000', '50000001 and 100000000'],
      ['Mayor de 100.000.000', '100000001 and 1000000000']
    ]
  end

  def select_rangotele
    [
      ['Menos de 50.000', '0 and 50000'],
      ['50.001 a 100.000', '50001 and 100000'],
      ['100.001 a 150.000', '100001 and 150000'],
      ['150.001 a 200.000', '150001 and 200000'],
      ['200.001 a 300.000', '200001 and 300000'],
      ['300.001 a 500.000', '300001 and 500000'],
      ['500.001 a 750.000', '500001 and 750000'],
      ['750.001 a 1.000.000', '750001 and 1000000'],
      ['1.000.001 a 3.000.000', '1000001 and 3000000'],
      ['3.000.001 a 5.000.000', '3000001 and 5000000'],
      ['5.000.001 a 10.000.000', '5000001 and 10000000'],
      ['10.000.001 a 20.000.000', '10000001 and 20000000'],
      ['20.000.001 a 50.000.000', '20000001 and 50000000'],
      ['50.000.001 a 100.000.000', '50000001 and 100000000'],
      ['Mayor de 100.000.000', '100000001 and 10000000000']
    ]
  end

  def select_rangocisa
    [
      ['Menor o igual a 300.000', '0 and 300000'],
      ['300.001 a 1.000.000', '300001 and 1000000'],
      ['1.000.001 a 5.000.000', '1000001 and 5000000'],
      ['5.000.001 a 10.000.000', '5000001 and 10000000'],
      ['Mas de 10.000.000', '10000001 and 100000000']
    ]
  end

  def select_estadosdecision
    [
      %w[APROBADO APROBAR],
      %w[PENDIENTE PENDIENTE],
      %w[RECHAZADO RECHAZAR],
      %w[RECOMENDADO RECOMENDAR]
    ]
  end

  def select_estadosdecision2
    [
      %w[APROBADO APROBAR],
      %w[RECHAZADO RECHAZAR]
    ]
  end

  def select_estadosdecisionprimera
    [
      %w[RECHAZADO RECHAZAR],
      %w[RECOMENDADO RECOMENDAR]
    ]
  end

  def select_rangousd
    [
      ['Menos de 500', '0 and 500'],
      ['501 a 1.000', '501 and 1000'],
      ['1.001 a 3.000', '1001 and 3000'],
      ['3.001 a 5.000', '3001 and 5000'],
      ['5.001 a 10.000', '5001 and 10000'],
      ['10.001 a 20.000', '10001 and 20000'],
      ['20.001 a 50.000', '20001 and 50000'],
      ['Mayor de 50.000', '50001 and 2000000000']
    ]
  end

  def select_rangoper
    [
      ['Menos de 1.500', '0 and 1500'],
      ['1.501 a 3.000', '1501 and 3000'],
      ['3.001 a 15.000', '3001 and 15000'],
      ['15.001 a 30.000', '15001 and 30000'],
      ['30.001 a 60.000', '30001 and 60000'],
      ['60.001 a 150.000', '60001 and 150000'],
      ['150.001 a 300.000', '150001 and 300000'],
      ['Mayor de 300.000', '300001 and 1000000000']
    ]
  end

  def select_fechapagos
    [
      ['1 Mes', '30'],
      ['2 Meses', '60'],
      ['3 Meses', '90'],
      ['4 Meses', '120'],
      ['5 Meses', '150'],
      ['6 Meses', '180'],
      ['7 Meses', '210'],
      ['8 Meses', '240'],
      ['9 Meses', '270'],
      ['10 Meses', '300'],
      ['11 Meses', '330'],
      ['12 Meses', '360']
    ]
  end

  def select_tipogarantia
    [
      %w[PERSONAL PERSONAL],
      ['REGISTRO HIPOTECA', 'REGISTRO HIPOTECA'],
      ['REGISTRO PREDIAL', 'REGISTRO PREDIAL'],
      ['SIN GARANTIA', 'SIN GARANTIA']
    ]
  end

  def select_sinocorto
    [
      %w[SI S],
      %w[NO N]
    ]
  end

  def select_sn_users
    [
      %w[SI S],
      %w[NO N]
    ]
  end

  def select_tipoconsulta
    [
      %w[ADMINISTRADOR ADMINISTRADOR],
      %w[GESTION GESTION],
      %w[PERSONA PERSONA],
      %w[ESTUDIANTE ESTUDIANTE],
      %w[TODO TODO]
    ]
  end

  def select_estado
    [
      %w[ACTIVO ACTIVO],
      %w[INACTIVO INACTIVO]
    ]
  end

  def select_estado_ac
    [
      %w[ACTIVO ACTIVO],
      %w[INACTIVO INACTIVO]
    ]
  end

  def select_categoria_documentos
    [
      %w[SOCIOECONÓMICOS SOCIOECONÓMICOS],
      %w[ACADÉMICOS ACADÉMICOS],
      %w[FINANCIEROS FINANCIEROS]
    ]
  end

  def select_estado_portafolios
    [
      %w[ACTIVO ACTIVO],
      %w[INACTIVO INACTIVO]
    ]
  end

  def select_estadoestudiante
    [
      %w[ACTIVO ACTIVO],
      ['EN PROCESO', 'EN PROCESO'],
      %w[INACTIVO INACTIVO],
      ['RETIRO FINANCIERO', 'RETIRO FINANCIERO'],
      ['RETIRO ACADEMICO', 'RETIRO ACADEMICO'],
      %w[GRADUADO GRADUADO],
      %w[FALLECIDO FALLECIDO]
    ]
  end

  def select_estadoestudiante2
    [
      %w[ACTIVO ACTIVO],
      %w[INACTIVO INACTIVO]
    ]
  end

  def select_tiponovacion
    [
      ['ACUERDO DE PAGO CONTADO', 'ACUERDO DE PAGO CONTADO'],
      ['ACUERDO DE PAGO PLAZO', 'ACUERDO DE PAGO PLAZO'],
      %w[NOVACION NOVACION]
    ]
  end

  def select_estadonovacion
    [
      %w[PENDIENTE PENDIENTE],
      %w[INCUMPLIDO INCUMPLIDO],
      ['EN MORA', 'EN MORA'],
      ['AL DIA', 'AL DIA'],
      ['NO VIGENTE', 'NO VIGENTE'],
      %w[CUMPLIDO CUMPLIDO]
    ]
  end

  def select_unidad_denominacion
    [
      %w[DOLARES USD],
      %w[SOLES SOLES],
      %w[EUROS EUROS]
    ]
  end

  def select_unidad_denominacioncuenta
    [
      %w[DOLARES USD],
      %w[SOLES SOLES],
      %w[EUROS EUROS],
      %w[PESOS COP],
      %w[PESOS COP],
      %w[LEMPIRA HNL]
    ]
  end

  def select_unidad_denominacion_gps
    [
      %w[DOLARES USD],
      %w[SOLES SOLES]
    ]
  end

  def select_mes
    [
      %w[ENERO 01],
      %w[FEBRERO 02],
      %w[MARZO 03],
      %w[ABRIL 04],
      %w[MAYO 05],
      %w[JUNIO 06],
      %w[JULIO 07],
      %w[AGOSTO 08],
      %w[SEPTIEMBRE 09],
      %w[OCTUBRE 10],
      %w[NOVIEMBRE 11],
      %w[DICIEMBRE 12]
    ]
  end

  def select_anno
    [
      %w[2020 2020],
      %w[2021 2021],
      %w[2022 2022],
      %w[2023 2023]
    ]
  end

  def select_mesedu
    [
      %w[DICIEMBRE 12]
    ]
  end

  def select_annoedu
    [
      %w[2018 2018]
    ]
  end

  def select_anno2
    [
      %w[2020 2020],
      %w[2021 2021],
      %w[2022 2022],
      %w[2023 2023]
    ]
  end

  def select_anno4
    [
      %w[2020 2020],
      %w[2021 2021],
      %w[2022 2022],
      %w[2023 2023]
    ]
  end

  def select_annorenta
    [
      %w[2013 2013],
      %w[2014 2014],
      %w[2015 2015],
      %w[2016 2016],
      %w[2017 2017],
      %w[2018 2018]
    ]
  end

  def select_anno3
    [
      %w[2013 2013],
      %w[2014 2014],
      %w[2015 2015],
      %w[2016 2016],
      %w[2017 2017],
      %w[2018 2018],
      %w[2019 2019]
    ]
  end

  def select_nivel
    [
      ['GESTION', 1],
      ['CARGUES', 6],
      ['PROCESOS', 2],
      ['PARAMETRIZACIÓN', 3],
      ['SEGURIDAD', 4],
      ['PARAMETRIZACIÓN EDUCACIÓN', 5]
    ]
  end

  def select_tiporecaudo
    [
      ['HONORARIOS DE ABOGADO', 'HONORARIOS DE ABOGADO'],
      ['GASTOS JUDICIALES', 'GASTOS JUDICIALES'],
      ['PAZ Y SALVO', 'PAZ Y SALVO'],
      %w[OTROS OTROS]
    ]
  end

  def select_tiporeq
    [
      ['NUEVO DESARROLLO', 'NUEVO DESARROLLO'],
      ['INCONSISTENCIA EN NORMALIZACION', 'INCONSISTENCIA EN NORMALIZACION'],
      ['INCONSISTENCIA EN RECAUDOS', 'INCONSISTENCIA EN RECAUDOS'],
      ['INCONSISTENCIA EN GESTIONES', 'INCONSISTENCIA EN GESTIONES'],
      ['INCONSISTENCIA EN NOVACIONES', 'INCONSISTENCIA EN NOVACIONES'],
      ['INCONSISTENCIA EN PERSONAS', 'INCONSISTENCIA EN PERSONAS'],
      ['INCONSISTENCIA EN ASIGNACIONES', 'INCONSISTENCIA EN ASIGNACIONES'],
      ['INCONSISTENCIA EN REPORTES', 'INCONSISTENCIA EN REPORTES'],
      ['INCONSISTENCIA EN OBLIGACION', 'INCONSISTENCIA EN OBLIGACION'],
      %w[MEJORA MEJORA],
      ['CREACION DE USUARIOS', 'CREACION DE USUARIOS'],
      %w[SOPORTES SOPORTES]
    ]
  end

  def select_prioridad
    [
      %w[EXTREMO EXTREMO],
      %w[ALTA ALTA],
      %w[MEDIA MEDIA],
      %w[BAJA BAJA]
    ]
  end

  def select_calificacion_soporte2
    [
      ['3', 3],
      ['2', 2],
      ['1', 1]
    ]
  end

  def select_portafolioscuenta
    is_select_portafolioscuenta
  end

  def select_portafolios
    is_select_portafolios
  end

  def select_sucursal(portafolioid)
    is_select_sucursal(portafolioid)
  end

  def nombresucursal(value)
    Portafoliossucursal.select(:descripcion).find(value)
  end

  def select_niveleducativo
    [
      %w[TECNICO TECNICO],
      %w[TECNOLOGICO TECNOLOGICO],
      %w[UNIVERSITARIO UNIVERSITARIO],
      %w[POSGRADO POSGRADO]
    ]
  end

  def select_periodicidad
    [
      %w[SEMESTRAL SEMESTRAL],
      %w[ANUAL ANUAL]
    ]
  end

  def select_semestre
    [
      %w[2007-1 2007-1],
      %w[2007-2 2007-2],
      %w[2008-1 2008-1],
      %w[2008-2 2008-2],
      %w[2009-1 2009-1],
      %w[2009-2 2009-2],
      %w[2010-1 2010-1],
      %w[2010-2 2010-2],
      %w[2011-1 2011-1],
      %w[2011-2 2011-2],
      %w[2012-1 2012-1],
      %w[2012-2 2012-2],
      %w[2013-1 2013-1],
      %w[2013-2 2013-2],
      %w[2014-1 2014-1],
      %w[2014-2 2014-2],
      %w[2015-1 2015-1],
      %w[2015-2 2015-2],
      %w[2016-1 2016-1],
      %w[2016-2 2016-2],
      %w[2017-1 2017-1],
      %w[2017-2 2017-2]
    ]
  end

  def select_motivonofinalizo
    [
      ['FINALIZACIÓN DEL PROGRAMA ACADÉMICO', 'FINALIZACIÓN DEL PROGRAMA ACADÉMICO'],
      ['LIMITE DE SUSPENSIONES TEMPORALES', 'LIMITE DE SUSPENSIONES TEMPORALES'],
      ['ABANDONO INJUSTIFICADO DEL PROGRAMA', 'ABANDONO INJUSTIFICADO DEL PROGRAMA'],
      %w[OTRO OTRO]
    ]
  end

  def select_rangocalendar
    [2017, 2018]
  end

  def select_userhora
    [
      ['07:00 a.m.', '07:00:00'],
      ['07:30 a.m.', '07:30:00'],
      ['08:00 a.m.', '08:00:00'],
      ['08:30 a.m.', '08:30:00'],
      ['09:00 a.m.', '09:00:00'],
      ['09:30 a.m.', '09:30:00'],
      ['10:00 a.m.', '10:00:00'],
      ['10:30 a.m.', '10:30:00'],
      ['11:00 a.m.', '11:00:00'],
      ['11:30 a.m.', '11:30:00'],
      ['12:00 p.m.', '12:00:00'],
      ['12:30 p.m.', '12:30:00'],
      ['01:00 p.m.', '13:00:00'],
      ['01:30 p.m.', '13:30:00'],
      ['02:00 p.m.', '14:00:00'],
      ['02:30 p.m.', '14:30:00'],
      ['03:00 p.m.', '15:00:00'],
      ['03:30 p.m.', '15:30:00'],
      ['04:00 p.m.', '16:00:00'],
      ['04:30 p.m.', '16:30:00'],
      ['05:00 p.m.', '17:00:00'],
      ['05:30 p.m.', '17:30:00'],
      ['06:00 p.m.', '18:00:00'],
      ['06:30 p.m.', '18:30:00'],
      ['07:00 p.m.', '19:00:00']
    ]
  end

  def select_userpersonal
    [
      ['1', 1],
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5],
      ['6', 6],
      ['7', 7],
      ['8', 8]
    ]
  end

  def select_tasas2gca
    is_select_tasas2gca
    #     [
    #       ["Quirografaria","1"],
    #       ["Un codeudor laborando","2"],
    #       ["Dos codeudores laborando ó un codeudor con finca raiz","3"],
    #       ["Garantía Prendaria","4"],
    #       ["Garantia Hipotecaria","5"],
    #       ["Dos (2) codeudores laborando / un (1) codeudor con finca raiz + un (1) codeudor laborando",6],
    #       ["Garantía prendaria + un (1) codeudor laborando",7],
    #       ["Garantía hipotecaria + un (1) codeudor laborando",8],
    #       ["Dos (2) codeudores laborando / un (1) codeudor con finca raiz + dos (2) codeudores laborando / un (1) codeudor con finca raiz",9],
    #       ["Dos (2) codeudores laborando / un (1) codeudor con finca raiz+garantía prendaria",10],
    #       ["Dos (2) codeudores laborando / un (1) codeudor con finca raiz+garantía hipotecaria",11],
    #       ["Garantía prendaria + garantía prendaria",12],
    #       ["Garantía prendaria + garantía hipotecaria",13],
    #       ["Garantía hipotecaria + garantía hipotecaria",14]
    #     ]
  end

  def select_userintervalo
    [
      ['10 Minutos', 10],
      ['15 Minutos', 15],
      ['20 Minutos', 20],
      ['30 Minutos', 30],
      ['45 Minutos', 45],
      ['60 Minutos', 60]
    ]
  end

  def select_formapagohelena
    [
      %w[EFECTIVO EFECTIVO],
      %w[CONSIGNACION CONSIGNACION]
    ]
  end

  def select_tipoinmueble
    [
      %w[APARTAMENTO APARTAMENTO],
      ['APARTAMENTO USADO', 'APARTAMENTO USADO'],
      %w[BODEGA BODEGA],
      %w[CASA CASA],
      ['CASA USADA', 'CASA USADA'],
      %w[CONSULTORIO CONSULTORIO],
      %w[EDIFICIO EDIFICIO],
      %w[FINCA FINCA],
      %w[HOTEL HOTEL],
      %w[LOCAL LOCAL],
      %w[LOTE LOTE],
      %w[OFICINA OFICINA],
      %w[PARQUEADERO PARQUEADERO],
      %w[OTRO OTRO]
    ]
  end

  def select_tipohipoteca
    [
      %w[ABIERTA ABIERTA],
      ['ABIERTA DE CUANTIA INDETERMINADA', 'ABIERTA DE CUANTIA INDETERMINADA'],
      %w[CERRADA CERRADA],
      %w[GENERAL GENERAL],
      %w[ESPECIFICA ESPECIFICA]
    ]
  end

  def select_tipoafectacion
    [
      ['AFECTACION A VIVIENDA FAMILIAR', 'AFECTACION A VIVIENDA FAMILIAR'],
      ['CONDICION RESOLUTORIA', 'CONDICION RESOLUTORIA'],
      ['PATRIMONIO DE FAMILIA INEMBARGABLE', 'PATRIMONIO DE FAMILIA INEMBARGABLE'],
      %w[USUFRUCTO USUFRUCTO]
    ]
  end

  def select_origen
    [
      %w[MULTA MULTA],
      %w[SANCION SANCION],
      %w[TRIBUTO TRIBUTO],
      %w[SENTENCIA SENTENCIA],
      %w[RENTA RENTA],
      %w[CAUCION CAUCION]
    ]
  end

  def select_nomenclatura
    [
      %w[AUTOPISTA AUTOPISTA],
      %w[AVENIDA AVENIDA],
      ['AVENIDA CALLE', 'AVENIDA CALLE'],
      ['AVENIDA CARRERA', 'AVENIDA CARRERA'],
      %w[BULEVAR BULEVAR],
      %w[CALLE CALLE],
      %w[CARRERA CARRERA],
      %w[CIRCULAR CIRCULAR],
      %w[KILOMETRO KILOMETRO],
      %w[CIRCUNVALAR CIRCUNVALAR],
      ['CTAS CORRIDAS', 'CTAS CORRIDAS'],
      %w[DIAGONAL DIAGONAL],
      %w[PASAJE PASAJE],
      %w[PASEO PASEO],
      %w[PEATONAL PEATONAL],
      %w[TRANSVERSAL TRANSVERSAL],
      %w[TRONCAL TRONCAL],
      %w[VARIANTE VARIANTE],
      %w[VIA VIA]
    ]
  end

  def select_nomenclaturaletra
    [
      %w[SUR SUR],
      %w[NORTE NORTE],
      %w[ESTE ESTE],
      %w[OESTE OESTE],
      %w[BIS BIS]
    ]
  end

  def select_porcentaje
    [
      ['5%', 5],
      ['10%', 10],
      ['15%', 15],
      ['16%', 16],
      ['17%', 17],
      ['18%', 18],
      ['19%', 19],
      ['20%', 20],
      ['21%', 21],
      ['22%', 22],
      ['23%', 23],
      ['24%', 24],
      ['25%', 25],
      ['26%', 26],
      ['27%', 27],
      ['28%', 28],
      ['29%', 29],
      ['30%', 30],
      ['31%', 31],
      ['32%', 32],
      ['33%', 33],
      ['34%', 34],
      ['35%', 35],
      ['36%', 36],
      ['37%', 37],
      ['38%', 38],
      ['39%', 39],
      ['40%', 40],
      ['41%', 41],
      ['42%', 42],
      ['43%', 43],
      ['44%', 44],
      ['45%', 45],
      ['46%', 46],
      ['47%', 47],
      ['48%', 48],
      ['49%', 49],
      ['50%', 50],
      ['51%', 51],
      ['52%', 52],
      ['53%', 53],
      ['54%', 54],
      ['55%', 55],
      ['56%', 56],
      ['57%', 57],
      ['58%', 58],
      ['59%', 59],
      ['60%', 60]
    ]
  end

  def select_plazoinicial
    [
      ['1', 1],
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5],
      ['6', 6],
      ['7', 7],
      ['8', 8],
      ['9', 9],
      ['10', 10],
      ['11', 11],
      ['12', 12],
      ['13', 13],
      ['14', 14],
      ['15', 15],
      ['16', 16],
      ['17', 17],
      ['18', 18],
      ['19', 19],
      ['20', 20],
      ['21', 21],
      ['22', 22],
      ['23', 23],
      ['24', 24]
    ]
  end

  def select_calificaciontelefono
    [
      %w[APAGADO APAGADO],
      ['DIRECCION ERRADA', 'DIRECCION ERRADA'],
      ['DIRECCION NO EXISTE', 'DIRECCION NO EXISTE'],
      ['DIRECCION TITULAR', 'DIRECCION TITULAR'],
      %w[ERRADO ERRADO],
      %w[FALLECIDO FALLECIDO],
      ['NO ABREN PUERTA', 'NO ABREN PUERTA'],
      ['NO CONTESTAN', 'NO CONTESTAN'],
      ['NO EXISTE', 'NO EXISTE'],
      %w[TERCERO TERCERO],
      %w[TITULAR TITULAR],
      ['ZONA PELIGROSA', 'ZONA PELIGROSA']
    ]
  end

  def select_estadosdeudor
    is_select_estadosdeudor
  end

  def select_tiposgestion
    [
      %w[COBRANZA COBRANZA],
      %w[VIRTUAL VIRTUAL]
    ]
  end

  def active_class(link_path)
    current_page?(link_path) ? 'active' : ''
  end

  def camponumerico(valor)
      number_to_currency(valor, precision: 2, unit: '', delimiter: '.')
  end

  def select_zona
    [
      %w[LIMA LIMA],
      %w[PROVINCIA PROVINCIA]
    ]
  end

  def select_vehiculo(portafolioid)
    is_select_vehiculo(portafolioid)
  end

  def select_capacidadex
    [
      ['NO APLICA', 'NO APLICA'],
      ['TALENTO EXCEPCIONAL GENERAL', 'TALENTO EXCEPCIONAL GENERAL'],
      ['TALENTO EXCEPCIONAL ESPECÍFICO', 'TALENTO EXCEPCIONAL ESPECÍFICO']
    ]
  end

  def select_zonaedu
    [
      %w[URBANA URBANA],
      %w[RURAL RURAL]
    ]
  end

  def select_medio
    [
      ['ALGUIEN LE CONTÓ', 'ALGUIEN LE CONTÓ'],
      ['LE ENTREGARON UN VOLANTE', 'LE ENTREGARON UN VOLANTE'],
      ['LO LLAMARON', 'LO LLAMARON'],
      ['MEDIOS DE COMUNICACIÓN (RADIO, TV O PRENSA)', 'MEDIOS DE COMUNICACIÓN (RADIO, TV O PRENSA)'],
      ['PASABA POR EL LOCAL', 'PASABA POR EL LOCAL'],
      ['PLAN AMIGOS', 'PLAN AMIGOS'],
      ['REDES SOCIALES O PAGINA WEB', 'REDES SOCIALES O PAGINA WEB'],
      ['TRABAJA EN EDUPOL', 'TRABAJA EN EDUPOL']
    ]
  end

  def select_origendineropago
    [
      ['RECURSOS PROPIOS', 'RECURSOS PROPIOS'],
      ['FINANCIACIÓN TERCERO', 'FINANCIACIÓN TERCERO'],
      %w[EDUPOL EDUPOL]
    ]
  end

  def select_actividadeconomica
    [
      %w[NINGUNA NINGUNA],
      %w[EMPLEADO EMPLEADO],
      %w[INDEPENDIENTE INDEPENDIENTE],
      %w[DESEMPLEADO DESEMPLEADO],
      %w[INFORMAL INFORMAL]
    ]
  end

  def select_tipovivienda
    [
      %w[PROPIA PROPIA],
      %w[FAMILIAR FAMILIAR],
      %w[ARRIENDO ARRIENDO]
    ]
  end

  def tipo_solicitud
    [
      ['NUEVO (POR PRIMERA VEZ)', 'NUEVO (POR PRIMERA VEZ)'],
      %w[REINGRESO REINGRESO],
      %w[RENOVACION RENOVACION]
    ]
  end

  def select_tipodocproceso
    [
      %w[LEGALIZACIÓN LEGALIZACION],
      %w[RENOVACIÓN RENOVACION]
    ]
  end

  def select_bandeja
    [
      %w[INCOMPLETA PENDIENTE],
      %w[RADICADA ENVIADA],
      %w[APROBADA APROBADA],
      %w[RECHAZADA RECHAZADA],
      %w[DEVUELTA DEVOLUCIONES]
    ]
  end

  def select_estadocredito
    [
      ['AL DIA', 'AL DIA'],
      ['EN MORA', 'EN MORA'],
      %w[VENCIDO VENCIDO],
      %w[CASTIGADA CASTIGADA],
      %w[CANCELADO CANCELADO]
    ]
  end

  def select_tipoprograma
    [
      %w[FORMAL FORMAL],
      ['NO FORMAL', 'NO FORMAL']
    ]
  end

  def select_formapago
    [
      %w[CONTADO CONTADO],
      %w[FINANCIACION FINANCIACION],
      %w[AMBOS AMBOS]
    ]
  end

  def select_estrato
    [
      %w[0 0],
      %w[1 1],
      %w[2 2],
      %w[3 3],
      %w[4 4],
      %w[5 5],
      %w[6 6]
    ]
  end

  def select_gruposang
    [
      ['O+', 'O+'],
      ['O-', 'O-'],
      ['A+', 'A+'],
      ['A-', 'A-'],
      ['B+', 'B+'],
      ['B-', 'B-'],
      ['AB+', 'AB+'],
      ['AB-', 'AB-']
    ]
  end

  def tiposgatos
    [
      %w[FACTURA FACTURA],
      %w[BOLETA BOLETA],
      ['RECIBO POR HONORARIOS', 'RECIBO POR HONORARIOS'],
      %w[COMPROBANTE COMPROBANTE]
    ]
  end

  def select_denomincacion
    [
      %w[COP COP],
      %w[UVR UVR],
      %w[USD USD],
      %w[SOLES PEN],
      %w[EUROS EUR]
    ]
  end

  def selectformapagoedu
    [
      ['AJUSTE POR TRASLADO ESTUDIO EDUPOL', 'AJUSTE POR TRASLADO ESTUDIO EDUPOL'],
      %w[AJUSTE AJUSTE],
      %w[BECA BECA],
      %w[CESANTIAS CESANTIAS],
      %w[CHEQUES CHEQUES],
      ['CRUCE CON UNIVERSIDADES', 'CRUCE CON UNIVERSIDADES'],
      ['DESCUENTO POR NOMINA', 'DESCUENTO POR NOMINA'],
      %w[ICETEX ICETEX],
      ['PAGO EN BANCO', 'PAGO EN BANCO'],
      ['PAGO EN BANCO BANCOLOMBIA', 'PAGO EN BANCO BANCOLOMBIA'],
      ['PAGO EN BANCO DAVIVIENDA', 'PAGO EN BANCO DAVIVIENDA'],
      ['PAGO EN BANCO BANCO DE BOGOTA', 'PAGO EN BANCO BANCO DE BOGOTA '],
      ['PAGO EN BANCO COLPATRIA', 'PAGO EN BANCO COLPATRIA'],
      ['PAGO EN BANCO BANCO AGRARIO', 'PAGO EN BANCO BANCO AGRARIO'],
      ['PAGO EN EFECTIVO', 'PAGO EN EFECTIVO'],
      ['PAGO POR TARJETA DE CREDITO', 'PAGO POR TARJETA DE CREDITO'],
      ['PAGO PSE TRANSFERENCIA BANCARIA', 'PAGO PSE TRANSFERENCIA BANCARIA'],
      ['PAYU BOTONES', 'PAYU BOTONES'],
      ['PAYU RECAUDOS', 'PAYU RECAUDOS'],
      ['PAYU WEB CHECKOUT', 'PAYU WEB CHECKOUT'],
      ['PLAN AMIGOS', 'PLAN AMIGOS'],
      %w[RE-CLASIFICACIÓN RE-CLASIFICACION],
      ['TRASLADO VALOR ABONO A CUOTAS 2018-1', 'TRASLADO VALOR ABONO A CUOTAS 2018-1'],
      ['TRASLADO VALOR ESTUDIO EDUPOL (NO REEMBOLSABLE) 2018-1', 'TRASLADO VALOR ESTUDIO EDUPOL (NO REEMBOLSABLE) 2018-1'],
      ['TRASLADO VALOR ESTUDIO EDUPOL (NO REEMBOLSABLE) DE 2018-2', 'TRASLADO VALOR ESTUDIO EDUPOL (NO REEMBOLSABLE) DE 2018-2'],
      ['TRASLADO VALOR ABONO CUOTAS DE 2018-2', 'TRASLADO VALOR ABONO CUOTAS DE 2018-2'],
      ['SALDO DE SEMESTRES ANTERIORES', 'SALDO DE SEMESTRES ANTERIORES'],
      ['UTILIDADES DEL CAU', 'UTILIDADES DEL CAU'],
      ['DESCUENTO POR ALIANZA', 'DESCUENTO POR ALIANZA'],
      ['DESCUENTO COMERCIAL PROFESIONALIZANTE', 'DESCUENTO COMERCIAL PROFESIONALIZANTE']
    ]
  end

  def select_estadogastos
    [
      %w[SOLICITADO SOLICITADO],
      ['NO APROBADO', 'NO APROBADO'],
      ['RECHAZADO REEMBOLSO/GIRO', 'RECHAZADO REEMBOLSO/GIRO'],
      ['ENVIO REEMBOLSO/GIRO', 'ENVIO REEMBOLSO/GIRO'],
      ['REEMBOLSO/GIRO', 'REEMBOLSO/GIRO'],
      ['REPORTE FORMATO REEMBOLSO', 'REPORTE FORMATO REEMBOLSO']
    ]
  end

  def select_estadogastosreo
    [
      %w[SOLICITADO SOLICITADO],
      %w[APROBADO APROBADO],
      ['NO APROBADO', 'NO APROBADO'],
      ['CON OBSERVACION', 'CON OBSERVACION'],
      %w[ENVIADO ENVIADO],
      %w[PROCESADO PROCESADO],
      %w[RECHAZADO RECHAZADO]
    ]
  end

  def select_caracteristicatitulo_gps
    [
      ['EJECUCIÓN DE GARANTÍA INMOBILIARIA- EGI', 'EJECUCIÓN DE GARANTÍA INMOBILIARIA- EGI'],
      ['PRUEBA ANTICIPADA', 'PRUEBA ANTICIPADA'],
      ['OBLIGACIÓN DE DAR SUMA DE DINERO - ODSD', 'OBLIGACIÓN DE DAR SUMA DE DINERO - ODSD']
    ]
  end

  def select_tipojuzgado_gps
    [
      %w[JM JM],
      %w[JPL JPL],
      %w[JC JC],
      %w[JCC JCC]
    ]
  end

  def select_forma_vmn
    [
      ['POR ORIGINADOR SALDO CAPITAL', 'ORIGINADORSALDOCAPITAL'],
      ['POR ORIGINADOR SALDO TOTAL', 'ORIGINADORSALDOTOTAL'],
      ['POR VEHICULO SALDO CAPITAL', 'VEHICULOSALDOCAPITAL'],
      ['POR VEHICULO SALDO TOTAL', 'VEHICULOSALDOTOTAL'],
      ['POR POLITICA OBLIGACION', 'POLITICAOBLIGACION']
    ]
  end

  def select_situacion_titular
    [
      ['NORMAL', 0],
      ['CONCORDATO', 1],
      ['LIQUIDACIÓN FORZOSA', 2],
      ['LIQUIDACIÓN VOLUNTARIA', 3],
      ['PROCESO DE REORGANIZACIÓN', 4],
      ['LEY 550', 5],
      ['LEY 1116', 6],
      ['OTRA', 7]
    ]
  end

  def select_c2tipoempresa
    [
      %w[PUBLICA PUBLICA],
      %w[PRIVADA PRIVADA],
      %w[MIXTA MIXTA]
    ]
  end

  def select_estadotanque
    is_select_estadotanque
  end

  def select_cuentatanque
    is_select_cuentatanque
  end

  def select_origendato
    [
      %w[VUR VUR],
      %w[ORIP ORIP]
    ]
  end

  def select_origendatov
    [
      %w[RUNT RUNT],
      %w[OTRO OTRO]
    ]
  end

  def select_origendatoe
    [
      %w[RUES RUES],
      %w[OTRO OTRO]
    ]
  end

  def select_periodicidad
    [
      %w[MENSUAL MENSUAL],
      %w[BIMESTRAL BIMESTRAL],
      %w[TRIMESTRAL TRIMESTRAL],
      %w[SEMESTRAL SEMESTRAL],
      %w[ANUAL ANUAL],
      %w[NINGUNA NINGUNA]
    ]
  end

  def select_vigilancia
    [
      %w[LLAVES LLAVES],
      %w[ALARMA ALARMA],
      %w[AGENTE AGENTE],
      ['TERRENOS AGRICOLAS', 'TERRENOS AGRICOLAS'],
      %w[TERRENOS TERRENOS],
      %w[OTROS OTROS]
    ]
  end

  def select_tipo_gestion
    [
      ['LLAMADA TELEFONICA', 'LLAMADA TELEFONICA'],
      %w[EMAIL EMAIL],
      %w[VISITA VISITA],
      %w[OTROS OTROS]
    ]
  end

  def select_perumunicipio
    is_select_perumunicipio
  end

  def select_tiposervicio
    [
      %w[PUBLICO PUBLICO],
      %w[PRIVADO PRIVADO],
      %w[OFICIAL OFICIAL]
    ]
  end

  def tipo_deudor
    [
      %w[CODEUDOR CODEUDOR],
      ['PROPITARIO INSCRITO', 'PROPITARIO INSCRITO']
    ]
  end

  def select_tipobien
    [
      %w[VEHICULO VEHICULO],
      %w[INMUEBLE INMUEBLE],
      ['ACTIVOS FINANCIEROS', 'ACTIVOS FINANCIEROS']
    ]
  end

  def select_disponibilidad
    [

      %w[AVAILABLE AVAILABLE],
      %w[NON-AVAILABLE NON-AVAILABLE],
      ['AVAILABLE - KEYS', 'AVAILABLE - KEYS'],
      ['AVAILABLE - LETTER', 'AVAILABLE - LETTER'],
      ['NOT AVAILABLE', 'NOT AVAILABLE']
    ]
  end

  def select_zonagps
    [
      %w[NON-LIMA NON-LIMA],
      %w[LIMA LIMA]
    ]
  end

  def select_gps_loan
    [
      %w[Registered Registered],
      ['Not Registered', 'Not Registered'],
      ['In process', 'In process']
    ]
  end

  def select_gps_pst
    [
      %w[Registered Registered],
      ['Not Registered', 'Not Registered']
    ]
  end

  def select_gps_status
    [
      %w[Unlisted Unlisted],
      %w[Listed Listed],
      ['Offer Under Analysis', 'Offer Under Analysis'],
      ['Sale Concluded', 'Sale Concluded'],
      ['Offer Accepted', 'Offer Accepted'],
      %w[Putback Putback],
      %w[Kickout Kickout]
    ]
  end

  def select_gps_disponible
    [
      %w[Available Available],
      %w[Non-available Non-available],
      ['Available - keys', 'Available - keys'],
      ['Available - letter', 'Available - letter']
    ]
  end

  def select_tipoinmueblebuscador(portafolioid)
    is_select_tipoinmueblebuscador(portafolioid)
  end

  def select_procesostiponotificacion
    [
      ['NOTIFICACION 291', 'NOTIFICACION 291'],
      ['NOTIFICACION 292', 'NOTIFICACION 292'],
      ['NOTIFICACION 293', 'NOTIFICACION 293'],
      ['NOTIFICACION 294', 'NOTIFICACION 294'],
      ['NOTIFICACION 295', 'NOTIFICACION 295'],
      ['NOTIFICACION 301', 'NOTIFICACION 301'],
      ['NOTIFICACION 315', 'NOTIFICACION 315'],
      ['NOTIFICACION 318', 'NOTIFICACION 318'],
      ['NOTIFICACION 320', 'NOTIFICACION 320'],
      ['NOTIFICACION 330', 'NOTIFICACION 330']
    ]
  end

  def select_procesostiporiesgo
    [
      %w[APELACION APELACION],
      ['DESISTIMIENTO TACITO', 'DESISTIMIENTO TACITO'],
      %w[EXCEPCIONES EXCEPCIONES],
      %w[NULIDAD NULIDAD],
      %w[PERENCION PERENCION]
    ]
  end

  def select_procesoscausales
    [
      ['CESION DE DERECHOS', 'CESION DE DERECHOS'],
      ['DESISTIMIENTO TACITO', 'DESISTIMIENTO TACITO'],
      %w[NOVACION NOVACION],
      ['PAGO CUOTAS EN MORA', 'PAGO CUOTAS EN MORA'],
      ['PAGO TOTAL', 'PAGO TOTAL'],
      ['PROCESO DE REORGANIZACION', 'PROCESO DE REORGANIZACION'],
      %w[REESTRUCTURACION REESTRUCTURACION],
      ['SENTENCIA DE RESTITUCION', 'SENTENCIA DE RESTITUCION'],
      ['SENTENCIA EN CONTRA', 'SENTENCIA EN CONTRA']
    ]
  end

  def select_tanqueforma
    [
      ['APLICA CON FECHA ACTUAL', 'APLICACONFECHAACTUAL'],
      ['APLICA CON FECHA MOVIMIENTO', 'APLICACONFECHAMOVIMIENTO']
    ]
  end

  def select_tanqueaplicarec
    [
      ['APLICAR A LA MAYOR DEUDA', 'APLICADEUDA'],
      ['APLICAR A LA MAS VENCIDA', 'APLICAVENCIDA']
    ]
  end

  def select_subetapa
    [
      ['DE MAYOR CUANTIA', 'DE MAYOR CUANTIA'],
      ['DE MENOR CUANTIA', 'DE MENOR CUANTIA'],
      ['DE MINIMA CUANTIA', 'DE MINIMA CUANTIA']
    ]
  end

  def select_grado
    [
      ['PRIMER GRADO', 'PRIMER GRADO'],
      ['SEGUNDO GRADO', 'SEGUNDO GRADO'],
      ['TERCER GRADO', 'TERCER GRADO']
    ]
  end

  def select_pagare
    [
      ['EN BLANCO', 'EN BLANCO'],
      %w[DILIGENCIADO DILIGENCIADO],
      ['SIN PAGARE', 'SIN PAGARE']
    ]
  end

  def select_base_externa
    [
      ['DATA CREDITO', 'DATA CREDITO'],
      %w[CIFIN CIFIN],
      %w[GESTION GESTION]
    ]
  end

  def select_corte
    [
      ['CORTE 5', 5],
      ['CORTE 20', 20]
    ]
  end

  def select_brokers(portafolioid)
    is_select_broker(portafolioid)
  end

  def select_cuoperiodicidad
    [
      ['MENSUAL', 1],
      ['BIMESTRAL', 2],
      ['TRIMESTRAL', 3],
      ['SEMESTRAL', 6],
      ['ANUAL', 12]
    ]
  end

  def select_origensystem
    [
      %w[COMPRA COMPRA],
      %w[SUSTITUCION SUSTITUCION]
    ]
  end

  def select_procesojuridico
    [
      %w[ESTUDIOS ESTUDIOS],
      %w[ABOGADOS ABOGADOS],
      %w[DIRECTORES DIRECTORES],
      %w[ANALISTAS ANALISTAS]
    ]
  end

  def select_tipo_cartera
    [
      ['CARTERA ADMINISTRADA', 'CARTERA ADMINISTRADA'],
      ['CARTERA PROPIA', 'CARTERA PROPIA']
    ]
  end

  def select_parentesco
    [
      %w[NOSE NOSE]
    ]
  end

  def select_inmconfvisita
    [
      ['AAHH: Asentamiento Humano', 'AAHH: Asentamiento Humano'],
      ['PPJJ: Pueblo joven', 'PPJJ: Pueblo joven']
    ]
  end

  def select_inmtipoavaluo
    [
      %w[COMERCIAL COMERCIAL],
      %w[LIQUIDACION LIQUIDACION],
      %w[ESTIMADO ESTIMADO]
    ]
  end

  def select_inmestimadopor
    [
      %w[GPS GPS],
      %w[BROKER BROKER]
    ]
  end

  def select_inmresultadocn
    [
      %w[APROBADO APROBADO],
      ['NO APROBADO', 'NO APROBADO']
    ]
  end

  def select_ciudadprocesogca
    [
      ['ACACIAS - META', 'ACACIAS - META'],
      ['AGUADAS - CALDAS', 'AGUADAS - CALDAS'],
      ['ALBAN -CUNDINAMARCA', 'ALBAN -CUNDINAMARCA'],
      ['ANSERMA - CALDAS', 'ANSERMA - CALDAS'],
      ['APIA - RISARALDA', 'APIA - RISARALDA'],
      ['ARMENIA - QUINDIO', 'ARMENIA - QUINDIO'],
      ['BALBOA - RISARALDA', 'BALBOA - RISARALDA'],
      ['BARANOA - ATLANTICO', 'BARANOA - ATLANTICO'],
      ['BARBOSA - SANTANDER', 'BARBOSA - SANTANDER'],
      ['BARRANCABERMEJA - SANTANDER', 'BARRANCABERMEJA - SANTANDER'],
      ['BARRANQUILLA - ATLANTICO', 'BARRANQUILLA - ATLANTICO'],
      ['BELEN - CUNDINAMARCA', 'BELEN - CUNDINAMARCA'],
      ['BELEN DE UMBRIA - RISARALDA', 'BELEN DE UMBRIA - RISARALDA'],
      ['BELLO - ANTIOQUÍA', 'BELLO - ANTIOQUÍA'],
      ['BOGOTA - CUNDINAMARCA', 'BOGOTA - CUNDINAMARCA'],
      ['BUCARAMANGA - SANTANDER', 'BUCARAMANGA - SANTANDER'],
      ['BUENAVENTURA - VALLE', 'BUENAVENTURA - VALLE'],
      ['BUGA - VALLE', 'BUGA - VALLE'],
      ['CAICEDONIA - VALLE', 'CAICEDONIA - VALLE'],
      ['CAJIBIO - CAUCA', 'CAJIBIO - CAUCA'],
      ['CAJICA - CUNDINAMARCA', 'CAJICA - CUNDINAMARCA'],
      ['CALARCA - QUINDIO', 'CALARCA - QUINDIO'],
      ['CALDAS - ANTIOQUIA', 'CALDAS - ANTIOQUIA'],
      ['CALI - VALLE', 'CALI - VALLE'],
      ['CALIMA - VALLE', 'CALIMA - VALLE'],
      ['CANDELARIA - VALLE', 'CANDELARIA - VALLE'],
      ['CARTAGENA - BOLIVAR', 'CARTAGENA - BOLIVAR'],
      ['CARTAGO - VALLE', 'CARTAGO - VALLE'],
      ['CERETE - CORDOBA', 'CERETE - CORDOBA'],
      ['CHIA - CUNDINAMARCA', 'CHIA - CUNDINAMARCA'],
      ['CHIQUINQUIRA - BOYACA', 'CHIQUINQUIRA - BOYACA'],
      ['CIENAGA - MAGDALENA', 'CIENAGA - MAGDALENA'],
      ['CONTADERO - NARIÑO', 'CONTADERO - NARIÑO'],
      ['COPACABANA - ANTIOQUÍA', 'COPACABANA - ANTIOQUÍA'],
      ['COROZAL - SUCRE', 'COROZAL - SUCRE'],
      ['COTA - CUNDINAMARCA', 'COTA - CUNDINAMARCA'],
      ['CUCUNUBA - CUNDINAMARCA', 'CUCUNUBA - CUNDINAMARCA'],
      ['CUCUTA - N. DE SANTANDER', 'CUCUTA - N. DE SANTANDER'],
      ['DOSQUEBRADAS- RISARALDA', 'DOSQUEBRADAS- RISARALDA'],
      ['DUITAMA - BOYACA', 'DUITAMA - BOYACA'],
      ['EL BANCO - MAGDALENA', 'EL BANCO - MAGDALENA'],
      ['EL CERRITO - VALLE', 'EL CERRITO - VALLE'],
      ['EL COLEGIO - CUNDINAMARCA', 'EL COLEGIO - CUNDINAMARCA'],
      ['ENVIGADO - ANTIOQUIA', 'ENVIGADO - ANTIOQUIA'],
      ['ESPINAL - TOLIMA', 'ESPINAL - TOLIMA'],
      ['FACATATIVA - CUNDINAMARCA', 'FACATATIVA - CUNDINAMARCA'],
      ['FILANDIA - QUINDIO', 'FILANDIA - QUINDIO'],
      ['FLANDES - TOLIMA', 'FLANDES - TOLIMA'],
      ['FLORENCIA - CAQUETA', 'FLORENCIA - CAQUETA'],
      ['FLORIDABLANCA - SANTANDER', 'FLORIDABLANCA - SANTANDER'],
      ['FOMEQUE - CUNDINAMARCA', 'FOMEQUE - CUNDINAMARCA'],
      ['FUNZA -CUNDINAMARCA', 'FUNZA -CUNDINAMARCA'],
      ['FUSAGASUGA - CUNDINAMARCA', 'FUSAGASUGA - CUNDINAMARCA'],
      ['GACHANCIPA - CUNDINAMARCA', 'GACHANCIPA - CUNDINAMARCA'],
      ['GALAPA - ATLANTICO', 'GALAPA - ATLANTICO'],
      ['GIRARDOT - CUNDINAMARCA', 'GIRARDOT - CUNDINAMARCA'],
      ['GIRARDOTA -ANTIOQUIA', 'GIRARDOTA -ANTIOQUIA'],
      ['GIRON - SANTANDER', 'GIRON - SANTANDER'],
      ['GUACARI - VALLE', 'GUACARI - VALLE'],
      ['GUACHUCAL - NARIÑO', 'GUACHUCAL - NARIÑO'],
      ['GUAMO - TOLIMA', 'GUAMO - TOLIMA'],
      ['GUASCA - CUNDINAMARCA', 'GUASCA - CUNDINAMARCA'],
      ['GUATICA - RISARALDA', 'GUATICA - RISARALDA'],
      ['IBAGUE - TOLIMA', 'IBAGUE - TOLIMA'],
      ['IPIALES - NARIÑO', 'IPIALES - NARIÑO'],
      ['ITAGUI - ANTIOQUÍA', 'ITAGUI - ANTIOQUÍA'],
      ['JAMUNDI - VALLE', 'JAMUNDI - VALLE'],
      ['KENNEDY - BOGOTA', 'KENNEDY - BOGOTA'],
      ['LA CALERA - CUNDINAMARCA', 'LA CALERA - CUNDINAMARCA'],
      ['LA CEJA - ANTIOQUÍA', 'LA CEJA - ANTIOQUÍA'],
      ['LA CUMBRE - VALLE', 'LA CUMBRE - VALLE'],
      ['LA ESTRELLA - ANTIOQUÍA', 'LA ESTRELLA - ANTIOQUÍA'],
      ['LA MESA -CUNDINAMARCA', 'LA MESA -CUNDINAMARCA'],
      ['LA UNION - VALLE', 'LA UNION - VALLE'],
      ['LA VIRGINIA - RISARALDA', 'LA VIRGINIA - RISARALDA'],
      ['LEBRIJA -SANTANDER', 'LEBRIJA -SANTANDER'],
      ['LETICIA - AMAZONAS', 'LETICIA - AMAZONAS'],
      ['LOS PATIOS - N. DE SANTANDER', 'LOS PATIOS - N. DE SANTANDER'],
      ['LURUACO - ATLANTICO', 'LURUACO - ATLANTICO'],
      ['MADRID - CUNDINAMARCA', 'MADRID - CUNDINAMARCA'],
      ['MALAGA - SANTANDER', 'MALAGA - SANTANDER'],
      ['MALAMBO - ATLANTICO', 'MALAMBO - ATLANTICO'],
      ['MAICAO - GUAJIRA', 'MAICAO - GUAJIRA'],
      ['MANATI - ATLANTICO', 'MANATI - ATLANTICO'],
      ['MANIZALES - CALDAS', 'MANIZALES - CALDAS'],
      ['MARINILLA - ANTIOQUÌA', 'MARINILLA - ANTIOQUÌA'],
      ['MARIQUITA- TOLIMA', 'MARIQUITA- TOLIMA'],
      ['MARSELLA - RISARALDA', 'MARSELLA - RISARALDA'],
      ['MEDELLIN - ANTIOQUÍA', 'MEDELLIN - ANTIOQUÍA'],
      ['MELGAR - TOLIMA', 'MELGAR - TOLIMA'],
      ['MISTRATO - RISARALDA', 'MISTRATO - RISARALDA'],
      ['MONTENEGRO - QUINDIO', 'MONTENEGRO - QUINDIO'],
      ['MONTERIA - CORDOBA', 'MONTERIA - CORDOBA'],
      ['MOSQUERA - CUNDINAMARCA', 'MOSQUERA - CUNDINAMARCA'],
      ['NEIVA - HUILA', 'NEIVA - HUILA'],
      ['NEMOCON - CUNDINAMARCA', 'NEMOCON - CUNDINAMARCA'],
      ['OVEJAS - SUCRE', 'OVEJAS - SUCRE'],
      ['PAIPA - BOYACA', 'PAIPA - BOYACA'],
      ['PALMAR DE VARELA - ATLANTICO', 'PALMAR DE VARELA - ATLANTICO'],
      ['PALMIRA - VALLE', 'PALMIRA - VALLE'],
      ['PASTO -NARIÑO', 'PASTO -NARIÑO'],
      ['PEREIRA - RISARALDA', 'PEREIRA - RISARALDA'],
      ['PIEDECUESTA - SANTANDER', 'PIEDECUESTA - SANTANDER'],
      ['PITALITO - HUILA', 'PITALITO - HUILA'],
      ['POLO NUEVO - ATLANTICO', 'POLO NUEVO - ATLANTICO'],
      ['POPAYAN - CAUCA', 'POPAYAN - CAUCA'],
      ['PRADERA -VALLE', 'PRADERA -VALLE'],
      ['PUERTO COLOMBIA - ATLANTICO', 'PUERTO COLOMBIA - ATLANTICO'],
      ['PUERTO LOPEZ - META', 'PUERTO LOPEZ - META'],
      ['PUERTO TEJADA - CAUCA', 'PUERTO TEJADA - CAUCA'],
      ['QUIBDO - CHOCO', 'QUIBDO - CHOCO'],
      ['QUIMBAYA - QUINDIO', 'QUIMBAYA - QUINDIO'],
      ['QUINCHIA - RISARALDA', 'QUINCHIA - RISARALDA'],
      ['RICAURTE - CUNIDNAMARCA', 'RICAURTE - CUNIDNAMARCA'],
      ['RIOHACHA - GUAJIRA', 'RIOHACHA - GUAJIRA'],
      ['RIONEGRO - ANTIOQUIA', 'RIONEGRO - ANTIOQUIA'],
      ['RIOSUCIO - CALDAS', 'RIOSUCIO - CALDAS'],
      ['RISARALDA - CALDAS', 'RISARALDA - CALDAS'],
      ['RIVERA - HUILA', 'RIVERA - HUILA'],
      ['SABANAGRANDE - ATLANTICO', 'SABANAGRANDE - ATLANTICO'],
      ['SABANALARGA - ATLANTICO', 'SABANALARGA - ATLANTICO'],
      ['SABANETA - ANTIOQUÍA', 'SABANETA - ANTIOQUÍA'],
      ['SAN ANDRES - SAN ANDRES', 'SAN ANDRES - SAN ANDRES'],
      ['SAN GIL - SANTANDER', 'SAN GIL - SANTANDER'],
      ['SAN JOSE DE RISARALDA - CALDAS', 'SAN JOSE DE RISARALDA - CALDAS'],
      ['SAN JOSE DEL GUAVIARE - GUAVIARE', 'SAN JOSE DEL GUAVIARE - GUAVIARE'],
      ['SAN PEDRO - ANTIOQUÍA', 'SAN PEDRO - ANTIOQUÍA'],
      ['SANTA MARTA - MAGDALENA', 'SANTA MARTA - MAGDALENA'],
      ['SANTA ROSA DE CABAL - RISARALDA', 'SANTA ROSA DE CABAL - RISARALDA'],
      ['SANTA ROSA DE VITERBO - BOYACA', 'SANTA ROSA DE VITERBO - BOYACA'],
      ['SANTANDER DE QUILICHAO - CAUCA', 'SANTANDER DE QUILICHAO - CAUCA'],
      ['SANTO TOMAS - ATLANTICO', 'SANTO TOMAS - ATLANTICO'],
      ['SANTUARIO - ANTIOQUÍA', 'SANTUARIO - ANTIOQUÍA'],
      ['SEVILLA- VALLE', 'SEVILLA- VALLE'],
      ['SIBATE - CUNDINAMARCA', 'SIBATE - CUNDINAMARCA'],
      ['SIMIJACA - CUNDINAMARCA', 'SIMIJACA - CUNDINAMARCA'],
      ['SINCELEJO - SUCRE', 'SINCELEJO - SUCRE'],
      ['SOACHA - CUNDINAMARCA', 'SOACHA - CUNDINAMARCA'],
      ['SOGAMOSO - BOYACA', 'SOGAMOSO - BOYACA'],
      ['SOLEDAD - ATLANTICO', 'SOLEDAD - ATLANTICO'],
      ['SOPO - CUNDINAMARCA', 'SOPO - CUNDINAMARCA'],
      ['TABIO - CUNDINAMARCA', 'TABIO - CUNDINAMARCA'],
      ['TENA - CUNDINAMARCA', 'TENA - CUNDINAMARCA'],
      ['TIMBIO - CAUCA', 'TIMBIO - CAUCA'],
      ['TOCANCIPA - CUNDINAMARCA', 'TOCANCIPA - CUNDINAMARCA'],
      ['TRUJILLO - VALLE', 'TRUJILLO - VALLE'],
      ['TULUA - VALLE', 'TULUA - VALLE'],
      ['TUMACO - NARIÑO', 'TUMACO - NARIÑO'],
      ['TUNJA - BOYACA', 'TUNJA - BOYACA'],
      ['TUQUERRES - NARIÑO', 'TUQUERRES - NARIÑO'],
      ['TURBACO - BOLIVAR', 'TURBACO - BOLIVAR'],
      ['TUTAZA - BOYACA', 'TUTAZA - BOYACA'],
      ['UBATE - CUNDINAMARCA', 'UBATE - CUNDINAMARCA'],
      ['VALLEDUPAR - CESAR', 'VALLEDUPAR - CESAR'],
      ['VENTAQUEMADA - BOYACA', 'VENTAQUEMADA - BOYACA'],
      ['VIJES - VALLE', 'VIJES - VALLE'],
      ['VILLA DEL ROSARIO - N. DE SANTANDER', 'VILLA DEL ROSARIO - N. DE SANTANDER'],
      ['VILLAVICENCIO - META', 'VILLAVICENCIO - META'],
      ['YOPAL - CASANARE', 'YOPAL - CASANARE'],
      ['YOTOCO - VALLE', 'YOTOCO - VALLE'],
      ['YUMBO - VALLE', 'YUMBO - VALLE'],
      ['ZARZAL - VALLE', 'ZARZAL - VALLE'],
      ['ZIPAQUIRA - CUNDINAMARCA', 'ZIPAQUIRA - CUNDINAMARCA']
    ]
  end

  def select_interescorriente
    [
      ['SI', -1],
      ['NO', 0]
    ]
  end


  def select_estadotramites
    [
      %w[CANCELADO C],
      %w[ANULADO A],
      %w[PENDIENTE P]
    ]
  end

  def select_tiposdocumentosreon
    [
      ['FACTURA DEL PROVEEDOR', 'F'],
      ['NOTA CRÉDITO PROVEEDOR', 'N'],
      ['NOTA DÉBITO PROVEEDOR', 'C'],
      ['FACTURA DE LA EMPRESA', 'E'],
      ['NOTA CRÉDITO EMPRESA', 'M'],
      ['NOTA DÉBITO EMPRESA', 'B'],
      %w[COBRANZA Z],
      %w[OTROS D]
    ]
  end

  def select_carguegastos
    [
      ['GASTOS PROCESALES', 'GASTOS PROCESALES'],
      ['GASTOS REO', 'GASTOS REO'],
      ['RESPUESTA BCP', 'RESPUESTA BCP']
    ]
  end

  def select_tipocuentaproveedor
    [
      %w[CORRIENTE C],
      %w[MAESTRA M],
      %w[AHORROS A],
      %w[INTERBANCARIA B]
    ]
  end

  def select_claseimagenhipo
    [
      %w[IMAGEN IMAGEN],
      %w[MAPA MAPA]
    ]
  end

  def select_physical_rating
    [
      ['A+', 'A+'],
      %w[A A],
      ['A-', 'A-'],
      ['B+', 'B+'],
      %w[B B],
      ['B-', 'B-'],
      ['C+', 'C+'],
      %w[C C],
      ['C-', 'C-']
    ]
  end

  def select_location_rating
    [
      ['A+', 'A+'],
      %w[A A],
      ['A-', 'A-'],
      ['B+', 'B+'],
      %w[B B],
      ['B-', 'B-'],
      ['C+', 'C+'],
      %w[C C],
      ['C-', 'C-']
    ]
  end

  def select_efectivanoefectiva
    [
      %w[EFECTIVA EFECTIVA],
      ['NO EFECTIVA', 'NO EFECTIVA']
    ]
  end

  def select_codigoestado
    [
      ['1', 1],
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5]
    ]
  end

  def select_portafolio
    [
      %w[BBVA1 BBVA1],
      %w[BBVA2 BBVA2],
      %w[BCP1 BCP1],
      %w[BCP2 BCP2]
    ]
  end

  def select_originadorinmueble
    [
      %w[BCP BCP],
      %w[BBVA BBVA]
    ]
  end

  def select_patrimonio
    [
      ['REO TRUST 2016', 'REO TRUST 2016'],
      ['CUSCO 2018', 'CUSCO 2018'],
      ['LOAN TRUST 2019', 'LOAN TRUST 2019']
    ]
  end

  def select_tipopatrimonio
    [
      %w[INGRESOS INGRESOS],
      %w[GASTOS GASTOS]
    ]
  end

  def select_tipo_cierre
    [
      %w[GENERAR GENERAR],
      %w[CONSOLIDAR CONSOLIDAR]
    ]
  end

  def select_tipodocumentoinmueble
    [
      ['SITE INSPECTIONS', 'SITE INSPECTIONS'],
      ['DOCUMENTOS MUNICIPALES', 'DOCUMENTOS MUNICIPALES'],
      %w[RRPP RRPP],
      ['COMPRA VENTA', 'COMPRA VENTA'],
      ['DOCUMENTOS DE CRÉDITO', 'DOCUMENTOS DE CRÉDITO'],
      %w[FOTOS FOTOS],
      %w[UBICACIÓN UBICACIÓN]
    ]
  end

  def select_estado_bloqueo
    is_select_estado_bloqueo
  end

  def select_mesanno
    [
      ['2019/01', '2019/01'],
      ['2019/02', '2019/02'],
      ['2019/03', '2019/03'],
      ['2019/04', '2019/04'],
      ['2019/05', '2019/05'],
      ['2019/06', '2019/06'],
      ['2019/07', '2019/07'],
      ['2019/08', '2019/08'],
      ['2019/09', '2019/09'],
      ['2019/10', '2019/10'],
      ['2019/11', '2019/11'],
      ['2019/12', '2019/12'],
      ['2020/01', '2020/01'],
      ['2020/02', '2020/02'],
      ['2020/03', '2020/03'],
      ['2020/04', '2020/04'],
      ['2020/05', '2020/05'],
      ['2020/06', '2020/06'],
      ['2020/07', '2020/07'],
      ['2020/08', '2020/08'],
      ['2020/09', '2020/09'],
      ['2020/10', '2020/10'],
      ['2020/11', '2020/11'],
      ['2020/12', '2020/12']
    ]
  end

  def select_tipocliente
    [
      %w[ADMINISTRADOR ADMINISTRADOR],
      %w[BARBERO BARBERO],
      %w[CLIENTE CLIENTE],
      %w[RECEPCION RECEPCION]
    ]
  end

  def select_sedes
    is_select_sedes
  end

  def select_horas
    [
      ['1 HORA', 1],
      ['2 HORAS', 2]
    ]
  end

  def select_estado
    [
      %w[ACTIVO A],
      %w[INACTIVO I]
    ]
  end

  def select_documento
    [
      ['C.C.', 'CC'],
      ['T.I.', 'TI'],
      %w[NIT NIT],
      %w[PAS PAS],
      ['C.E.', 'CE'],
      ['PPT', 'PPT']
    ]
  end

  def select_mercadeo
    [
      ['Búsqueda en Google página web','Búsqueda en Google página web'],
      ['Cartelera exterior (pasó por la sede)','Cartelera exterior (pasó por la sede)'],
      ['Catálogos, revistas, volantes','Catálogos, revistas, volantes'],
      ['E-mail marketing (le llegó un correo)','E-mail marketing (le llegó un correo)'],
      ['Eventos ','Eventos '],
      ['Mapas de Google','Mapas de Google'],
      ['Publicidad en YouTube','Publicidad en YouTube'],
      ['Radio','Radio'],
      ['Recomendado de amigo o familiar ','Recomendado de amigo o familiar '],
      ['Redes sociales Facebook','Redes sociales Facebook'],
      ['Redes sociales Instagram','Redes sociales Instagram'],
      ['Redes sociales Tiktok','Redes sociales Tiktok'],
      ['Televisión','Televisión'],
      ['Sin Informacion', 'Sin Informacion']
    ]
  end

  def select_mercadeo2
    [
      ['Chat de Google Maps','Chat de Google Maps'],
      ['llamada al celular','llamada al celular'],
      ['llamada al teléfono fijo','llamada al teléfono fijo'],
      ['Messenger (Facebook e Instagram)','Messenger (Facebook e Instagram)'],
      ['otro','otro'],
      ['Solo me asesoré de forma presencial en la sede','Solo me asesoré de forma presencial en la sede'],
      ['WhatsApp','WhatsApp']
    ]
  end

  def select_jornada
    [['DIURNA', '1) DIURNA'], ['NOCTURNA', '2) NOCTURNA'], ['FIN DE SEMANA', '3) FIN DE SEMANA']]
  end


  def select_estado_civil
    [['SOLTERO', 'SOLTERO'],
     ['CASADO', 'CASADO'], ['UNIÓN LIBRE', 'UNIÓN LIBRE'],
     ['SEPARADO', 'SEPARADO'], ['VIUDO', 'VIUDO'],
     ['DIVORCIADO', 'DIVORCIADO'], ['SIN INFORMACIÓN', 'SIN INFORMACIÓN']]
  end

  def select_nivel_formacion
    [['PREESCOLAR', '1) PREESCOLAR'], ['BÁSICA PRIMARIA', '2) BÁSICA PRIMARIA'],
     ['BÁSICA SECUNDARIA', '3) BÁSICA SECUNDARIA'], ['MEDIA', '4) MEDIA'],
     ['PREGRADO', '5) PREGRADO'], ['POSTGRADO', '6) POSTGRADO'],
     ['SIN ESTUDIOS', '7) SIN ESTUDIOS'], ['TÉCNICO LABORAL', '8) TÉCNICO LABORAL'],
     ['SIN INFORMACIÓN', '99) SIN INFORMACIÓN']]
  end

  def select_estracto
    [['1', '1) 1'], ['2', '2) 2'], ['3', '3) 3'], ['4', '4) 4'], ['5', '5) 5'],
     ['6', '6) 6'], [' SIN INFORMACIÓN', '99) SIN INFORMACIÓN']]
  end

  def select_lugar_origen
    [['OTRO - EXTERIOR', '00000) OTRO - EXTERIOR'],
     ['OTRO - SIN INFORMACIÓN', '00999) OTRO - SIN INFORMACIÓN'],
     ['ANTIOQUIA - MEDELLIN', '05001) ANTIOQUIA - MEDELLIN'],
     ['ANTIOQUIA - ABEJORRAL', '05002) ANTIOQUIA - ABEJORRAL'],
     ['ANTIOQUIA - ABRIAQUI', '05004) ANTIOQUIA - ABRIAQUI'],
     ['ANTIOQUIA - ALEJANDRIA', '05021) ANTIOQUIA - ALEJANDRIA'],
     ['ANTIOQUIA - AMAGA', '05030) ANTIOQUIA - AMAGA'],
     ['ANTIOQUIA - AMALFI', '05031) ANTIOQUIA - AMALFI'],
     ['ANTIOQUIA - ANDES', '05034) ANTIOQUIA - ANDES'],
     ['ANTIOQUIA - ANGELOPOLIS', '05036) ANTIOQUIA - ANGELOPOLIS'],
     ['ANTIOQUIA - ANGOSTURA', '05038) ANTIOQUIA - ANGOSTURA'],
     ['ANTIOQUIA - ANORI', '05040) ANTIOQUIA - ANORI'],
     ['ANTIOQUIA - SANTA FE DE ANTIOQUIA', '05042) ANTIOQUIA - SANTA FE DE ANTIOQUIA'],
     ['ANTIOQUIA - ANZA', '05044) ANTIOQUIA - ANZA'],
     ['ANTIOQUIA - APARTADO', '05045) ANTIOQUIA - APARTADO'],
     ['ANTIOQUIA - ARBOLETES', '05051) ANTIOQUIA - ARBOLETES'],
     ['ANTIOQUIA - ARGELIA', '05055) ANTIOQUIA - ARGELIA'],
     ['ANTIOQUIA - ARMENIA', '05059) ANTIOQUIA - ARMENIA'],
     ['ANTIOQUIA - BARBOSA', '05079) ANTIOQUIA - BARBOSA'],
     ['ANTIOQUIA - BELMIRA', '05086) ANTIOQUIA - BELMIRA'],
     ['ANTIOQUIA - BELLO', '05088) ANTIOQUIA - BELLO'],
     ['ANTIOQUIA - BETANIA', '05091) ANTIOQUIA - BETANIA'],
     ['ANTIOQUIA - BETULIA', '05093) ANTIOQUIA - BETULIA'],
     ['ANTIOQUIA - CIUDAD BOLIVAR', '05101) ANTIOQUIA - CIUDAD BOLIVAR'],
     ['ANTIOQUIA - BRICEY0', '05107) ANTIOQUIA - BRICEY0'],
     ['ANTIOQUIA - BURITICA', '05113) ANTIOQUIA - BURITICA'],
     ['ANTIOQUIA - CACERES', '05120) ANTIOQUIA - CACERES'],
     ['ANTIOQUIA - CAICEDO', '05125) ANTIOQUIA - CAICEDO'],
     ['ANTIOQUIA - CALDAS', '05129) ANTIOQUIA - CALDAS'],
     ['ANTIOQUIA - CAMPAMENTO', '05134) ANTIOQUIA - CAMPAMENTO'],
     ['ANTIOQUIA - CAÑASGORDAS', '05138) ANTIOQUIA - CAÑASGORDAS'],
     ['ANTIOQUIA - CARACOLI', '05142) ANTIOQUIA - CARACOLI'],
     ['ANTIOQUIA - CARAMANTA', '05145) ANTIOQUIA - CARAMANTA'],
     ['ANTIOQUIA - CAREPA', '05147) ANTIOQUIA - CAREPA'],
     ['ANTIOQUIA - CARMEN DE VIBORAL', '05148) ANTIOQUIA - CARMEN DE VIBORAL'],
     ['ANTIOQUIA - CAROLINA', '05150) ANTIOQUIA - CAROLINA'],
     ['ANTIOQUIA - CAUCASIA', '05154) ANTIOQUIA - CAUCASIA'],
     ['ANTIOQUIA - CHIGORODO', '05172) ANTIOQUIA - CHIGORODO'],
     ['ANTIOQUIA - CISNEROS', '05190) ANTIOQUIA - CISNEROS'],
     ['ANTIOQUIA - COCORNA', '05197) ANTIOQUIA - COCORNA'],
     ['ANTIOQUIA - CONCEPCION', '05206) ANTIOQUIA - CONCEPCION'],
     ['ANTIOQUIA - CONCORDIA', '05209) ANTIOQUIA - CONCORDIA'],
     ['ANTIOQUIA - COPACABANA', '05212) ANTIOQUIA - COPACABANA'],
     ['ANTIOQUIA - DABEIBA', '05234) ANTIOQUIA - DABEIBA'],
     ['ANTIOQUIA - DON MATIAS', '05237) ANTIOQUIA - DON MATIAS'],
     ['ANTIOQUIA - EBEJICO', '05240) ANTIOQUIA - EBEJICO'],
     ['ANTIOQUIA - EL BAGRE', '05250) ANTIOQUIA - EL BAGRE'],
     ['ANTIOQUIA - ENTRERRIOS', '05264) ANTIOQUIA - ENTRERRIOS'],
     ['ANTIOQUIA - ENVIGADO', '05266) ANTIOQUIA - ENVIGADO'],
     ['ANTIOQUIA - FREDONIA', '05282) ANTIOQUIA - FREDONIA'],
     ['ANTIOQUIA - FRONTINO', '05284) ANTIOQUIA - FRONTINO'],
     ['ANTIOQUIA - GIRALDO', '05306) ANTIOQUIA - GIRALDO'],
     ['ANTIOQUIA - GIRARDOTA', '05308) ANTIOQUIA - GIRARDOTA'],
     ['ANTIOQUIA - GOMEZ PLATA', '05310) ANTIOQUIA - GOMEZ PLATA'],
     ['ANTIOQUIA - GRANADA', '05313) ANTIOQUIA - GRANADA'],
     ['ANTIOQUIA - GUADALUPE', '05315) ANTIOQUIA - GUADALUPE'],
     ['ANTIOQUIA - GUARNE', '05318) ANTIOQUIA - GUARNE'],
     ['ANTIOQUIA - GUATAPE', '05321) ANTIOQUIA - GUATAPE'],
     ['ANTIOQUIA - HELICONIA', '05347) ANTIOQUIA - HELICONIA'],
     ['ANTIOQUIA - HISPANIA', '05353) ANTIOQUIA - HISPANIA'],
     ['ANTIOQUIA - ITAGUI', '05360) ANTIOQUIA - ITAGUI'],
     ['ANTIOQUIA - ITUANGO', '05361) ANTIOQUIA - ITUANGO'],
     ['ANTIOQUIA - JARDIN', '05364) ANTIOQUIA - JARDIN'],
     ['ANTIOQUIA - JERICO', '05368) ANTIOQUIA - JERICO'],
     ['ANTIOQUIA - LA CEJA', '05376) ANTIOQUIA - LA CEJA'],
     ['ANTIOQUIA - LA ESTRELLA', '05380) ANTIOQUIA - LA ESTRELLA'],
     ['ANTIOQUIA - LA PINTADA', '05390) ANTIOQUIA - LA PINTADA'],
     ['ANTIOQUIA - LA UNION', '05400) ANTIOQUIA - LA UNION'],
     ['ANTIOQUIA - LIBORINA', '05411) ANTIOQUIA - LIBORINA'],
     ['ANTIOQUIA - MACEO', '05425) ANTIOQUIA - MACEO'],
     ['ANTIOQUIA - MARINILLA', '05440) ANTIOQUIA - MARINILLA'],
     ['ANTIOQUIA - MONTEBELLO', '05467) ANTIOQUIA - MONTEBELLO'],
     ['ANTIOQUIA - MURINDO', '05475) ANTIOQUIA - MURINDO'],
     ['ANTIOQUIA - MUTATA', '05480) ANTIOQUIA - MUTATA'],
     ['ANTIOQUIA - NARIÑO', '05483) ANTIOQUIA - NARIÑO'],
     ['ANTIOQUIA - NECOCLI', '05490) ANTIOQUIA - NECOCLI'],
     ['ANTIOQUIA - NECHI', '05495) ANTIOQUIA - NECHI'],
     ['ANTIOQUIA - OLAYA', '05501) ANTIOQUIA - OLAYA'],
     ['ANTIOQUIA - EL PEÑOL', '05541) ANTIOQUIA - EL PEÑOL'],
     ['ANTIOQUIA - PEQUE', '05543) ANTIOQUIA - PEQUE'],
     ['ANTIOQUIA - PUEBLO RICO', '05576) ANTIOQUIA - PUEBLO RICO'],
     ['ANTIOQUIA - PUERTO BERRIO', '05579) ANTIOQUIA - PUERTO BERRIO'],
     ['ANTIOQUIA - PUERTO NARE', '05585) ANTIOQUIA - PUERTO NARE'],
     ['ANTIOQUIA - PUERTO TRIUNFO', '05591) ANTIOQUIA - PUERTO TRIUNFO'],
     ['ANTIOQUIA - REMEDIOS', '05604) ANTIOQUIA - REMEDIOS'],
     ['ANTIOQUIA - EL RETIRO', '05607) ANTIOQUIA - EL RETIRO'],
     ['ANTIOQUIA - RIONEGRO', '05615) ANTIOQUIA - RIONEGRO'],
     ['ANTIOQUIA - SABANALARGA', '05628) ANTIOQUIA - SABANALARGA'],
     ['ANTIOQUIA - SABANETA', '05631) ANTIOQUIA - SABANETA'],
     ['ANTIOQUIA - SALGAR', '05642) ANTIOQUIA - SALGAR'],
     ['ANTIOQUIA - SAN ANDRES', '05647) ANTIOQUIA - SAN ANDRES'],
     ['ANTIOQUIA - SAN CARLOS', '05649) ANTIOQUIA - SAN CARLOS'],
     ['ANTIOQUIA - SAN FRANCISCO', '05652) ANTIOQUIA - SAN FRANCISCO'],
     ['ANTIOQUIA - SAN JERONIMO', '05656) ANTIOQUIA - SAN JERONIMO'],
     ['ANTIOQUIA - SAN JOSE DE LA MONTAÑA', '05658) ANTIOQUIA - SAN JOSE DE LA MONTAÑA'],
     ['ANTIOQUIA - SAN JUAN DE URABA', '05659) ANTIOQUIA - SAN JUAN DE URABA'],
     ['ANTIOQUIA - SAN LUIS', '05660) ANTIOQUIA - SAN LUIS'],
     ['ANTIOQUIA - SAN PEDRO', '05664) ANTIOQUIA - SAN PEDRO'],
     ['ANTIOQUIA - SAN PEDRO DE URABA', '05665) ANTIOQUIA - SAN PEDRO DE URABA'],
     ['ANTIOQUIA - SAN RAFAEL', '05667) ANTIOQUIA - SAN RAFAEL'],
     ['ANTIOQUIA - SAN ROQUE', '05670) ANTIOQUIA - SAN ROQUE'],
     ['ANTIOQUIA - SAN VICENTE', '05674) ANTIOQUIA - SAN VICENTE'],
     ['ANTIOQUIA - SANTA BARBARA', '05679) ANTIOQUIA - SANTA BARBARA'],
     ['ANTIOQUIA - SANTA ROSA DE OSOS', '05686) ANTIOQUIA - SANTA ROSA DE OSOS'],
     ['ANTIOQUIA - SANTO DOMINGO', '05690) ANTIOQUIA - SANTO DOMINGO'],
     ['ANTIOQUIA - SANTUARIO', '05697) ANTIOQUIA - SANTUARIO'],
     ['ANTIOQUIA - SEGOVIA', '05736) ANTIOQUIA - SEGOVIA'],
     ['ANTIOQUIA - SONSON', '05756) ANTIOQUIA - SONSON'],
     ['ANTIOQUIA - SOPETRAN', '05761) ANTIOQUIA - SOPETRAN'],
     ['ANTIOQUIA - TAMESIS', '05789) ANTIOQUIA - TAMESIS'],
     ['ANTIOQUIA - TARAZA', '05790) ANTIOQUIA - TARAZA'],
     ['ANTIOQUIA - TARSO', '05792) ANTIOQUIA - TARSO'],
     ['ANTIOQUIA - TITIRIBI', '05809) ANTIOQUIA - TITIRIBI'],
     ['ANTIOQUIA - TOLEDO', '05819) ANTIOQUIA - TOLEDO'],
     ['ANTIOQUIA - TURBO', '05837) ANTIOQUIA - TURBO'],
     ['ANTIOQUIA - URAMITA', '05842) ANTIOQUIA - URAMITA'],
     ['ANTIOQUIA - URRAO', '05847) ANTIOQUIA - URRAO'],
     ['ANTIOQUIA - VALDIVIA', '05854) ANTIOQUIA - VALDIVIA'],
     ['ANTIOQUIA - VALPARAISO', '05856) ANTIOQUIA - VALPARAISO'],
     ['ANTIOQUIA - VEGACHI', '05858) ANTIOQUIA - VEGACHI'],
     ['ANTIOQUIA - VENECIA', '05861) ANTIOQUIA - VENECIA'],
     ['ANTIOQUIA - VIGIA DEL FUERTE', '05873) ANTIOQUIA - VIGIA DEL FUERTE'],
     ['ANTIOQUIA - YALI', '05885) ANTIOQUIA - YALI'],
     ['ANTIOQUIA - YARUMAL', '05887) ANTIOQUIA - YARUMAL'],
     ['ANTIOQUIA - YOLOMBO', '05890) ANTIOQUIA - YOLOMBO'],
     ['ANTIOQUIA - YONDO', '05893) ANTIOQUIA - YONDO'],
     ['ANTIOQUIA - ZARAGOZA', '05895) ANTIOQUIA - ZARAGOZA'],
     ['ATLANTICO - BARRANQUILLA', '08001) ATLANTICO - BARRANQUILLA'],
     ['ATLANTICO - BARANOA', '08078) ATLANTICO - BARANOA'],
     ['ATLANTICO - CAMPO DE LA CRUZ', '08137) ATLANTICO - CAMPO DE LA CRUZ'],
     ['ATLANTICO - CANDELARIA', '08141) ATLANTICO - CANDELARIA'],
     ['ATLANTICO - GALAPA', '08296) ATLANTICO - GALAPA'],
     ['ATLANTICO - JUAN DE ACOSTA', '08372) ATLANTICO - JUAN DE ACOSTA'],
     ['ATLANTICO - LURUACO', '08421) ATLANTICO - LURUACO'],
     ['ATLANTICO - MALAMBO', '08433) ATLANTICO - MALAMBO'],
     ['ATLANTICO - MANATI', '08436) ATLANTICO - MANATI'],
     ['ATLANTICO - PALMAR DE VARELA', '08520) ATLANTICO - PALMAR DE VARELA'],
     ['ATLANTICO - PIOJO', '08549) ATLANTICO - PIOJO'],
     ['ATLANTICO - POLONUEVO', '08558) ATLANTICO - POLONUEVO'],
     ['ATLANTICO - PONEDERA', '08560) ATLANTICO - PONEDERA'],
     ['ATLANTICO - PUERTO COLOMBIA', '08573) ATLANTICO - PUERTO COLOMBIA'],
     ['ATLANTICO - REPELON', '08606) ATLANTICO - REPELON'],
     ['ATLANTICO - SABANAGRANDE', '08634) ATLANTICO - SABANAGRANDE'],
     ['ATLANTICO - SABANALARGA', '08638) ATLANTICO - SABANALARGA'],
     ['ATLANTICO - SANTA LUCIA', '08675) ATLANTICO - SANTA LUCIA'],
     ['ATLANTICO - SANTO TOMAS', '08685) ATLANTICO - SANTO TOMAS'],
     ['ATLANTICO - SOLEDAD', '08758) ATLANTICO - SOLEDAD'],
     ['ATLANTICO - SUAN', '08770) ATLANTICO - SUAN'],
     ['ATLANTICO - TUBARA', '08832) ATLANTICO - TUBARA'],
     ['ATLANTICO - USIACURI', '08849) ATLANTICO - USIACURI'],
     ['BOGOTA D.C - SANTAFE DE BOGOTA', '11001) BOGOTA D.C - SANTAFE DE BOGOTA'],
     ['BOLIVAR - CARTAGENA', '13001) BOLIVAR - CARTAGENA'],
     ['BOLIVAR - ACHI', '13006) BOLIVAR - ACHI'],
     ['BOLIVAR - ALTOS DEL ROSARIO', '13030) BOLIVAR - ALTOS DEL ROSARIO'],
     ['BOLIVAR - ARENAL', '13042) BOLIVAR - ARENAL'],
     ['BOLIVAR - ARJONA', '13052) BOLIVAR - ARJONA'],
     ['BOLIVAR - BARRANCO DE LOBA', '13074) BOLIVAR - BARRANCO DE LOBA'],
     ['BOLIVAR - CALAMAR', '13140) BOLIVAR - CALAMAR'],
     ['BOLIVAR - CANTAGALLO', '13160) BOLIVAR - CANTAGALLO'],
     ['BOLIVAR - CICUCO', '13188) BOLIVAR - CICUCO'],
     ['BOLIVAR - CORDOBA', '13212) BOLIVAR - CORDOBA'],
     ['BOLIVAR - CLEMENCIA', '13222) BOLIVAR - CLEMENCIA'],
     ['BOLIVAR - EL CARMEN DE BOLIVAR', '13244) BOLIVAR - EL CARMEN DE BOLIVAR'],
     ['BOLIVAR - EL GUAMO', '13248) BOLIVAR - EL GUAMO'],
     ['BOLIVAR - EL PEÑON', '13268) BOLIVAR - EL PEÑON'],
     ['BOLIVAR - HATILLO DE LOBA', '13300) BOLIVAR - HATILLO DE LOBA'],
     ['BOLIVAR - MAGANGUE', '13430) BOLIVAR - MAGANGUE'],
     ['BOLIVAR - MAHATES', '13433) BOLIVAR - MAHATES'],
     ['BOLIVAR - MARGARITA', '13440) BOLIVAR - MARGARITA'],
     ['BOLIVAR - MARIA LA BAJA', '13442) BOLIVAR - MARIA LA BAJA'],
     ['BOLIVAR - MONTECRISTO', '13458) BOLIVAR - MONTECRISTO'],
     ['BOLIVAR - MOMPOS', '13468) BOLIVAR - MOMPOS'],
     ['BOLIVAR - MORALES', '13473) BOLIVAR - MORALES'],
     ['BOLIVAR - PINILLOS', '13549) BOLIVAR - PINILLOS'],
     ['BOLIVAR - REGIDOR', '13580) BOLIVAR - REGIDOR'],
     ['BOLIVAR - RIO VIEJO', '13600) BOLIVAR - RIO VIEJO'],
     ['BOLIVAR - SAN CRISTOBAL', '13620) BOLIVAR - SAN CRISTOBAL'],
     ['BOLIVAR - SAN ESTANISLAO', '13647) BOLIVAR - SAN ESTANISLAO'],
     ['BOLIVAR - SAN FERNANDO', '13650) BOLIVAR - SAN FERNANDO'],
     ['BOLIVAR - SAN JACINTO', '13654) BOLIVAR - SAN JACINTO'],
     ['BOLIVAR - SAN JUAN NEPOMUCENO', '13657) BOLIVAR - SAN JUAN NEPOMUCENO'],
     ['BOLIVAR - SAN MARTIN DE LOBA', '13667) BOLIVAR - SAN MARTIN DE LOBA'],
     ['BOLIVAR - SAN PABLO', '13670) BOLIVAR - SAN PABLO'],
     ['BOLIVAR - SANTA CATALINA', '13673) BOLIVAR - SANTA CATALINA'],
     ['BOLIVAR - SANTA ROSA', '13683) BOLIVAR - SANTA ROSA'],
     ['BOLIVAR - SANTA ROSA DEL SUR', '13688) BOLIVAR - SANTA ROSA DEL SUR'],
     ['BOLIVAR - SIMITI', '13744) BOLIVAR - SIMITI'],
     ['BOLIVAR - SOPLAVIENTO', '13760) BOLIVAR - SOPLAVIENTO'],
     ['BOLIVAR - TALAIGUA NUEVO', '13780) BOLIVAR - TALAIGUA NUEVO'],
     ['BOLIVAR - TIQUISIO', '13810) BOLIVAR - TIQUISIO'],
     ['BOLIVAR - TURBACO', '13836) BOLIVAR - TURBACO'],
     ['BOLIVAR - TURBANA', '13838) BOLIVAR - TURBANA'],
     ['BOLIVAR - VILLANUEVA', '13873) BOLIVAR - VILLANUEVA'],
     ['BOLIVAR - ZAMBRANO', '13894) BOLIVAR - ZAMBRANO'],
     ['BOYACA - TUNJA', '15001) BOYACA - TUNJA'],
     ['BOYACA - ALMEIDA', '15022) BOYACA - ALMEIDA'],
     ['BOYACA - AQUITANIA', '15047) BOYACA - AQUITANIA'],
     ['BOYACA - ARCABUCO', '15051) BOYACA - ARCABUCO'],
     ['BOYACA - BELEN', '15087) BOYACA - BELEN'],
     ['BOYACA - BERBEO', '15090) BOYACA - BERBEO'],
     ['BOYACA - BETEITIVA', '15092) BOYACA - BETEITIVA'],
     ['BOYACA - BOAVITA', '15097) BOYACA - BOAVITA'],
     ['BOYACA - BOYACA', '15104) BOYACA - BOYACA'],
     ['BOYACA - BRICEÑ0', '15106) BOYACA - BRICEÑ0'],
     ['BOYACA - BUENAVISTA', '15109) BOYACA - BUENAVISTA'],
     ['BOYACA - BUSBANZA', '15114) BOYACA - BUSBANZA'],
     ['BOYACA - CALDAS', '15131) BOYACA - CALDAS'],
     ['BOYACA - CAMPOHERMOSO', '15135) BOYACA - CAMPOHERMOSO'],
     ['BOYACA - CERINZA', '15162) BOYACA - CERINZA'],
     ['BOYACA - CHINAVITA', '15172) BOYACA - CHINAVITA'],
     ['BOYACA - CHIQUINQUIRA', '15176) BOYACA - CHIQUINQUIRA'],
     ['BOYACA - CHISCAS', '15180) BOYACA - CHISCAS'],
     ['BOYACA - CHITA', '15183) BOYACA - CHITA'],
     ['BOYACA - CHITARAQUE', '15185) BOYACA - CHITARAQUE'],
     ['BOYACA - CHIVATA', '15187) BOYACA - CHIVATA'],
     ['BOYACA - CIENEGA', '15189) BOYACA - CIENEGA'],
     ['BOYACA - COMBITA', '15204) BOYACA - COMBITA'],
     ['BOYACA - COPER', '15212) BOYACA - COPER'],
     ['BOYACA - CORRALES', '15215) BOYACA - CORRALES'],
     ['BOYACA - COVARACHIA', '15218) BOYACA - COVARACHIA'],
     ['BOYACA - CUBARA', '15223) BOYACA - CUBARA'],
     ['BOYACA - CUCAITA', '15224) BOYACA - CUCAITA'],
     ['BOYACA - CUITIVA', '15226) BOYACA - CUITIVA'],
     ['BOYACA - CHIQUIZA', '15232) BOYACA - CHIQUIZA'],
     ['BOYACA - CHIVOR', '15236) BOYACA - CHIVOR'],
     ['BOYACA - DUITAMA', '15238) BOYACA - DUITAMA'],
     ['BOYACA - EL COCUY', '15244) BOYACA - EL COCUY'],
     ['BOYACA - EL ESPINO', '15248) BOYACA - EL ESPINO'],
     ['BOYACA - FIRAVITOBA', '15272) BOYACA - FIRAVITOBA'],
     ['BOYACA - FLORESTA', '15276) BOYACA - FLORESTA'],
     ['BOYACA - GACHANTIVA', '15293) BOYACA - GACHANTIVA'],
     ['BOYACA - GAMEZA', '15296) BOYACA - GAMEZA'],
     ['BOYACA - GARAGOA', '15299) BOYACA - GARAGOA'],
     ['BOYACA - GUACAMAYAS', '15317) BOYACA - GUACAMAYAS'],
     ['BOYACA - GUATEQUE', '15322) BOYACA - GUATEQUE'],
     ['BOYACA - GUAYATA', '15325) BOYACA - GUAYATA'],
     ['BOYACA - GUICAN', '15332) BOYACA - GUICAN'],
     ['BOYACA - IZA', '15362) BOYACA - IZA'],
     ['BOYACA - JENESANO', '15367) BOYACA - JENESANO'],
     ['BOYACA - JERICO', '15368) BOYACA - JERICO'],
     ['BOYACA - LABRANZAGRANDE', '15377) BOYACA - LABRANZAGRANDE'],
     ['BOYACA - LA CAPILLA', '15380) BOYACA - LA CAPILLA'],
     ['BOYACA - LA VICTORIA', '15401) BOYACA - LA VICTORIA'],
     ['BOYACA - LA UVITA', '15403) BOYACA - LA UVITA'],
     ['BOYACA - VILLA DE LEIVA', '15407) BOYACA - VILLA DE LEIVA'],
     ['BOYACA - MACANAL', '15425) BOYACA - MACANAL'],
     ['BOYACA - MARIPI', '15442) BOYACA - MARIPI'],
     ['BOYACA - MIRAFLORES', '15455) BOYACA - MIRAFLORES'],
     ['BOYACA - MONGUA', '15464) BOYACA - MONGUA'],
     ['BOYACA - MONGUI', '15466) BOYACA - MONGUI'],
     ['BOYACA - MONIQUIRA', '15469) BOYACA - MONIQUIRA'],
     ['BOYACA - MOTAVITA', '15476) BOYACA - MOTAVITA'],
     ['BOYACA - MUZO', '15480) BOYACA - MUZO'],
     ['BOYACA - NOBSA', '15491) BOYACA - NOBSA'],
     ['BOYACA - NUEVO COLON', '15494) BOYACA - NUEVO COLON'],
     ['BOYACA - OICATA', '15500) BOYACA - OICATA'],
     ['BOYACA - OTANCHE', '15507) BOYACA - OTANCHE'],
     ['BOYACA - PACHAVITA', '15511) BOYACA - PACHAVITA'],
     ['BOYACA - PAEZ', '15514) BOYACA - PAEZ'],
     ['BOYACA - PAIPA', '15516) BOYACA - PAIPA'],
     ['BOYACA - PAJARITO', '15518) BOYACA - PAJARITO'],
     ['BOYACA - PANQUEBA', '15522) BOYACA - PANQUEBA'],
     ['BOYACA - PAUNA', '15531) BOYACA - PAUNA'],
     ['BOYACA - PAYA', '15533) BOYACA - PAYA'],
     ['BOYACA - PAZ DE RIO', '15537) BOYACA - PAZ DE RIO'],
     ['BOYACA - PESCA', '15542) BOYACA - PESCA'],
     ['BOYACA - PISVA', '15550) BOYACA - PISVA'],
     ['BOYACA - PUERTO BOYACA', '15572) BOYACA - PUERTO BOYACA'],
     ['BOYACA - QUIPAMA', '15580) BOYACA - QUIPAMA'],
     ['BOYACA - RAMIRIQUI', '15599) BOYACA - RAMIRIQUI'],
     ['BOYACA - RAQUIRA', '15600) BOYACA - RAQUIRA'],
     ['BOYACA - RONDON', '15621) BOYACA - RONDON'],
     ['BOYACA - SABOYA', '15632) BOYACA - SABOYA'],
     ['BOYACA - SACHICA', '15638) BOYACA - SACHICA'],
     ['BOYACA - SAMACA', '15646) BOYACA - SAMACA'],
     ['BOYACA - SAN EDUARDO', '15660) BOYACA - SAN EDUARDO'],
     ['BOYACA - SAN JOSE DE PARE', '15664) BOYACA - SAN JOSE DE PARE'],
     ['BOYACA - SAN LUIS DE GACENO', '15667) BOYACA - SAN LUIS DE GACENO'],
     ['BOYACA - SAN MATEO', '15673) BOYACA - SAN MATEO'],
     ['BOYACA - SAN MIGUEL DE SEMA', '15676) BOYACA - SAN MIGUEL DE SEMA'],
     ['BOYACA - SAN PABLO DE BORBUR', '15681) BOYACA - SAN PABLO DE BORBUR'],
     ['BOYACA - SANTANA', '15686) BOYACA - SANTANA'],
     ['BOYACA - SANTA MARIA', '15690) BOYACA - SANTA MARIA'],
     ['BOYACA - SANTA ROSA DE VITERBO', '15693) BOYACA - SANTA ROSA DE VITERBO'],
     ['BOYACA - SANTA SOFIA', '15696) BOYACA - SANTA SOFIA'],
     ['BOYACA - SATIVANORTE', '15720) BOYACA - SATIVANORTE'],
     ['BOYACA - SATIVASUR', '15723) BOYACA - SATIVASUR'],
     ['BOYACA - SIACHOQUE', '15740) BOYACA - SIACHOQUE'],
     ['BOYACA - SOATA', '15753) BOYACA - SOATA'],
     ['BOYACA - SOCOTA', '15755) BOYACA - SOCOTA'],
     ['BOYACA - SOCHA', '15757) BOYACA - SOCHA'],
     ['BOYACA - SOGAMOSO', '15759) BOYACA - SOGAMOSO'],
     ['BOYACA - SOMONDOCO', '15761) BOYACA - SOMONDOCO'],
     ['BOYACA - SORA', '15762) BOYACA - SORA'],
     ['BOYACA - SOTAQUIRA', '15763) BOYACA - SOTAQUIRA'],
     ['BOYACA - SORACA', '15764) BOYACA - SORACA'],
     ['BOYACA - SUSACON', '15774) BOYACA - SUSACON'],
     ['BOYACA - SUTAMARCHAN', '15776) BOYACA - SUTAMARCHAN'],
     ['BOYACA - SUTATENZA', '15778) BOYACA - SUTATENZA'],
     ['BOYACA - TASCO', '15790) BOYACA - TASCO'],
     ['BOYACA - TENZA', '15798) BOYACA - TENZA'],
     ['BOYACA - TIBANA', '15804) BOYACA - TIBANA'],
     ['BOYACA - TIBASOSA', '15806) BOYACA - TIBASOSA'],
     ['BOYACA - TINJACA', '15808) BOYACA - TINJACA'],
     ['BOYACA - TIPACOQUE', '15810) BOYACA - TIPACOQUE'],
     ['BOYACA - TOCA', '15814) BOYACA - TOCA'],
     ['BOYACA - TOGUI', '15816) BOYACA - TOGUI'],
     ['BOYACA - TOPAGA', '15820) BOYACA - TOPAGA'],
     ['BOYACA - TOTA', '15822) BOYACA - TOTA'],
     ['BOYACA - TUNUNGA', '15832) BOYACA - TUNUNGA'],
     ['BOYACA - TURMEQUE', '15835) BOYACA - TURMEQUE'],
     ['BOYACA - TUTA', '15837) BOYACA - TUTA'],
     ['BOYACA - TUTAZA', '15839) BOYACA - TUTAZA'],
     ['BOYACA - UMBITA', '15842) BOYACA - UMBITA'],
     ['BOYACA - VENTAQUEMADA', '15861) BOYACA - VENTAQUEMADA'],
     ['BOYACA - VIRACACHA', '15879) BOYACA - VIRACACHA'],
     ['BOYACA - ZETAQUIRA', '15897) BOYACA - ZETAQUIRA'],
     ['CALDAS - MANIZALES', '17001) CALDAS - MANIZALES'],
     ['CALDAS - AGUADAS', '17013) CALDAS - AGUADAS'],
     ['CALDAS - ANSERMA', '17042) CALDAS - ANSERMA'],
     ['CALDAS - ARANZAZU', '17050) CALDAS - ARANZAZU'],
     ['CALDAS - BELALCAZAR', '17088) CALDAS - BELALCAZAR'],
     ['CALDAS - CHINCHINA', '17174) CALDAS - CHINCHINA'],
     ['CALDAS - FILADELFIA', '17272) CALDAS - FILADELFIA'],
     ['CALDAS - LA DORADA', '17380) CALDAS - LA DORADA'],
     ['CALDAS - LA MERCED', '17388) CALDAS - LA MERCED'],
     ['CALDAS - MANZANARES', '17433) CALDAS - MANZANARES'],
     ['CALDAS - MARMATO', '17442) CALDAS - MARMATO'],
     ['CALDAS - MARQUETALIA', '17444) CALDAS - MARQUETALIA'],
     ['CALDAS - MARULANDA', '17446) CALDAS - MARULANDA'],
     ['CALDAS - NEIRA', '17486) CALDAS - NEIRA'],
     ['CALDAS - NORCASIA (CALDAS)', '17495) CALDAS - NORCASIA (CALDAS)'],
     ['CALDAS - PACORA', '17513) CALDAS - PACORA'],
     ['CALDAS - PALESTINA', '17524) CALDAS - PALESTINA'],
     ['CALDAS - PENSILVANIA', '17541) CALDAS - PENSILVANIA'],
     ['CALDAS - RIOSUCIO', '17614) CALDAS - RIOSUCIO'],
     ['CALDAS - RISARALDA', '17616) CALDAS - RISARALDA'],
     ['CALDAS - SALAMINA', '17653) CALDAS - SALAMINA'],
     ['CALDAS - SAMANA', '17662) CALDAS - SAMANA'],
     ['CALDAS - SUPIA', '17777) CALDAS - SUPIA'],
     ['CALDAS - VICTORIA', '17867) CALDAS - VICTORIA'],
     ['CALDAS - VILLAMARIA', '17873) CALDAS - VILLAMARIA'],
     ['CALDAS - VITERBO', '17877) CALDAS - VITERBO'],
     ['CAQUETA - FLORENCIA', '18001) CAQUETA - FLORENCIA'],
     ['CAQUETA - ALBANIA', '18029) CAQUETA - ALBANIA'],
     ['CAQUETA - BELEN DE LOS ANDAQUIES', '18094) CAQUETA - BELEN DE LOS ANDAQUIES'],
     ['CAQUETA - CARTAGENA DEL CHAIRA', '18150) CAQUETA - CARTAGENA DEL CHAIRA'],
     ['CAQUETA - CURILLO', '18205) CAQUETA - CURILLO'],
     ['CAQUETA - EL DONCELLO', '18247) CAQUETA - EL DONCELLO'],
     ['CAQUETA - PAUJIL', '18256) CAQUETA - PAUJIL'],
     ['CAQUETA - MONTANITA', '18410) CAQUETA - MONTANITA'],
     ['CAQUETA - MILAN', '18460) CAQUETA - MILAN'],
     ['CAQUETA - MORELIA', '18479) CAQUETA - MORELIA'],
     ['CAQUETA - PUERTO RICO', '18592) CAQUETA - PUERTO RICO'],
     ['CAQUETA - SAN JOSE DEL FRAGUA', '18610) CAQUETA - SAN JOSE DEL FRAGUA'],
     ['CAQUETA - SAN VICENTE DEL CAGUAN', '18753) CAQUETA - SAN VICENTE DEL CAGUAN'],
     ['CAQUETA - SOLANO', '18756) CAQUETA - SOLANO'],
     ['CAQUETA - SOLANO', '18765) CAQUETA - SOLANO'],
     ['CAQUETA - SOLITA', '18785) CAQUETA - SOLITA'],
     ['CAQUETA - VALPARAISO', '18860) CAQUETA - VALPARAISO'],
     ['CAUCA - POPAYAN', '19001) CAUCA - POPAYAN'],
     ['CAUCA - ALMAGUER', '19022) CAUCA - ALMAGUER'],
     ['CAUCA - ARGELIA', '19050) CAUCA - ARGELIA'],
     ['CAUCA - BALBOA', '19075) CAUCA - BALBOA'],
     ['CAUCA - BOLIVAR', '19100) CAUCA - BOLIVAR'],
     ['CAUCA - BUENOS AIRES', '19110) CAUCA - BUENOS AIRES'],
     ['CAUCA - CAJIBIO', '19130) CAUCA - CAJIBIO'],
     ['CAUCA - CALDONO', '19137) CAUCA - CALDONO'],
     ['CAUCA - CALOTO', '19142) CAUCA - CALOTO'],
     ['CAUCA - CORINTO', '19212) CAUCA - CORINTO'],
     ['CAUCA - EL TAMBO', '19256) CAUCA - EL TAMBO'],
     ['CAUCA - FLORENCIA', '19290) CAUCA - FLORENCIA'],
     ['CAUCA - GUAPI', '19318) CAUCA - GUAPI'],
     ['CAUCA - INZA', '19355) CAUCA - INZA'],
     ['CAUCA - JAMBALO', '19364) CAUCA - JAMBALO'],
     ['CAUCA - LA SIERRA', '19392) CAUCA - LA SIERRA'],
     ['CAUCA - LA VEGA', '19397) CAUCA - LA VEGA'],
     ['CAUCA - LOPEZ', '19418) CAUCA - LOPEZ'],
     ['CAUCA - MERCADERES', '19450) CAUCA - MERCADERES'],
     ['CAUCA - MIRANDA', '19455) CAUCA - MIRANDA'],
     ['CAUCA - MORALES', '19473) CAUCA - MORALES'],
     ['CAUCA - PADILLA', '19513) CAUCA - PADILLA'],
     ['CAUCA - PAEZ (BELALCAZAR)', '19517) CAUCA - PAEZ (BELALCAZAR)'],
     ['CAUCA - PATIA (EL BORDO)', '19532) CAUCA - PATIA (EL BORDO)'],
     ['CAUCA - PIENDAMO', '19548) CAUCA - PIENDAMO'],
     ['CAUCA - PUERTO TEJADA', '19573) CAUCA - PUERTO TEJADA'],
     ['CAUCA - PURACE (COCONUCO)', '19585) CAUCA - PURACE (COCONUCO)'],
     ['CAUCA - ROSAS', '19622) CAUCA - ROSAS'],
     ['CAUCA - SAN SEBASTIAN', '19693) CAUCA - SAN SEBASTIAN'],
     ['CAUCA - SANTANDER DE QUILICHAO', '19698) CAUCA - SANTANDER DE QUILICHAO'],
     ['CAUCA - SANTA ROSA', '19701) CAUCA - SANTA ROSA'],
     ['CAUCA - SILVIA', '19743) CAUCA - SILVIA'],
     ['CAUCA - SOTARA (PAISPAMBA)', '19760) CAUCA - SOTARA (PAISPAMBA)'],
     ['CAUCA - SUAREZ', '19780) CAUCA - SUAREZ'],
     ['CAUCA - SUCRE (CAUCA)', '19785) CAUCA - SUCRE (CAUCA)'],
     ['CAUCA - TIMBIO', '19807) CAUCA - TIMBIO'],
     ['CAUCA - TIMBIQUI', '19809) CAUCA - TIMBIQUI'],
     ['CAUCA - TORIBIO', '19821) CAUCA - TORIBIO'],
     ['CAUCA - TOTORO', '19824) CAUCA - TOTORO'],
     ['CESAR - VALLEDUPAR', '20001) CESAR - VALLEDUPAR'],
     ['CESAR - AGUACHICA', '20011) CESAR - AGUACHICA'],
     ['CESAR - AGUSTIN CODAZZI', '20013) CESAR - AGUSTIN CODAZZI'],
     ['CESAR - ASTREA', '20032) CESAR - ASTREA'],
     ['CESAR - BECERRIL', '20045) CESAR - BECERRIL'],
     ['CESAR - BOSCONIA', '20060) CESAR - BOSCONIA'],
     ['CESAR - CHIMICHAGUA', '20175) CESAR - CHIMICHAGUA'],
     ['CESAR - CHIRIGUANA', '20178) CESAR - CHIRIGUANA'],
     ['CESAR - CURUMANI', '20228) CESAR - CURUMANI'],
     ['CESAR - EL COPEY', '20238) CESAR - EL COPEY'],
     ['CESAR - EL PASO', '20250) CESAR - EL PASO'],
     ['CESAR - GAMARRA', '20295) CESAR - GAMARRA'],
     ['CESAR - GONZALEZ', '20310) CESAR - GONZALEZ'],
     ['CESAR - LA GLORIA', '20383) CESAR - LA GLORIA'],
     ['CESAR - LA JAGUA DE IBIRICO', '20400) CESAR - LA JAGUA DE IBIRICO'],
     ['CESAR - MANAURE BALCON DEL CESAR', '20443) CESAR - MANAURE BALCON DEL CESAR'],
     ['CESAR - PAILITAS', '20517) CESAR - PAILITAS'],
     ['CESAR - PELAYA', '20550) CESAR - PELAYA'],
     ['CESAR - RIO DE ORO', '20614) CESAR - RIO DE ORO'],
     ['CESAR - LA PAZ', '20621) CESAR - LA PAZ'],
     ['CESAR - SAN ALBERTO', '20710) CESAR - SAN ALBERTO'],
     ['CESAR - SAN DIEGO', '20750) CESAR - SAN DIEGO'],
     ['CESAR - SAN MARTIN', '20770) CESAR - SAN MARTIN'],
     ['CESAR - TAMALAMEQUE', '20787) CESAR - TAMALAMEQUE'],
     ['CORDOBA - MONTERIA', '23001) CORDOBA - MONTERIA'],
     ['CORDOBA - AYAPEL', '23068) CORDOBA - AYAPEL'],
     ['CORDOBA - BUENAVISTA', '23079) CORDOBA - BUENAVISTA'],
     ['CORDOBA - CANALETE', '23090) CORDOBA - CANALETE'],
     ['CORDOBA - CERETE', '23162) CORDOBA - CERETE'],
     ['CORDOBA - CHIMA', '23168) CORDOBA - CHIMA'],
     ['CORDOBA - CHINU', '23182) CORDOBA - CHINU'],
     ['CORDOBA - CIENAGA DE ORO', '23189) CORDOBA - CIENAGA DE ORO'],
     ['CORDOBA - COTORRA', '23300) CORDOBA - COTORRA'],
     ['CORDOBA - LA APARTADA', '23350) CORDOBA - LA APARTADA'],
     ['CORDOBA - LORICA', '23417) CORDOBA - LORICA'],
     ['CORDOBA - LOS CORDOBAS', '23419) CORDOBA - LOS CORDOBAS'],
     ['CORDOBA - MOMIL', '23464) CORDOBA - MOMIL'],
     ['CORDOBA - MONTELIBANO', '23466) CORDOBA - MONTELIBANO'],
     ['CORDOBA - MOÑITOS', '23500) CORDOBA - MOÑITOS'],
     ['CORDOBA - PLANETA RICA', '23555) CORDOBA - PLANETA RICA'],
     ['CORDOBA - PUEBLO NUEVO', '23570) CORDOBA - PUEBLO NUEVO'],
     ['CORDOBA - PUERTO ESCONDIDO', '23574) CORDOBA - PUERTO ESCONDIDO'],
     ['CORDOBA - PUERTO LIBERTADOR', '23580) CORDOBA - PUERTO LIBERTADOR'],
     ['CORDOBA - PURISIMA', '23586) CORDOBA - PURISIMA'],
     ['CORDOBA - SAHAGUN', '23660) CORDOBA - SAHAGUN'],
     ['CORDOBA - SAN ANDRES DE SOTAVENTO', '23670) CORDOBA - SAN ANDRES DE SOTAVENTO'],
     ['CORDOBA - SAN ANTERO', '23672) CORDOBA - SAN ANTERO'],
     ['CORDOBA - SAN BERNARDO DEL VIENTO', '23675) CORDOBA - SAN BERNARDO DEL VIENTO'],
     ['CORDOBA - SAN CARLOS', '23678) CORDOBA - SAN CARLOS'],
     ['CORDOBA - SAN JOSÉ DE URÉ', '23682) CORDOBA - SAN JOSÉ DE URÉ'],
     ['CORDOBA - SAN PELAYO', '23686) CORDOBA - SAN PELAYO'],
     ['CORDOBA - TIERRALTA', '23807) CORDOBA - TIERRALTA'],
     ['CORDOBA - TUCHÍN', '23815) CORDOBA - TUCHÍN'],
     ['CORDOBA - VALENCIA', '23855) CORDOBA - VALENCIA'],
     ['CUNDINAMARCA - AGUA DE DIOS', '25001) CUNDINAMARCA - AGUA DE DIOS'],
     ['CUNDINAMARCA - ALBAN', '25019) CUNDINAMARCA - ALBAN'],
     ['CUNDINAMARCA - ANAPOIMA', '25035) CUNDINAMARCA - ANAPOIMA'],
     ['CUNDINAMARCA - ANOLAIMA', '25040) CUNDINAMARCA - ANOLAIMA'],
     ['CUNDINAMARCA - ARBELAEZ', '25053) CUNDINAMARCA - ARBELAEZ'],
     ['CUNDINAMARCA - BELTRAN', '25086) CUNDINAMARCA - BELTRAN'],
     ['CUNDINAMARCA - BITUIMA', '25095) CUNDINAMARCA - BITUIMA'],
     ['CUNDINAMARCA - BOJACA', '25099) CUNDINAMARCA - BOJACA'],
     ['CUNDINAMARCA - CABRERA', '25120) CUNDINAMARCA - CABRERA'],
     ['CUNDINAMARCA - CACHIPAY', '25123) CUNDINAMARCA - CACHIPAY'],
     ['CUNDINAMARCA - CAJICA', '25126) CUNDINAMARCA - CAJICA'],
     ['CUNDINAMARCA - CAPARRAPI', '25148) CUNDINAMARCA - CAPARRAPI'],
     ['CUNDINAMARCA - CAQUEZA', '25151) CUNDINAMARCA - CAQUEZA'],
     ['CUNDINAMARCA - CARMEN DE CARUPA', '25154) CUNDINAMARCA - CARMEN DE CARUPA'],
     ['CUNDINAMARCA - CHAGUANI', '25168) CUNDINAMARCA - CHAGUANI'],
     ['CUNDINAMARCA - CHIA', '25175) CUNDINAMARCA - CHIA'],
     ['CUNDINAMARCA - CHIPAQUE', '25178) CUNDINAMARCA - CHIPAQUE'],
     ['CUNDINAMARCA - CHOACHI', '25181) CUNDINAMARCA - CHOACHI'],
     ['CUNDINAMARCA - CHOCONTA', '25183) CUNDINAMARCA - CHOCONTA'],
     ['CUNDINAMARCA - COGUA', '25200) CUNDINAMARCA - COGUA'],
     ['CUNDINAMARCA - COTA', '25214) CUNDINAMARCA - COTA'],
     ['CUNDINAMARCA - CUCUNUBA', '25224) CUNDINAMARCA - CUCUNUBA'],
     ['CUNDINAMARCA - EL COLEGIO', '25245) CUNDINAMARCA - EL COLEGIO'],
     ['CUNDINAMARCA - EL PEÑON', '25258) CUNDINAMARCA - EL PEÑON'],
     ['CUNDINAMARCA - EL ROSAL', '25260) CUNDINAMARCA - EL ROSAL'],
     ['CUNDINAMARCA - FACATATIVA', '25269) CUNDINAMARCA - FACATATIVA'],
     ['CUNDINAMARCA - FOMEQUE', '25279) CUNDINAMARCA - FOMEQUE'],
     ['CUNDINAMARCA - FOSCA', '25281) CUNDINAMARCA - FOSCA'],
     ['CUNDINAMARCA - FUNZA', '25286) CUNDINAMARCA - FUNZA'],
     ['CUNDINAMARCA - FUQUENE', '25288) CUNDINAMARCA - FUQUENE'],
     ['CUNDINAMARCA - FUSAGASUGA', '25290) CUNDINAMARCA - FUSAGASUGA'],
     ['CUNDINAMARCA - GACHALA', '25293) CUNDINAMARCA - GACHALA'],
     ['CUNDINAMARCA - GACHANCIPA', '25295) CUNDINAMARCA - GACHANCIPA'],
     ['CUNDINAMARCA - GACHETA', '25297) CUNDINAMARCA - GACHETA'],
     ['CUNDINAMARCA - GAMA', '25299) CUNDINAMARCA - GAMA'],
     ['CUNDINAMARCA - GIRARDOT', '25307) CUNDINAMARCA - GIRARDOT'],
     ['CUNDINAMARCA - GRANADA', '25312) CUNDINAMARCA - GRANADA'],
     ['CUNDINAMARCA - GUACHETA', '25317) CUNDINAMARCA - GUACHETA'],
     ['CUNDINAMARCA - GUADUAS', '25320) CUNDINAMARCA - GUADUAS'],
     ['CUNDINAMARCA - GUASCA', '25322) CUNDINAMARCA - GUASCA'],
     ['CUNDINAMARCA - GUATAQUI', '25324) CUNDINAMARCA - GUATAQUI'],
     ['CUNDINAMARCA - GUATAVITA', '25326) CUNDINAMARCA - GUATAVITA'],
     ['CUNDINAMARCA - GUAYABAL DE SIQUIMA', '25328) CUNDINAMARCA - GUAYABAL DE SIQUIMA'],
     ['CUNDINAMARCA - GUAYABETAL', '25335) CUNDINAMARCA - GUAYABETAL'],
     ['CUNDINAMARCA - GUTIERREZ', '25339) CUNDINAMARCA - GUTIERREZ'],
     ['CUNDINAMARCA - JERUSALEN', '25368) CUNDINAMARCA - JERUSALEN'],
     ['CUNDINAMARCA - JUNIN', '25372) CUNDINAMARCA - JUNIN'],
     ['CUNDINAMARCA - LA CALERA', '25377) CUNDINAMARCA - LA CALERA'],
     ['CUNDINAMARCA - LA MESA', '25386) CUNDINAMARCA - LA MESA'],
     ['CUNDINAMARCA - LA PALMA', '25394) CUNDINAMARCA - LA PALMA'],
     ['CUNDINAMARCA - LA PEYA', '25398) CUNDINAMARCA - LA PEYA'],
     ['CUNDINAMARCA - LA VEGA', '25402) CUNDINAMARCA - LA VEGA'],
     ['CUNDINAMARCA - LENGUAZAQUE', '25407) CUNDINAMARCA - LENGUAZAQUE'],
     ['CUNDINAMARCA - MACHETA', '25426) CUNDINAMARCA - MACHETA'],
     ['CUNDINAMARCA - MADRID', '25430) CUNDINAMARCA - MADRID'],
     ['CUNDINAMARCA - MANTA', '25436) CUNDINAMARCA - MANTA'],
     ['CUNDINAMARCA - MEDINA', '25438) CUNDINAMARCA - MEDINA'],
     ['CUNDINAMARCA - MOSQUERA', '25473) CUNDINAMARCA - MOSQUERA'],
     ['CUNDINAMARCA - NARIO', '25483) CUNDINAMARCA - NARIO'],
     ['CUNDINAMARCA - NEMOCON', '25486) CUNDINAMARCA - NEMOCON'],
     ['CUNDINAMARCA - NILO', '25488) CUNDINAMARCA - NILO'],
     ['CUNDINAMARCA - NIMAIMA', '25489) CUNDINAMARCA - NIMAIMA'],
     ['CUNDINAMARCA - NOCAIMA', '25491) CUNDINAMARCA - NOCAIMA'],
     ['CUNDINAMARCA - VENECIA', '25506) CUNDINAMARCA - VENECIA'],
     ['CUNDINAMARCA - PACHO', '25513) CUNDINAMARCA - PACHO'],
     ['CUNDINAMARCA - PAIME', '25518) CUNDINAMARCA - PAIME'],
     ['CUNDINAMARCA - PANDI', '25524) CUNDINAMARCA - PANDI'],
     ['CUNDINAMARCA - PARATEBUENO', '25530) CUNDINAMARCA - PARATEBUENO'],
     ['CUNDINAMARCA - PASCA', '25535) CUNDINAMARCA - PASCA'],
     ['CUNDINAMARCA - PUERTO SALGAR', '25572) CUNDINAMARCA - PUERTO SALGAR'],
     ['CUNDINAMARCA - PULI', '25580) CUNDINAMARCA - PULI'],
     ['CUNDINAMARCA - QUEBRADANEGRA', '25592) CUNDINAMARCA - QUEBRADANEGRA'],
     ['CUNDINAMARCA - QUETAME', '25594) CUNDINAMARCA - QUETAME'],
     ['CUNDINAMARCA - QUIPILE', '25596) CUNDINAMARCA - QUIPILE'],
     ['CUNDINAMARCA - APULO', '25599) CUNDINAMARCA - APULO'],
     ['CUNDINAMARCA - RICAURTE', '25612) CUNDINAMARCA - RICAURTE'],
     ['CUNDINAMARCA - SAN ANTONIO DEL TEQUENDAMA', '25645) CUNDINAMARCA - SAN ANTONIO DEL TEQUENDAMA'],
     ['CUNDINAMARCA - SAN BERNARDO', '25649) CUNDINAMARCA - SAN BERNARDO'],
     ['CUNDINAMARCA - SAN CAYETANO', '25653) CUNDINAMARCA - SAN CAYETANO'],
     ['CUNDINAMARCA - SAN FRANCISCO', '25658) CUNDINAMARCA - SAN FRANCISCO'],
     ['CUNDINAMARCA - SAN JUAN DE RIOSECO', '25662) CUNDINAMARCA - SAN JUAN DE RIOSECO'],
     ['CUNDINAMARCA - SASAIMA', '25718) CUNDINAMARCA - SASAIMA'],
     ['CUNDINAMARCA - SESQUILE', '25736) CUNDINAMARCA - SESQUILE'],
     ['CUNDINAMARCA - SIBATE', '25740) CUNDINAMARCA - SIBATE'],
     ['CUNDINAMARCA - SILVANIA', '25743) CUNDINAMARCA - SILVANIA'],
     ['CUNDINAMARCA - SIMIJACA', '25745) CUNDINAMARCA - SIMIJACA'],
     ['CUNDINAMARCA - SOACHA', '25754) CUNDINAMARCA - SOACHA'],
     ['CUNDINAMARCA - SOPO', '25758) CUNDINAMARCA - SOPO'],
     ['CUNDINAMARCA - SUBACHOQUE', '25769) CUNDINAMARCA - SUBACHOQUE'],
     ['CUNDINAMARCA - SUESCA', '25772) CUNDINAMARCA - SUESCA'],
     ['CUNDINAMARCA - SUPATA', '25777) CUNDINAMARCA - SUPATA'],
     ['CUNDINAMARCA - SUSA', '25779) CUNDINAMARCA - SUSA'],
     ['CUNDINAMARCA - SUTATAUSA', '25781) CUNDINAMARCA - SUTATAUSA'],
     ['CUNDINAMARCA - TABIO', '25785) CUNDINAMARCA - TABIO'],
     ['CUNDINAMARCA - TAUSA', '25793) CUNDINAMARCA - TAUSA'],
     ['CUNDINAMARCA - TENA', '25797) CUNDINAMARCA - TENA'],
     ['CUNDINAMARCA - TENJO', '25799) CUNDINAMARCA - TENJO'],
     ['CUNDINAMARCA - TIBACUY', '25805) CUNDINAMARCA - TIBACUY'],
     ['CUNDINAMARCA - TIBIRITA', '25807) CUNDINAMARCA - TIBIRITA'],
     ['CUNDINAMARCA - TOCAIMA', '25815) CUNDINAMARCA - TOCAIMA'],
     ['CUNDINAMARCA - TOCANCIPA', '25817) CUNDINAMARCA - TOCANCIPA'],
     ['CUNDINAMARCA - TOPAIPI', '25823) CUNDINAMARCA - TOPAIPI'],
     ['CUNDINAMARCA - UBALA', '25839) CUNDINAMARCA - UBALA'],
     ['CUNDINAMARCA - UBAQUE', '25841) CUNDINAMARCA - UBAQUE'],
     ['CUNDINAMARCA - UBATE', '25843) CUNDINAMARCA - UBATE'],
     ['CUNDINAMARCA - UNE', '25845) CUNDINAMARCA - UNE'],
     ['CUNDINAMARCA - UTICA', '25851) CUNDINAMARCA - UTICA'],
     ['CUNDINAMARCA - VERGARA', '25862) CUNDINAMARCA - VERGARA'],
     ['CUNDINAMARCA - VIANI', '25867) CUNDINAMARCA - VIANI'],
     ['CUNDINAMARCA - VILLAGOMEZ', '25871) CUNDINAMARCA - VILLAGOMEZ'],
     ['CUNDINAMARCA - VILLAPINZON', '25873) CUNDINAMARCA - VILLAPINZON'],
     ['CUNDINAMARCA - VILLETA', '25875) CUNDINAMARCA - VILLETA'],
     ['CUNDINAMARCA - VIOTA', '25878) CUNDINAMARCA - VIOTA'],
     ['CUNDINAMARCA - YACOPI', '25885) CUNDINAMARCA - YACOPI'],
     ['CUNDINAMARCA - ULALA', '25890) CUNDINAMARCA - ULALA'],
     ['CUNDINAMARCA - ZIPACON', '25898) CUNDINAMARCA - ZIPACON'],
     ['CUNDINAMARCA - ZIPAQUIRA', '25899) CUNDINAMARCA - ZIPAQUIRA'],
     ['CHOCO - QUIBDO', '27001) CHOCO - QUIBDO'],
     ['CHOCO - ACANDI', '27006) CHOCO - ACANDI'],
     ['CHOCO - ALTO BAUDO (PIE DE PATO)', '27025) CHOCO - ALTO BAUDO (PIE DE PATO)'],
     ['CHOCO - ATRATO (CHOCO)', '27050) CHOCO - ATRATO (CHOCO)'],
     ['CHOCO - BAGADO', '27073) CHOCO - BAGADO'],
     ['CHOCO - BAHIA SOLANO (MUTIS)', '27075) CHOCO - BAHIA SOLANO (MUTIS)'],
     ['CHOCO - BAJO BAUDO (PIZARRO)', '27077) CHOCO - BAJO BAUDO (PIZARRO)'],
     ['CHOCO - BLEN DE BAJIRA (CHOCO)', '27086) CHOCO - BLEN DE BAJIRA (CHOCO)'],
     ['CHOCO - BOJAYA (BELLAVISTA)', '27099) CHOCO - BOJAYA (BELLAVISTA)'],
     ['CHOCO - EL CANTON DE SAN PABLO (MANAGRU)', '27135) CHOCO - EL CANTON DE SAN PABLO (MANAGRU)'],
     ['CHOCO - CARMEN DEL DARIEN (CHOCO)', '27150) CHOCO - CARMEN DEL DARIEN (CHOCO)'],
     ['CHOCO - CONDOTO', '27205) CHOCO - CONDOTO'],
     ['CHOCO - EL CARMEN DE ATRATO', '27245) CHOCO - EL CARMEN DE ATRATO'],
     ['CHOCO - EL LITORAL DEL SAN JUAN (DOCORDO)', '27250) CHOCO - EL LITORAL DEL SAN JUAN (DOCORDO)'],
     ['CHOCO - ISTMINA', '27361) CHOCO - ISTMINA'],
     ['CHOCO - JURADO', '27372) CHOCO - JURADO'],
     ['CHOCO - LLORO', '27413) CHOCO - LLORO'],
     ['CHOCO - NOVITA', '27491) CHOCO - NOVITA'],
     ['CHOCO - NUQUI', '27495) CHOCO - NUQUI'],
     ['CHOCO - RIO IRO (CHOCO)', '27580) CHOCO - RIO IRO (CHOCO)'],
     ['CHOCO - RIOSUCIO', '27615) CHOCO - RIOSUCIO'],
     ['CHOCO - SAN JOSE DEL PALMAR', '27660) CHOCO - SAN JOSE DEL PALMAR'],
     ['CHOCO - SIPI', '27745) CHOCO - SIPI'],
     ['CHOCO - TADO', '27787) CHOCO - TADO'],
     ['CHOCO - UNGUIA', '27800) CHOCO - UNGUIA'],
     ['HUILA - NEIVA', '41001) HUILA - NEIVA'],
     ['HUILA - ACEVEDO', '41006) HUILA - ACEVEDO'],
     ['HUILA - AGRADO', '41013) HUILA - AGRADO'],
     ['HUILA - AIPE', '41016) HUILA - AIPE'],
     ['HUILA - ALGECIRAS', '41020) HUILA - ALGECIRAS'],
     ['HUILA - ALTAMIRA', '41026) HUILA - ALTAMIRA'],
     ['HUILA - BARAYA', '41078) HUILA - BARAYA'],
     ['HUILA - CAMPOALEGRE', '41132) HUILA - CAMPOALEGRE'],
     ['HUILA - COLOMBIA', '41206) HUILA - COLOMBIA'],
     ['HUILA - ELIAS', '41244) HUILA - ELIAS'],
     ['HUILA - GARZON', '41298) HUILA - GARZON'],
     ['HUILA - GIGANTE', '41306) HUILA - GIGANTE'],
     ['HUILA - GUADALUPE', '41319) HUILA - GUADALUPE'],
     ['HUILA - HOBO', '41349) HUILA - HOBO'],
     ['HUILA - IQUIRA', '41357) HUILA - IQUIRA'],
     ['HUILA - ISNOS', '41359) HUILA - ISNOS'],
     ['HUILA - LA ARGENTINA', '41378) HUILA - LA ARGENTINA'],
     ['HUILA - LA PLATA', '41396) HUILA - LA PLATA'],
     ['HUILA - NATAGA', '41483) HUILA - NATAGA'],
     ['HUILA - OPORAPA', '41503) HUILA - OPORAPA'],
     ['HUILA - PAICOL', '41518) HUILA - PAICOL'],
     ['HUILA - PALERMO', '41524) HUILA - PALERMO'],
     ['HUILA - PALESTINA', '41530) HUILA - PALESTINA'],
     ['HUILA - PITAL', '41548) HUILA - PITAL'],
     ['HUILA - PITALITO', '41551) HUILA - PITALITO'],
     ['HUILA - RIVERA', '41615) HUILA - RIVERA'],
     ['HUILA - SALADOBLANCO', '41660) HUILA - SALADOBLANCO'],
     ['HUILA - SAN AGUSTIN', '41668) HUILA - SAN AGUSTIN'],
     ['HUILA - SANTA MARIA', '41676) HUILA - SANTA MARIA'],
     ['HUILA - SUAZA', '41770) HUILA - SUAZA'],
     ['HUILA - TARQUI', '41791) HUILA - TARQUI'],
     ['HUILA - TESALIA', '41797) HUILA - TESALIA'],
     ['HUILA - TELLO', '41799) HUILA - TELLO'],
     ['HUILA - TERUEL', '41801) HUILA - TERUEL'],
     ['HUILA - TIMANA', '41807) HUILA - TIMANA'],
     ['HUILA - VILLAVIEJA', '41872) HUILA - VILLAVIEJA'],
     ['HUILA - YAGUARA', '41885) HUILA - YAGUARA'],
     ['GUAJIRA - RIOHACHA', '44001) GUAJIRA - RIOHACHA'],
     ['GUAJIRA - ALBANIA (GUAJIRA)', '44035) GUAJIRA - ALBANIA (GUAJIRA)'],
     ['GUAJIRA - BARRANCAS', '44078) GUAJIRA - BARRANCAS'],
     ['GUAJIRA - DIBULLA', '44090) GUAJIRA - DIBULLA'],
     ['GUAJIRA - DISTRACCION', '44098) GUAJIRA - DISTRACCION'],
     ['GUAJIRA - EL MOLINO', '44110) GUAJIRA - EL MOLINO'],
     ['GUAJIRA - FONSECA', '44279) GUAJIRA - FONSECA'],
     ['GUAJIRA - HATO NUEVO', '44378) GUAJIRA - HATO NUEVO'],
     ['GUAJIRA - MAICAO', '44430) GUAJIRA - MAICAO'],
     ['GUAJIRA - MANAURE', '44560) GUAJIRA - MANAURE'],
     ['GUAJIRA - SAN JUAN DEL CESAR', '44650) GUAJIRA - SAN JUAN DEL CESAR'],
     ['GUAJIRA - URIBIA', '44847) GUAJIRA - URIBIA'],
     ['GUAJIRA - URUMITA', '44855) GUAJIRA - URUMITA'],
     ['GUAJIRA - VILLANUEVA', '44874) GUAJIRA - VILLANUEVA'],
     ['MAGDALENA - SANTA MARTA', '47001) MAGDALENA - SANTA MARTA'],
     ['MAGDALENA - ALGARROBO (MAGDALENA)', '47030) MAGDALENA - ALGARROBO (MAGDALENA)'],
     ['MAGDALENA - ARACATACA', '47053) MAGDALENA - ARACATACA'],
     ['MAGDALENA - ARIGUANI (EL DIFICIL)', '47058) MAGDALENA - ARIGUANI (EL DIFICIL)'],
     ['MAGDALENA - CERRO DE SAN ANTONIO', '47161) MAGDALENA - CERRO DE SAN ANTONIO'],
     ['MAGDALENA - CHIVOLO', '47170) MAGDALENA - CHIVOLO'],
     ['MAGDALENA - CIENAGA', '47189) MAGDALENA - CIENAGA'],
     ['MAGDALENA - EL BANCO', '47245) MAGDALENA - EL BANCO'],
     ['MAGDALENA - EL PINON', '47258) MAGDALENA - EL PINON'],
     ['MAGDALENA - EL RETEN', '47268) MAGDALENA - EL RETEN'],
     ['MAGDALENA - FUNDACION', '47288) MAGDALENA - FUNDACION'],
     ['MAGDALENA - GUAMAL', '47318) MAGDALENA - GUAMAL'],
     ['MAGDALENA - NUEVA GRANADA (MAGDALENA)', '47460) MAGDALENA - NUEVA GRANADA (MAGDALENA)'],
     ['MAGDALENA - PEDRAZA', '47541) MAGDALENA - PEDRAZA'],
     ['MAGDALENA - PIJINO DEL CARMEN', '47545) MAGDALENA - PIJINO DEL CARMEN'],
     ['MAGDALENA - PIVIJAY', '47551) MAGDALENA - PIVIJAY'],
     ['MAGDALENA - PLATO', '47555) MAGDALENA - PLATO'],
     ['MAGDALENA - PUEBLOVIEJO', '47570) MAGDALENA - PUEBLOVIEJO'],
     ['MAGDALENA - REMOLINO', '47605) MAGDALENA - REMOLINO'],
     ['MAGDALENA - SALAMINA', '47675) MAGDALENA - SALAMINA'],
     ['MAGDALENA - SAN SEBASTIAN DE BUENAVISTA', '47692) MAGDALENA - SAN SEBASTIAN DE BUENAVISTA'],
     ['MAGDALENA - SAN ZENON', '47703) MAGDALENA - SAN ZENON'],
     ['MAGDALENA - SANTA ANA', '47707) MAGDALENA - SANTA ANA'],
     ['MAGDALENA - SITIONUEVO', '47745) MAGDALENA - SITIONUEVO'],
     ['MAGDALENA - TENERIFE', '47798) MAGDALENA - TENERIFE'],
     ['MAGDALENA - ZONA BANANERA (MAGDALENA)', '47980) MAGDALENA - ZONA BANANERA (MAGDALENA)'],
     ['META - VILLAVICENCIO', '50001) META - VILLAVICENCIO'],
     ['META - ACACIAS', '50006) META - ACACIAS'],
     ['META - BARRANCA DE UPIA', '50110) META - BARRANCA DE UPIA'],
     ['META - CABUYARO', '50124) META - CABUYARO'],
     ['META - CASTILLA LA NUEVA', '50150) META - CASTILLA LA NUEVA'],
     ['META - CUBARRAL', '50223) META - CUBARRAL'],
     ['META - CUMARAL', '50226) META - CUMARAL'],
     ['META - EL CALVARIO', '50245) META - EL CALVARIO'],
     ['META - EL CASTILLO', '50251) META - EL CASTILLO'],
     ['META - EL DORADO', '50270) META - EL DORADO'],
     ['META - FUENTE DE ORO', '50287) META - FUENTE DE ORO'],
     ['META - GRANADA', '50313) META - GRANADA'],
     ['META - GUAMAL', '50318) META - GUAMAL'],
     ['META - MAPIRIPAN', '50325) META - MAPIRIPAN'],
     ['META - MESETAS', '50330) META - MESETAS'],
     ['META - LA MACARENA', '50350) META - LA MACARENA'],
     ['META - URIBE', '50370) META - URIBE'],
     ['META - LEJANIAS', '50400) META - LEJANIAS'],
     ['META - PUERTO CONCORDIA', '50450) META - PUERTO CONCORDIA'],
     ['META - PUERTO GAITAN', '50568) META - PUERTO GAITAN'],
     ['META - PUERTO LOPEZ', '50573) META - PUERTO LOPEZ'],
     ['META - PUERTO LLERAS', '50577) META - PUERTO LLERAS'],
     ['META - PUERTO RICO', '50590) META - PUERTO RICO'],
     ['META - RESTREPO', '50606) META - RESTREPO'],
     ['META - SAN CARLOS DE GUAROA', '50680) META - SAN CARLOS DE GUAROA'],
     ['META - SAN JUAN DE ARAMA', '50683) META - SAN JUAN DE ARAMA'],
     ['META - SAN JUANITO', '50686) META - SAN JUANITO'],
     ['META - SAN MARTIN', '50689) META - SAN MARTIN'],
     ['META - VISTAHERMOSA', '50711) META - VISTAHERMOSA'],
     ['NARINIO - PASTO', '52001) NARINIO - PASTO'],
     ['NARINIO - ALBAN (SAN JOSE)', '52019) NARINIO - ALBAN (SAN JOSE)'],
     ['NARINIO - ALDANA', '52022) NARINIO - ALDANA'],
     ['NARINIO - ANCUYA', '52036) NARINIO - ANCUYA'],
     ['NARINIO - ARBOLEDA (BERRUECOS)', '52051) NARINIO - ARBOLEDA (BERRUECOS)'],
     ['NARINIO - BARBACOAS', '52079) NARINIO - BARBACOAS'],
     ['NARINIO - BELEN', '52083) NARINIO - BELEN'],
     ['NARINIO - BUESACO', '52110) NARINIO - BUESACO'],
     ['NARINIO - COLON (GENOVA)', '52203) NARINIO - COLON (GENOVA)'],
     ['NARINIO - CONSACA', '52207) NARINIO - CONSACA'],
     ['NARINIO - CONTADERO', '52210) NARINIO - CONTADERO'],
     ['NARINIO - CORDOBA', '52215) NARINIO - CORDOBA'],
     ['NARINIO - CUASPUD (CARLOSAMA)', '52224) NARINIO - CUASPUD (CARLOSAMA)'],
     ['NARINIO - CUMBAL', '52227) NARINIO - CUMBAL'],
     ['NARINIO - CUMBITARA', '52233) NARINIO - CUMBITARA'],
     ['NARINIO - CHACHAGUI', '52240) NARINIO - CHACHAGUI'],
     ['NARINIO - EL CHARCO', '52250) NARINIO - EL CHARCO'],
     ['NARINIO - EL ROSARIO', '52256) NARINIO - EL ROSARIO'],
     ['NARINIO - EL TABLON DE GOMEZ', '52258) NARINIO - EL TABLON DE GOMEZ'],
     ['NARINIO - EL TAMBO', '52260) NARINIO - EL TAMBO'],
     ['NARINIO - FUNES', '52287) NARINIO - FUNES'],
     ['NARINIO - GUACHUCAL', '52317) NARINIO - GUACHUCAL'],
     ['NARINIO - GUAITARILLA', '52320) NARINIO - GUAITARILLA'],
     ['NARINIO - GUALMATAN', '52323) NARINIO - GUALMATAN'],
     ['NARINIO - ILES', '52352) NARINIO - ILES'],
     ['NARINIO - IMUES', '52354) NARINIO - IMUES'],
     ['NARINIO - IPIALES', '52356) NARINIO - IPIALES'],
     ['NARINIO - LA CRUZ', '52378) NARINIO - LA CRUZ'],
     ['NARINIO - LA FLORIDA', '52381) NARINIO - LA FLORIDA'],
     ['NARINIO - LA LLANADA', '52385) NARINIO - LA LLANADA'],
     ['NARINIO - LA TOLA', '52390) NARINIO - LA TOLA'],
     ['NARINIO - LA UNION', '52399) NARINIO - LA UNION'],
     ['NARINIO - LEIVA', '52405) NARINIO - LEIVA'],
     ['NARINIO - LINARES', '52411) NARINIO - LINARES'],
     ['NARINIO - LOS ANDES (SOTOMAYOR)', '52418) NARINIO - LOS ANDES (SOTOMAYOR)'],
     ['NARINIO - MAGUI (PAYAN)', '52427) NARINIO - MAGUI (PAYAN)'],
     ['NARINIO - MALLAMA (PIEDRANCHA)', '52435) NARINIO - MALLAMA (PIEDRANCHA)'],
     ['NARINIO - MOSQUERA', '52473) NARINIO - MOSQUERA'],
     ['NARINIO - OLAYA HERRERA (BOCAS DE SATINGA)', '52490) NARINIO - OLAYA HERRERA (BOCAS DE SATINGA)'],
     ['NARINIO - OSPINA', '52506) NARINIO - OSPINA'],
     ['NARINIO - FRANCISCO PIZARRO', '52520) NARINIO - FRANCISCO PIZARRO'],
     ['NARINIO - POLICARPA', '52540) NARINIO - POLICARPA'],
     ['NARINIO - POTOSI', '52560) NARINIO - POTOSI'],
     ['NARINIO - PROVIDENCIA', '52565) NARINIO - PROVIDENCIA'],
     ['NARINIO - PUERRES', '52573) NARINIO - PUERRES'],
     ['NARINIO - PUPIALES', '52585) NARINIO - PUPIALES'],
     ['NARINIO - RICAURTE', '52612) NARINIO - RICAURTE'],
     ['NARINIO - ROBERTO PAYAN (SAN JOSE)', '52621) NARINIO - ROBERTO PAYAN (SAN JOSE)'],
     ['NARINIO - SAMANIEGO', '52678) NARINIO - SAMANIEGO'],
     ['NARINIO - SANDONA', '52683) NARINIO - SANDONA'],
     ['NARINIO - SAN BERNARDO', '52685) NARINIO - SAN BERNARDO'],
     ['NARINIO - SAN LORENZO', '52687) NARINIO - SAN LORENZO'],
     ['NARINIO - SAN PABLO', '52693) NARINIO - SAN PABLO'],
     ['NARINIO - SAN PEDRO DE CARTAGO (CARTAGO)', '52694) NARINIO - SAN PEDRO DE CARTAGO (CARTAGO)'],
     ['NARINIO - SANTA BARBARA (ISCUANDE)', '52696) NARINIO - SANTA BARBARA (ISCUANDE)'],
     ['NARINIO - SANTA CRUZ (GUACHAVEZ)', '52699) NARINIO - SANTA CRUZ (GUACHAVEZ)'],
     ['NARINIO - SAPUYES', '52720) NARINIO - SAPUYES'],
     ['NARINIO - TAMINANGO', '52786) NARINIO - TAMINANGO'],
     ['NARINIO - TANGUA', '52788) NARINIO - TANGUA'],
     ['NARINIO - TUMACO', '52835) NARINIO - TUMACO'],
     ['NARINIO - TUQUERRES', '52838) NARINIO - TUQUERRES'],
     ['NARINIO - YACUANQUER', '52885) NARINIO - YACUANQUER'],
     ['NORTE DE SANTANDER - CUCUTA', '54001) NORTE DE SANTANDER - CUCUTA'],
     ['NORTE DE SANTANDER - ABREGO', '54003) NORTE DE SANTANDER - ABREGO'],
     ['NORTE DE SANTANDER - ARBOLEDAS', '54051) NORTE DE SANTANDER - ARBOLEDAS'],
     ['NORTE DE SANTANDER - BOCHALEMA', '54099) NORTE DE SANTANDER - BOCHALEMA'],
     ['NORTE DE SANTANDER - BUCARASICA', '54109) NORTE DE SANTANDER - BUCARASICA'],
     ['NORTE DE SANTANDER - CACOTA', '54125) NORTE DE SANTANDER - CACOTA'],
     ['NORTE DE SANTANDER - CACHIRA', '54128) NORTE DE SANTANDER - CACHIRA'],
     ['NORTE DE SANTANDER - CHINACOTA', '54172) NORTE DE SANTANDER - CHINACOTA'],
     ['NORTE DE SANTANDER - CHITAGA', '54174) NORTE DE SANTANDER - CHITAGA'],
     ['NORTE DE SANTANDER - CONVENCION', '54206) NORTE DE SANTANDER - CONVENCION'],
     ['NORTE DE SANTANDER - CUCUTILLA', '54223) NORTE DE SANTANDER - CUCUTILLA'],
     ['NORTE DE SANTANDER - DURANIA', '54239) NORTE DE SANTANDER - DURANIA'],
     ['NORTE DE SANTANDER - EL CARMEN', '54245) NORTE DE SANTANDER - EL CARMEN'],
     ['NORTE DE SANTANDER - EL TARRA', '54250) NORTE DE SANTANDER - EL TARRA'],
     ['NORTE DE SANTANDER - EL ZULIA', '54261) NORTE DE SANTANDER - EL ZULIA'],
     ['NORTE DE SANTANDER - GRAMALOTE', '54313) NORTE DE SANTANDER - GRAMALOTE'],
     ['NORTE DE SANTANDER - HACARI', '54344) NORTE DE SANTANDER - HACARI'],
     ['NORTE DE SANTANDER - HERRAN', '54347) NORTE DE SANTANDER - HERRAN'],
     ['NORTE DE SANTANDER - LABATECA', '54377) NORTE DE SANTANDER - LABATECA'],
     ['NORTE DE SANTANDER - LA ESPERANZA', '54385) NORTE DE SANTANDER - LA ESPERANZA'],
     ['NORTE DE SANTANDER - LA PLAYA', '54398) NORTE DE SANTANDER - LA PLAYA'],
     ['NORTE DE SANTANDER - LOS PATIOS', '54405) NORTE DE SANTANDER - LOS PATIOS'],
     ['NORTE DE SANTANDER - LOURDES', '54418) NORTE DE SANTANDER - LOURDES'],
     ['NORTE DE SANTANDER - MUTISCUA', '54480) NORTE DE SANTANDER - MUTISCUA'],
     ['NORTE DE SANTANDER - OCAÑA', '54498) NORTE DE SANTANDER - OCAÑA'],
     ['NORTE DE SANTANDER - PAMPLONA', '54518) NORTE DE SANTANDER - PAMPLONA'],
     ['NORTE DE SANTANDER - PAMPLONITA', '54520) NORTE DE SANTANDER - PAMPLONITA'],
     ['NORTE DE SANTANDER - PUERTO SANTANDER', '54553) NORTE DE SANTANDER - PUERTO SANTANDER'],
     ['NORTE DE SANTANDER - RAGONVALIA', '54599) NORTE DE SANTANDER - RAGONVALIA'],
     ['NORTE DE SANTANDER - SALAZAR', '54660) NORTE DE SANTANDER - SALAZAR'],
     ['NORTE DE SANTANDER - SAN CALIXTO', '54670) NORTE DE SANTANDER - SAN CALIXTO'],
     ['NORTE DE SANTANDER - SAN CAYETANO', '54673) NORTE DE SANTANDER - SAN CAYETANO'],
     ['NORTE DE SANTANDER - SANTIAGO', '54680) NORTE DE SANTANDER - SANTIAGO'],
     ['NORTE DE SANTANDER - SARDINATA', '54720) NORTE DE SANTANDER - SARDINATA'],
     ['NORTE DE SANTANDER - SILOS', '54743) NORTE DE SANTANDER - SILOS'],
     ['NORTE DE SANTANDER - TEORAMA', '54800) NORTE DE SANTANDER - TEORAMA'],
     ['NORTE DE SANTANDER - TIBU', '54810) NORTE DE SANTANDER - TIBU'],
     ['NORTE DE SANTANDER - TOLEDO', '54820) NORTE DE SANTANDER - TOLEDO'],
     ['NORTE DE SANTANDER - VILLACARO', '54871) NORTE DE SANTANDER - VILLACARO'],
     ['NORTE DE SANTANDER - VILLA DEL ROSARIO', '54874) NORTE DE SANTANDER - VILLA DEL ROSARIO'],
     ['QUINDIO - ARMENIA', '63001) QUINDIO - ARMENIA'],
     ['QUINDIO - BUENAVISTA', '63111) QUINDIO - BUENAVISTA'],
     ['QUINDIO - CALARCA', '63130) QUINDIO - CALARCA'],
     ['QUINDIO - CIRCASIA', '63190) QUINDIO - CIRCASIA'],
     ['QUINDIO - CORDOBA', '63212) QUINDIO - CORDOBA'],
     ['QUINDIO - FILANDIA', '63272) QUINDIO - FILANDIA'],
     ['QUINDIO - GENOVA', '63302) QUINDIO - GENOVA'],
     ['QUINDIO - LA TEBAIDA', '63401) QUINDIO - LA TEBAIDA'],
     ['QUINDIO - MONTENEGRO', '63470) QUINDIO - MONTENEGRO'],
     ['QUINDIO - PIJAO', '63548) QUINDIO - PIJAO'],
     ['QUINDIO - QUIMBAYA', '63594) QUINDIO - QUIMBAYA'],
     ['QUINDIO - SALENTO', '63690) QUINDIO - SALENTO'],
     ['BOGOTA D.C - ADUANAS ESPECIALES', '65534) BOGOTA D.C - ADUANAS ESPECIALES'],
     ['BOGOTA D.C - AEROPUERTO EL DORADO', '65535) BOGOTA D.C - AEROPUERTO EL DORADO'],
     ['RISARALDA - PEREIRA', '66001) RISARALDA - PEREIRA'],
     ['RISARALDA - APIA', '66045) RISARALDA - APIA'],
     ['RISARALDA - BALBOA', '66075) RISARALDA - BALBOA'],
     ['RISARALDA - BELEN DE UMBRIA', '66088) RISARALDA - BELEN DE UMBRIA'],
     ['RISARALDA - DOS QUEBRADAS', '66170) RISARALDA - DOS QUEBRADAS'],
     ['RISARALDA - GUATICA', '66318) RISARALDA - GUATICA'],
     ['RISARALDA - LA CELIA', '66383) RISARALDA - LA CELIA'],
     ['RISARALDA - LA VIRGINIA', '66400) RISARALDA - LA VIRGINIA'],
     ['RISARALDA - MARSELLA', '66440) RISARALDA - MARSELLA'],
     ['RISARALDA - MISTRATO', '66456) RISARALDA - MISTRATO'],
     ['RISARALDA - PUEBLO RICO', '66572) RISARALDA - PUEBLO RICO'],
     ['RISARALDA - QUINCHIA', '66594) RISARALDA - QUINCHIA'],
     ['RISARALDA - SANTA ROSA DE CABAL', '66682) RISARALDA - SANTA ROSA DE CABAL'],
     ['RISARALDA - SANTUARIO', '66687) RISARALDA - SANTUARIO'],
     ['SANTANDER - BUCARAMANGA', '68001) SANTANDER - BUCARAMANGA'],
     ['SANTANDER - AGUADA', '68013) SANTANDER - AGUADA'],
     ['SANTANDER - ALBANIA', '68020) SANTANDER - ALBANIA'],
     ['SANTANDER - ARATOCA', '68051) SANTANDER - ARATOCA'],
     ['SANTANDER - BARBOSA', '68077) SANTANDER - BARBOSA'],
     ['SANTANDER - BARICHARA', '68079) SANTANDER - BARICHARA'],
     ['SANTANDER - BARRANCABERMEJA', '68081) SANTANDER - BARRANCABERMEJA'],
     ['SANTANDER - BETULIA', '68092) SANTANDER - BETULIA'],
     ['SANTANDER - BOLIVAR', '68101) SANTANDER - BOLIVAR'],
     ['SANTANDER - CABRERA', '68121) SANTANDER - CABRERA'],
     ['SANTANDER - CALIFORNIA', '68132) SANTANDER - CALIFORNIA'],
     ['SANTANDER - CAPITANEJO', '68147) SANTANDER - CAPITANEJO'],
     ['SANTANDER - CARCASI', '68152) SANTANDER - CARCASI'],
     ['SANTANDER - CEPITA', '68160) SANTANDER - CEPITA'],
     ['SANTANDER - CERRITO', '68162) SANTANDER - CERRITO'],
     ['SANTANDER - CHARALA', '68167) SANTANDER - CHARALA'],
     ['SANTANDER - CHARTA', '68169) SANTANDER - CHARTA'],
     ['SANTANDER - CHIMA', '68176) SANTANDER - CHIMA'],
     ['SANTANDER - CHIPATA', '68179) SANTANDER - CHIPATA'],
     ['SANTANDER - CIMITARRA', '68190) SANTANDER - CIMITARRA'],
     ['SANTANDER - CONCEPCION', '68207) SANTANDER - CONCEPCION'],
     ['SANTANDER - CONFINES', '68209) SANTANDER - CONFINES'],
     ['SANTANDER - CONTRATACION', '68211) SANTANDER - CONTRATACION'],
     ['SANTANDER - COROMORO', '68217) SANTANDER - COROMORO'],
     ['SANTANDER - CURITI', '68229) SANTANDER - CURITI'],
     ['SANTANDER - EL CARMEN DE CHUCURI', '68235) SANTANDER - EL CARMEN DE CHUCURI'],
     ['SANTANDER - EL GUACAMAYO', '68245) SANTANDER - EL GUACAMAYO'],
     ['SANTANDER - EL PEÑON', '68250) SANTANDER - EL PEÑON'],
     ['SANTANDER - EL PLAYON', '68255) SANTANDER - EL PLAYON'],
     ['SANTANDER - ENCINO', '68264) SANTANDER - ENCINO'],
     ['SANTANDER - ENCISO', '68266) SANTANDER - ENCISO'],
     ['SANTANDER - FLORIAN', '68271) SANTANDER - FLORIAN'],
     ['SANTANDER - FLORIDABLANCA', '68276) SANTANDER - FLORIDABLANCA'],
     ['SANTANDER - GALAN', '68296) SANTANDER - GALAN'],
     ['SANTANDER - GAMBITA', '68298) SANTANDER - GAMBITA'],
     ['SANTANDER - GIRON', '68307) SANTANDER - GIRON'],
     ['SANTANDER - GUACA', '68318) SANTANDER - GUACA'],
     ['SANTANDER - GUADALUPE', '68320) SANTANDER - GUADALUPE'],
     ['SANTANDER - GUAPOTA', '68322) SANTANDER - GUAPOTA'],
     ['SANTANDER - GUAVATA', '68324) SANTANDER - GUAVATA'],
     ['SANTANDER - GUEPSA', '68327) SANTANDER - GUEPSA'],
     ['SANTANDER - HATO', '68344) SANTANDER - HATO'],
     ['SANTANDER - JESUS MARIA', '68368) SANTANDER - JESUS MARIA'],
     ['SANTANDER - JORDAN', '68370) SANTANDER - JORDAN'],
     ['SANTANDER - LA BELLEZA', '68377) SANTANDER - LA BELLEZA'],
     ['SANTANDER - LANDAZURI', '68385) SANTANDER - LANDAZURI'],
     ['SANTANDER - LA PAZ', '68397) SANTANDER - LA PAZ'],
     ['SANTANDER - LEBRIJA', '68406) SANTANDER - LEBRIJA'],
     ['SANTANDER - LOS SANTOS', '68418) SANTANDER - LOS SANTOS'],
     ['SANTANDER - MARACAVITA', '68425) SANTANDER - MARACAVITA'],
     ['SANTANDER - MALAGA', '68432) SANTANDER - MALAGA'],
     ['SANTANDER - MATANZA', '68444) SANTANDER - MATANZA'],
     ['SANTANDER - MOGOTES', '68464) SANTANDER - MOGOTES'],
     ['SANTANDER - MOLAGAVITA', '68468) SANTANDER - MOLAGAVITA'],
     ['SANTANDER - OCAMONTE', '68498) SANTANDER - OCAMONTE'],
     ['SANTANDER - OIBA', '68500) SANTANDER - OIBA'],
     ['SANTANDER - ONZAGA', '68502) SANTANDER - ONZAGA'],
     ['SANTANDER - PALMAR', '68522) SANTANDER - PALMAR'],
     ['SANTANDER - PALMAS DEL SOCORRO', '68524) SANTANDER - PALMAS DEL SOCORRO'],
     ['SANTANDER - PARAMO', '68533) SANTANDER - PARAMO'],
     ['SANTANDER - PIEDECUESTA', '68547) SANTANDER - PIEDECUESTA'],
     ['SANTANDER - PINCHOTE', '68549) SANTANDER - PINCHOTE'],
     ['SANTANDER - PUENTE NACIONAL', '68572) SANTANDER - PUENTE NACIONAL'],
     ['SANTANDER - PUERTO PARRA', '68573) SANTANDER - PUERTO PARRA'],
     ['SANTANDER - PUERTO WILCHES', '68575) SANTANDER - PUERTO WILCHES'],
     ['SANTANDER - RIONEGRO', '68615) SANTANDER - RIONEGRO'],
     ['SANTANDER - SABANA DE TORRES', '68655) SANTANDER - SABANA DE TORRES'],
     ['SANTANDER - SAN ANDRES', '68669) SANTANDER - SAN ANDRES'],
     ['SANTANDER - SAN BENITO', '68673) SANTANDER - SAN BENITO'],
     ['SANTANDER - SAN GIL', '68679) SANTANDER - SAN GIL'],
     ['SANTANDER - SAN JOAQUIN', '68682) SANTANDER - SAN JOAQUIN'],
     ['SANTANDER - SAN JOSE DE MIRANDA', '68684) SANTANDER - SAN JOSE DE MIRANDA'],
     ['SANTANDER - SAN MIGUEL', '68686) SANTANDER - SAN MIGUEL'],
     ['SANTANDER - SAN VICENTE DEL CHUCURI', '68689) SANTANDER - SAN VICENTE DEL CHUCURI'],
     ['SANTANDER - SANTA BARBARA', '68705) SANTANDER - SANTA BARBARA'],
     ['SANTANDER - SANTA HELENA DEL OPON', '68720) SANTANDER - SANTA HELENA DEL OPON'],
     ['SANTANDER - SIMACOTA', '68745) SANTANDER - SIMACOTA'],
     ['SANTANDER - SOCORRO', '68755) SANTANDER - SOCORRO'],
     ['SANTANDER - SUAITA', '68770) SANTANDER - SUAITA'],
     ['SANTANDER - SUCRE', '68773) SANTANDER - SUCRE'],
     ['SANTANDER - SURATA', '68780) SANTANDER - SURATA'],
     ['SANTANDER - TONA', '68820) SANTANDER - TONA'],
     ['SANTANDER - VALLE DE SAN JOSE', '68855) SANTANDER - VALLE DE SAN JOSE'],
     ['SANTANDER - VELEZ', '68861) SANTANDER - VELEZ'],
     ['SANTANDER - VETAS', '68867) SANTANDER - VETAS'],
     ['SANTANDER - VILLANUEVA', '68872) SANTANDER - VILLANUEVA'],
     ['SANTANDER - ZAPATOCA', '68895) SANTANDER - ZAPATOCA'],
     ['SUCRE - SINCELEJO', '70001) SUCRE - SINCELEJO'],
     ['SUCRE - BUENAVISTA', '70110) SUCRE - BUENAVISTA'],
     ['SUCRE - CAIMITO', '70124) SUCRE - CAIMITO'],
     ['SUCRE - COLOSO', '70204) SUCRE - COLOSO'],
     ['SUCRE - COROZAL', '70215) SUCRE - COROZAL'],
     ['SUCRE - COVEAS (SUCRE)', '70221) SUCRE - COVEAS (SUCRE)'],
     ['SUCRE - CHALAN', '70230) SUCRE - CHALAN'],
     ['SUCRE - GALERAS', '70235) SUCRE - GALERAS'],
     ['SUCRE - GUARANDA', '70265) SUCRE - GUARANDA'],
     ['SUCRE - LA UNION', '70400) SUCRE - LA UNION'],
     ['SUCRE - LOS PALMITOS', '70418) SUCRE - LOS PALMITOS'],
     ['SUCRE - MAJAGUAL', '70429) SUCRE - MAJAGUAL'],
     ['SUCRE - MORROA', '70473) SUCRE - MORROA'],
     ['SUCRE - OVEJAS', '70508) SUCRE - OVEJAS'],
     ['SUCRE - PALMITO', '70523) SUCRE - PALMITO'],
     ['SUCRE - SAMPUES', '70670) SUCRE - SAMPUES'],
     ['SUCRE - SAN BENITO ABAD', '70678) SUCRE - SAN BENITO ABAD'],
     ['SUCRE - SAN JUAN DE BETULIA', '70702) SUCRE - SAN JUAN DE BETULIA'],
     ['SUCRE - SAN MARCOS', '70708) SUCRE - SAN MARCOS'],
     ['SUCRE - SAN ONOFRE', '70713) SUCRE - SAN ONOFRE'],
     ['SUCRE - SAN PEDRO', '70717) SUCRE - SAN PEDRO'],
     ['SUCRE - SINCE', '70742) SUCRE - SINCE'],
     ['SUCRE - SUCRE', '70771) SUCRE - SUCRE'],
     ['SUCRE - SANTIAGO DE TOLU', '70820) SUCRE - SANTIAGO DE TOLU'],
     ['SUCRE - TOLUVIEJO', '70823) SUCRE - TOLUVIEJO'],
     ['TOLIMA - IBAGUE', '73001) TOLIMA - IBAGUE'],
     ['TOLIMA - ALPUJARRA', '73024) TOLIMA - ALPUJARRA'],
     ['TOLIMA - ALVARADO', '73026) TOLIMA - ALVARADO'],
     ['TOLIMA - AMBALEMA', '73030) TOLIMA - AMBALEMA'],
     ['TOLIMA - ANZOATEGUI', '73043) TOLIMA - ANZOATEGUI'],
     ['TOLIMA - ARMERO (GUAYABAL)', '73055) TOLIMA - ARMERO (GUAYABAL)'],
     ['TOLIMA - ATACO', '73067) TOLIMA - ATACO'],
     ['TOLIMA - CAJAMARCA', '73124) TOLIMA - CAJAMARCA'],
     ['TOLIMA - CARMEN DE APICALA', '73148) TOLIMA - CARMEN DE APICALA'],
     ['TOLIMA - CASABIANCA', '73152) TOLIMA - CASABIANCA'],
     ['TOLIMA - CHAPARRAL', '73168) TOLIMA - CHAPARRAL'],
     ['TOLIMA - COELLO', '73200) TOLIMA - COELLO'],
     ['TOLIMA - COYAIMA', '73217) TOLIMA - COYAIMA'],
     ['TOLIMA - CUNDAY', '73226) TOLIMA - CUNDAY'],
     ['TOLIMA - DOLORES', '73236) TOLIMA - DOLORES'],
     ['TOLIMA - ESPINAL (CHICORAL) ', '73268) TOLIMA - ESPINAL (CHICORAL) '],
     ['TOLIMA - FALAN', '73270) TOLIMA - FALAN'],
     ['TOLIMA - FLANDES', '73275) TOLIMA - FLANDES'],
     ['TOLIMA - FRESNO', '73283) TOLIMA - FRESNO'],
     ['TOLIMA - GUAMO', '73319) TOLIMA - GUAMO'],
     ['TOLIMA - HERVEO', '73347) TOLIMA - HERVEO'],
     ['TOLIMA - HONDA', '73349) TOLIMA - HONDA'],
     ['TOLIMA - ICONONZO', '73352) TOLIMA - ICONONZO'],
     ['TOLIMA - LERIDA', '73408) TOLIMA - LERIDA'],
     ['TOLIMA - LIBANO', '73411) TOLIMA - LIBANO'],
     ['TOLIMA - MARIQUITA', '73443) TOLIMA - MARIQUITA'],
     ['TOLIMA - MELGAR', '73449) TOLIMA - MELGAR'],
     ['TOLIMA - MURILLO', '73461) TOLIMA - MURILLO'],
     ['TOLIMA - NATAGAIMA', '73483) TOLIMA - NATAGAIMA'],
     ['TOLIMA - ORTEGA', '73504) TOLIMA - ORTEGA'],
     ['TOLIMA - PALOCABILDO', '73520) TOLIMA - PALOCABILDO'],
     ['TOLIMA - PIEDRAS', '73547) TOLIMA - PIEDRAS'],
     ['TOLIMA - PLANADAS', '73555) TOLIMA - PLANADAS'],
     ['TOLIMA - PRADO', '73563) TOLIMA - PRADO'],
     ['TOLIMA - PURIFICACION', '73585) TOLIMA - PURIFICACION'],
     ['TOLIMA - RIOBLANCO', '73616) TOLIMA - RIOBLANCO'],
     ['TOLIMA - RONCESVALLES', '73622) TOLIMA - RONCESVALLES'],
     ['TOLIMA - ROVIRA', '73624) TOLIMA - ROVIRA'],
     ['TOLIMA - SALDAYA', '73671) TOLIMA - SALDAYA'],
     ['TOLIMA - SAN ANTONIO', '73675) TOLIMA - SAN ANTONIO'],
     ['TOLIMA - SAN LUIS', '73678) TOLIMA - SAN LUIS'],
     ['TOLIMA - SANTA ISABEL', '73686) TOLIMA - SANTA ISABEL'],
     ['TOLIMA - SUAREZ', '73770) TOLIMA - SUAREZ'],
     ['TOLIMA - VALLE DE SAN JUAN', '73854) TOLIMA - VALLE DE SAN JUAN'],
     ['TOLIMA - VENADILLO', '73861) TOLIMA - VENADILLO'],
     ['TOLIMA - VILLAHERMOSA', '73870) TOLIMA - VILLAHERMOSA'],
     ['TOLIMA - VILLARRICA', '73873) TOLIMA - VILLARRICA'],
     ['VALLE DEL CAUCA - CALI', '76001) VALLE DEL CAUCA - CALI'],
     ['VALLE DEL CAUCA - ALCALA', '76020) VALLE DEL CAUCA - ALCALA'],
     ['VALLE DEL CAUCA - ANDALUCIA', '76036) VALLE DEL CAUCA - ANDALUCIA'],
     ['VALLE DEL CAUCA - ANSERMANUEVO', '76041) VALLE DEL CAUCA - ANSERMANUEVO'],
     ['VALLE DEL CAUCA - ARGELIA', '76054) VALLE DEL CAUCA - ARGELIA'],
     ['VALLE DEL CAUCA - BOLIVAR', '76100) VALLE DEL CAUCA - BOLIVAR'],
     ['VALLE DEL CAUCA - BUENAVENTURA', '76109) VALLE DEL CAUCA - BUENAVENTURA'],
     ['VALLE DEL CAUCA - GUADALAJARA DE BUGA ', '76111) VALLE DEL CAUCA - GUADALAJARA DE BUGA '],
     ['VALLE DEL CAUCA - BUGALAGRANDE', '76113) VALLE DEL CAUCA - BUGALAGRANDE'],
     ['VALLE DEL CAUCA - CAICEDONIA', '76122) VALLE DEL CAUCA - CAICEDONIA'],
     ['VALLE DEL CAUCA - CALIMA (EL DARIEN)', '76126) VALLE DEL CAUCA - CALIMA (EL DARIEN)'],
     ['VALLE DEL CAUCA - CANDELARIA', '76130) VALLE DEL CAUCA - CANDELARIA'],
     ['VALLE DEL CAUCA - CARTAGO', '76147) VALLE DEL CAUCA - CARTAGO'],
     ['VALLE DEL CAUCA - DAGUA', '76233) VALLE DEL CAUCA - DAGUA'],
     ['VALLE DEL CAUCA - EL AGUILA', '76243) VALLE DEL CAUCA - EL AGUILA'],
     ['VALLE DEL CAUCA - EL CAIRO', '76246) VALLE DEL CAUCA - EL CAIRO'],
     ['VALLE DEL CAUCA - EL CERRITO', '76248) VALLE DEL CAUCA - EL CERRITO'],
     ['VALLE DEL CAUCA - EL DOVIO', '76250) VALLE DEL CAUCA - EL DOVIO'],
     ['VALLE DEL CAUCA - FLORIDA', '76275) VALLE DEL CAUCA - FLORIDA'],
     ['VALLE DEL CAUCA - GINEBRA', '76306) VALLE DEL CAUCA - GINEBRA'],
     ['VALLE DEL CAUCA - GUACARI', '76318) VALLE DEL CAUCA - GUACARI'],
     ['VALLE DEL CAUCA - JAMUNDI', '76364) VALLE DEL CAUCA - JAMUNDI'],
     ['VALLE DEL CAUCA - LA CUMBRE', '76377) VALLE DEL CAUCA - LA CUMBRE'],
     ['VALLE DEL CAUCA - LA UNION', '76400) VALLE DEL CAUCA - LA UNION'],
     ['VALLE DEL CAUCA - LA VICTORIA', '76403) VALLE DEL CAUCA - LA VICTORIA'],
     ['VALLE DEL CAUCA - OBANDO', '76497) VALLE DEL CAUCA - OBANDO'],
     ['VALLE DEL CAUCA - PALMIRA', '76520) VALLE DEL CAUCA - PALMIRA'],
     ['VALLE DEL CAUCA - PRADERA', '76563) VALLE DEL CAUCA - PRADERA'],
     ['VALLE DEL CAUCA - RESTREPO', '76606) VALLE DEL CAUCA - RESTREPO'],
     ['VALLE DEL CAUCA - RIOFRIO', '76616) VALLE DEL CAUCA - RIOFRIO'],
     ['VALLE DEL CAUCA - ROLDANILLO', '76622) VALLE DEL CAUCA - ROLDANILLO'],
     ['VALLE DEL CAUCA - SAN PEDRO', '76670) VALLE DEL CAUCA - SAN PEDRO'],
     ['VALLE DEL CAUCA - SEVILLA', '76736) VALLE DEL CAUCA - SEVILLA'],
     ['VALLE DEL CAUCA - TORO', '76823) VALLE DEL CAUCA - TORO'],
     ['VALLE DEL CAUCA - TRUJILLO', '76828) VALLE DEL CAUCA - TRUJILLO'],
     ['VALLE DEL CAUCA - TULUA', '76834) VALLE DEL CAUCA - TULUA'],
     ['VALLE DEL CAUCA - ULLOA', '76845) VALLE DEL CAUCA - ULLOA'],
     ['VALLE DEL CAUCA - VERSALLES', '76863) VALLE DEL CAUCA - VERSALLES'],
     ['VALLE DEL CAUCA - VIJES', '76869) VALLE DEL CAUCA - VIJES'],
     ['VALLE DEL CAUCA - YOTOCO', '76890) VALLE DEL CAUCA - YOTOCO'],
     ['VALLE DEL CAUCA - YUMBO', '76892) VALLE DEL CAUCA - YUMBO'],
     ['VALLE DEL CAUCA - ZARZAL', '76895) VALLE DEL CAUCA - ZARZAL'],
     ['ARAUCA - ARAUCA', '81001) ARAUCA - ARAUCA'],
     ['ARAUCA - ARAUQUITA', '81065) ARAUCA - ARAUQUITA'],
     ['ARAUCA - CRAVO NORTE', '81220) ARAUCA - CRAVO NORTE'],
     ['ARAUCA - FORTUL', '81300) ARAUCA - FORTUL'],
     ['ARAUCA - PUERTO RONDON', '81591) ARAUCA - PUERTO RONDON'],
     ['ARAUCA - SARAVENA', '81736) ARAUCA - SARAVENA'],
     ['ARAUCA - TAME', '81794) ARAUCA - TAME'],
     ['CASANARE - YOPAL', '85001) CASANARE - YOPAL'],
     ['CASANARE - AGUAZUL', '85010) CASANARE - AGUAZUL'],
     ['CASANARE - CHAMEZA', '85015) CASANARE - CHAMEZA'],
     ['CASANARE - HATO COROZAL', '85125) CASANARE - HATO COROZAL'],
     ['CASANARE - LA SALINA', '85136) CASANARE - LA SALINA'],
     ['CASANARE - MANI', '85139) CASANARE - MANI'],
     ['CASANARE - MONTERREY', '85162) CASANARE - MONTERREY'],
     ['CASANARE - NUNCHIA', '85225) CASANARE - NUNCHIA'],
     ['CASANARE - OROCUE', '85230) CASANARE - OROCUE'],
     ['CASANARE - PAZ DE ARIPORO', '85250) CASANARE - PAZ DE ARIPORO'],
     ['CASANARE - PORE', '85263) CASANARE - PORE'],
     ['CASANARE - RECETOR', '85279) CASANARE - RECETOR'],
     ['CASANARE - SABANALARGA', '85300) CASANARE - SABANALARGA'],
     ['CASANARE - SACAMA', '85315) CASANARE - SACAMA'],
     ['CASANARE - SAN LUIS DE PALENQUE', '85325) CASANARE - SAN LUIS DE PALENQUE'],
     ['CASANARE - TAMARA', '85400) CASANARE - TAMARA'],
     ['CASANARE - TAURAMENA', '85410) CASANARE - TAURAMENA'],
     ['CASANARE - TRINIDAD', '85430) CASANARE - TRINIDAD'],
     ['CASANARE - VILLANUEVA', '85440) CASANARE - VILLANUEVA'],
     ['PUTUMAYO - MOCOA', '86001) PUTUMAYO - MOCOA'],
     ['PUTUMAYO - COLON', '86219) PUTUMAYO - COLON'],
     ['PUTUMAYO - ORITO', '86320) PUTUMAYO - ORITO'],
     ['PUTUMAYO - PUERTO ASIS', '86568) PUTUMAYO - PUERTO ASIS'],
     ['PUTUMAYO - PUERTO CAICEDO', '86569) PUTUMAYO - PUERTO CAICEDO'],
     ['PUTUMAYO - PUERTO GUZMAN', '86571) PUTUMAYO - PUERTO GUZMAN'],
     ['PUTUMAYO - PUERTO LEGUIZAMO', '86573) PUTUMAYO - PUERTO LEGUIZAMO'],
     ['PUTUMAYO - SIBUNDOY', '86749) PUTUMAYO - SIBUNDOY'],
     ['PUTUMAYO - SAN FRANCISCO', '86755) PUTUMAYO - SAN FRANCISCO'],
     ['PUTUMAYO - SAN MIGUEL (LA DORADA)', '86757) PUTUMAYO - SAN MIGUEL (LA DORADA)'],
     ['PUTUMAYO - SANTIAGO', '86760) PUTUMAYO - SANTIAGO'],
     ['PUTUMAYO - VALLE DEL GUAMUEZ (LA HORMIGA)', '86865) PUTUMAYO - VALLE DEL GUAMUEZ (LA HORMIGA)'],
     ['PUTUMAYO - VILLAGARZON', '86885) PUTUMAYO - VILLAGARZON'],
     ['SAN ANDRES Y PROVIDENCIA - SAN ANDRES', '88001) SAN ANDRES Y PROVIDENCIA - SAN ANDRES'],
     ['SAN ANDRES Y PROVIDENCIA - PROVIDENCIA Y SANTA CATALINA', '88564) SAN ANDRES Y PROVIDENCIA - PROVIDENCIA Y SANTA CATALINA'],
     ['AMAZONAS - LETICIA', '91001) AMAZONAS - LETICIA'],
     ['AMAZONAS - EL ENCANTO', '91263) AMAZONAS - EL ENCANTO'],
     ['AMAZONAS - LA CHORRERA', '91405) AMAZONAS - LA CHORRERA'],
     ['AMAZONAS - LA PEDRERA', '91407) AMAZONAS - LA PEDRERA'],
     ['AMAZONAS - LA VICTORIA (AMAZONAS)', '91430) AMAZONAS - LA VICTORIA (AMAZONAS)'],
     ['AMAZONAS - MARITI PARANA', '91460) AMAZONAS - MARITI PARANA'],
     ['AMAZONAS - PUERTO NARIÑO', '91540) AMAZONAS - PUERTO NARIÑO'],
     ['AMAZONAS - PTO SANTANDER', '91669) AMAZONAS - PTO SANTANDER'],
     ['AMAZONAS - TARAPACA', '91798) AMAZONAS - TARAPACA'],
     ['GUAINIA - INIRIDA', '94001) GUAINIA - INIRIDA'],
     ['GUAINIA - BARRANCO MINA (CD)', '94343) GUAINIA - BARRANCO MINA (CD)'],
     ['GUAINIA - SAN FELIPE (CD)', '94883) GUAINIA - SAN FELIPE (CD)'],
     ['GUAINIA - PUERTO COLOMBIA (CD)', '94884) GUAINIA - PUERTO COLOMBIA (CD)'],
     ['GUAINIA - LA GUADALUPE (CD)', '94885) GUAINIA - LA GUADALUPE (CD)'],
     ['GUAINIA - CACAHUAL (CD)', '94886) GUAINIA - CACAHUAL (CD)'],
     ['GUAINIA - PANA-PANA (CD)', '94887) GUAINIA - PANA-PANA (CD)'],
     ['GUAINIA - MORICHAL NUEVO (CD)', '94888) GUAINIA - MORICHAL NUEVO (CD)'],
     ['GUAVIARE - SAN JOSE DEL GUAVIARE', '95001) GUAVIARE - SAN JOSE DEL GUAVIARE'],
     ['GUAVIARE - CALAMAR', '95015) GUAVIARE - CALAMAR'],
     ['GUAVIARE - EL RETORNO', '95025) GUAVIARE - EL RETORNO'],
     ['GUAVIARE - MIRAFLORES', '95200) GUAVIARE - MIRAFLORES'],
     ['VAUPES - MITU', '97001) VAUPES - MITU'],
     ['VAUPES - CARURU', '97161) VAUPES - CARURU'],
     ['VAUPES - PACOA (CD)', '97511) VAUPES - PACOA (CD)'],
     ['VAUPES - VILLA FATIMA', '97555) VAUPES - VILLA FATIMA'],
     ['VAUPES - TARAIRA', '97666) VAUPES - TARAIRA'],
     ['VAUPES - PAPUNAUA (CD)', '97777) VAUPES - PAPUNAUA (CD)'],
     ['VAUPES - ACARICUARA', '97888) VAUPES - ACARICUARA'],
     ['VAUPES - YAVARATE (CD)', '97889) VAUPES - YAVARATE (CD)'],
     ['VICHADA - PUERTO CARREÑO', '99001) VICHADA - PUERTO CARREÑO'],
     ['VICHADA - LA PRIMAVERA', '99524) VICHADA - LA PRIMAVERA'],
     ['VICHADA - SANTA RITA', '99572) VICHADA - SANTA RITA'],
     ['VICHADA - SANTA ROSALIA', '99624) VICHADA - SANTA ROSALIA'],
     ['VICHADA - SAN JOSE DE OCUNE', '99760) VICHADA - SAN JOSE DE OCUNE'],
     ['VICHADA - CUMARIBO', '99773) VICHADA - CUMARIBO']]
  end

  def select_ocupacion
    [['EMPLEADO', '1) EMPLEADO'], ['ESTUDIANTE. BÁSICA / MEDIA', '2) ESTUDIANTE. BÁSICA / MEDIA'],
     ['ESTUDIANTE SUPERIOR', '3) ESTUDIANTE SUPERIOR'], ['DESEMPLEADO', '4) DESEMPLEADO'],
     ['INDEPENDIENTE', '5) INDEPENDIENTE']]
  end

  def select_discapacidad
    [['SORDERA PROFUNDA', '1) SORDERA PROFUNDA'],
     ['HIPOACUSIA A BAJA AUDICIÓN', '2) HIPOACUSIA A BAJA AUDICIÓN'], ['BAJA VISIÓN DIAGNOSTICA', '3) BAJA VISIÓN DIAGNOSTICA'],
     ['CEGUERA', '4) CEGUERA'], ['PARÁLISIS CEREBRAL', '5) PARÁLISIS CEREBRAL'],
     ['LESIÓN NEUROMUSCULAR', '6) LESIÓN NEUROMUSCULAR'], ['DEFICIENCIA COGNITIVA', '7) DEFICIENCIA COGNITIVA(RETARDO EN EL DESARROLLO)'],
     ['NO APLICA', '9) NO APLICA'],
     ["OTRA", "OTRA"]
    ]
  end

  def select_regimen
    [['SISBEN V2 - Nivel 1', '1) SISBEN V2 - Nivel 1'],
     ['SISBEN V2 - Nivel 2', '2) SISBEN V2 - Nivel 2'],
     ['SISBEN V2 - Nivel 3', '3) SISBEN V2 - Nivel 3'],
     ['SISBEN V3 - Rango de 0% a 9%', '4) SISBEN V3 - Rango de 0% a 9%'],
     ['SISBEN V3 - Rango de 10% a 19%', '5) SISBEN V3 - Rango de 10% a 19%'],
     ['SISBEN V3 - Rango de 20% a 29%', '6) SISBEN V3 - Rango de 20% a 29%'],
     ['SISBEN V3 - Rango de 30% a 39%', '7) SISBEN V3 - Rango de 30% a 39%'],
     ['SISBEN V3 - Rango de 40% a 49%', '8) SISBEN V3 - Rango de 40% a 49%'],
     ['SISBEN V3 - Rango de 50% a 59%', '9) SISBEN V3 - Rango de 50% a 59%'],
     ['SISBEN V3 - Rango de 60% a 69%', '10) SISBEN V3 - Rango de 60% a 69%'],
     ['SISBEN V3 - Rango de 70% a 79%', '11) SISBEN V3 - Rango de 70% a 79%'],
     ['SISBEN V3 - Rango de 80% a 89%', '12) SISBEN V3 - Rango de 80% a 89%'],
     ['SISBEN V3 - Rango de 90% a 100%', '13) SISBEN V3 - Rango de 90% a 100%'],
     ['ALIANSALUD EPS S.A.', '14) ALIANSALUD EPS S.A.'],
     ['Cafesalud  EPS', '15) Cafesalud  EPS'],
     ['Comfenalco valle E.P.S.', '16) Comfenalco valle E.P.S.'],
     ['Compensar EPS', '17) Compensar EPS'],
     ['Coomeva EPS', '18) Coomeva EPS'],
     ['Cruz Blanca  EPS', '19) Cruz Blanca  EPS'],
     ['E.P.S. Programa Comfenalco Antioquia', '20) E.P.S. Programa Comfenalco Antioquia'],
     ['EPS Sura', '21) EPS Sura'],
     ['Empresas Publicas de Medellin departamento Medico', '22) Empresas Publicas de Medellin departamento Medico'],
     ['Famisanar EPS Cafam  Colsubsidio', '23) Famisanar EPS Cafam  Colsubsidio'],
     ['Fondo de Pasivo Social de Ferrocarriles Nacionales de Colombia', '24) Fondo de Pasivo Social de Ferrocarriles Nacionales de Colombia'],
     ['Fondo de Solidaridad Y Garantia  Ministerio de Salud', '25) Fondo de Solidaridad Y Garantia  Ministerio de Salud'],
     ['GOLDEN CROSS S.A. EPS', '26) GOLDEN CROSS S.A. EPS'],
     ['Humana vivir S.A. EPS ARS', '27) Humana vivir S.A. EPS ARS'],
     ['ISS EPS', '28) ISS EPS'],
     ['MULTIMEDICAS SALUD CON CALIDAD EPS S.A', '29) MULTIMEDICAS SALUD CON CALIDAD EPS S.A'],
     ['Nueva Promotora de Salud - Nueva EPS', '30) Nueva Promotora de Salud - Nueva EPS'],
     ['Programa Servicios Medicos Colpatria S.A.  EPS', '31) Programa Servicios Medicos Colpatria S.A.  EPS'],
     ['Salud Total EPS', '32) Salud Total EPS'],
     ['Salud Vida EPS', '33) Salud Vida EPS'],
     ['Saludcolombia  EPS', '34) Saludcolombia  EPS'],
     ['Saludcoop EPS  Organismo Cooperativo', '35) Saludcoop EPS  Organismo Cooperativo'],
     ['Sanitas EPS', '36) Sanitas EPS'],
     ['Servicio Occidental de Salud S.A. S.O.S  EPS', '37) Servicio Occidental de Salud S.A. S.O.S  EPS'],
     ['Solsalud E.P.S. S.A.', '38) Solsalud E.P.S. S.A.'],
     ['Colsanitas', '39) Colsanitas'],
     ['Policía Nacional', '40) Policía Nacional'],
     ['Colmedica', '41) Colmedica'],
     ['Ecopetrol', '42) Ecopetrol'],
     ['Susalud', '43) Susalud'],
     ['Medplus', '44) Medplus'],
     ['SIN INFORMACION', '99) SIN INFORMACION'],
     ["OTRA", "OTRA"]]
  end

  def select_forma_pago
    [
      %w[EFECTIVO EFECTIVO],
      %w[CONSIGNACION CONSIGNACION],
      %w[TRANSFERENCIA TRANSFERENCIA],
      %w[CHEQUE CHEQUE]
    ]
  end
  def select_forma_pago2
    [
      %w[EFECTIVO EFECTIVO],
      %w[CONSIGNACION CONSIGNACION],
      %w[TRANSFERENCIA TRANSFERENCIA],
      %w[CHEQUE CHEQUE],
      %w[FLAMINGO FLAMINGO]

    ]
  end

  def selecthora
    [
      ['06:00 a.m.', 1],
      ['07:00 a.m.', 2],
      ['08:00 a.m.', 3],
      ['09:00 a.m.', 4],
      ['10:00 a.m.', 5],
      ['11:00 a.m.', 6],
      ['12:00 p.m.', 7],
      ['01:00 p.m.', 8],
      ['02:00 p.m.', 9],
      ['03:00 p.m.', 10],
      ['04:00 p.m.', 11],
      ['05:00 p.m.', 12],
      ['06:00 p.m.', 13],
      ['07:00 p.m.', 14],
      ['08:00 p.m.', 15],
      ['09:00 p.m.', 16]
    ]
  end

  def select_estado_veh
    [
      %w[ACTIVO A],
      %w[INACTIVO I]
    ]
  end

  def select_oficina
    [
      %w[MINORISTA 1],
      %w[SURAMERICANA 2],
      %w[MAYORISTA 3]
    ]
  end

  def select_encuesta_clase
    [
      ["CORRECTO", "CORRECTO"],
      ["INCORRECTO", "INCORRECTO"]
    ]
  end

  def select_opcion(encuestaspregunta_id)
    dato = []
    Encuestaspreopcion.where("encuestaspregunta_id = #{encuestaspregunta_id}").each do |encuestaspreopcion|
      dato << ["#{encuestaspreopcion.respuesta}", "#{encuestaspreopcion.id}"]
    end
    return dato
  end

  # ── Compatibilidad Rails 2 (prácticas de conducción) ───────────────────────

  def error_message_on(object_name, method, options = {})
    record = object_name.is_a?(Symbol) ? instance_variable_get("@#{object_name}") : object_name
    return ''.html_safe if record.blank? || !record.errors[method].any?

    content_tag(:span, record.errors[method].first, class: options[:css_class])
  end

  def form_field_error(form, method, options = {})
    return ''.html_safe if form.object.blank? || !form.object.errors[method].any?

    content_tag(:span, form.object.errors[method].first, class: options[:css_class] || 'cerror')
  end

  def calendar_date_select(object_name, method, options = {})
    record = instance_variable_get("@#{object_name}")
    value = record&.public_send(method)
    text_field_tag(
      "#{object_name}[#{method}]",
      value,
      class: [options[:class], 'datepicker'].compact.join(' '),
      size: options[:size]
    )
  end

  def observe_field(field_id, url: {}, on: 'blur', with: nil, **_options)
    path = url_for(controller: controller.controller_path, action: url[:action] || 'calcularvalor')
    with_js = with.to_s.gsub(/\bvalue\b/, 'el.value')
    javascript_tag(<<~JS.html_safe)
      (function() {
        function bindObserveField() {
          var el = document.getElementById('#{j field_id}');
          if (!el || el.dataset.observeBound) return;
          el.dataset.observeBound = '1';
          el.addEventListener('#{on}', function() {
            var qs = #{with_js};
            fetch('#{path}?' + qs, {
              headers: { 'X-Requested-With': 'XMLHttpRequest', 'Accept': 'application/json' },
              credentials: 'same-origin'
            })
            .then(function(r) { return r.json(); })
            .then(function(data) {
              var target = document.getElementById(data.field_id);
              if (target) target.value = data.value;
            });
          });
        }
        document.addEventListener('turbolinks:load', bindObserveField);
        document.addEventListener('DOMContentLoaded', bindObserveField);
        bindObserveField();
      })();
    JS
  end

  # Ventana popup estándar (legacy horario / trámites)
  def popup_ventana_grande
    ['new_window', 'height=1000,width=1000,scrollbars=yes']
  end

  # Rails2 :popup compat.
  # Usage:
  # link_to_popup "Ver Acta", {controller: "comites", action: "visualizar", id: @comite.id},
  #   popup: popup_ventana_grande, class: "btn btn-success"
  def link_to_popup(name = nil, options = nil, html_options = nil, &block)
    if block_given?
      html_options = options
      options = name
      name = capture(&block)
    end

    html_options ||= {}
    popup = html_options.delete(:popup)

    unless popup.nil?
      popup_name, features = popup
      features = features.to_s

      width = features[/width\s*=\s*(\d+)/, 1]
      height = features[/height\s*=\s*(\d+)/, 1]
      scrollbars = features[/scrollbars\s*=\s*(yes|no)/i, 1] || 'yes'
      popup_name ||= 'new_window'

      html_options[:data] ||= {}
      html_options[:data] = html_options[:data].transform_keys { |k| k.to_s.tr('-', '_').to_sym }
      html_options[:data].merge!(
        popup: true,
        popup_name: popup_name,
        popup_width: (width || 950).to_i,
        popup_height: (height || 700).to_i,
        popup_scrollbars: scrollbars,
        turbolinks: false,
        turbo: false
      )

      feature_str = "#{features},resizable=yes,toolbar=no,menubar=no,location=no,status=no"
      confirm_msg = html_options[:data].delete(:confirm)
      open_js = "window.open(this.href,'#{popup_name}','#{feature_str}');"
      if confirm_msg.present?
        open_js = "if(confirm(#{confirm_msg.to_json})){#{open_js}}"
      end
      # Un solo confirm (onclick). Sin data-confirm → rails-ujs no repite diálogo.
      html_options[:onclick] = "#{open_js}return false;"
    end

    link_to(name, options, html_options)
  end
end
