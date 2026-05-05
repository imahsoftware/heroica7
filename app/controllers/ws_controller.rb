class WsController < ApplicationController
  protect_from_forgery with: :null_session

  layout :determine_layout

  before_action :authenticate_user!, except: [:confirmacion]

  require 'uri'
  require 'net/https'
  require "json"
  require 'net/http'
  require 'openssl'
  require 'open-uri'

  extend WsHelper

  def self.smscolombiared(nroTel, messageSend)
    to = "#{nroTel}"
    username = Parametro.find(48).valor.to_s
    password = Parametro.find(49).valor.to_s
    token    = Base64.strict_encode64("#{username}:#{password}")
    headers  = {
      'Authorization' => "Basic #{token}",
      'Content-Type'  => 'application/json'
    }
    payload = {
      country: "57",
      dateToSend: nil,
      message:  messageSend.to_s,
      encoding: "UTF-8",
      messageFormat: 0,
      addresseeList: [
        {
          mobile: to,
          correlationLabel: nil,
          url: nil
        }
      ]
    }.to_json

    uri  = URI.parse('https://apitellit.aldeamo.com/SmsiWS/smsSendPost/')
    http = Net::HTTP.new(uri.host, uri.port).tap { |h| h.use_ssl = true; h.open_timeout = 5; h.read_timeout = 5 }
    req  = Net::HTTP::Post.new(uri.request_uri, headers)
    req.body = payload

    response = http.request(req)
    code     = response.code.to_i
    body     = response.body.to_s

  end

  def self.smscolombiaredmasivo(nrosTel, messageSend)
    to = "57#{nroTel}"
    username = Parametro.find(48).valor
    password = Parametro.find(49).valor
    token    = Base64.strict_encode64("#{username}:#{password}")
    headers  = {
      'Authorization' => "Basic #{token}",
      'Content-Type'  => 'application/json'
    }
    payload = {
      country: "57",
      dateToSend: nil,
      message:  messageSend.to_s,
      encoding: "UTF-8",
      messageFormat: 0,
      addresseeList: [
        {
          mobile: to,
          correlationLabel: nil,
          url: nil
        }
      ]
    }.to_json

    uri  = URI.parse('https://apitellit.aldeamo.com/SmsiWS/smsSendPost/')
    http = Net::HTTP.new(uri.host, uri.port).tap { |h| h.use_ssl = true; h.open_timeout = 5; h.read_timeout = 5 }
    req  = Net::HTTP::Post.new(uri.request_uri, headers)
    req.body = payload

    code   = nil
    status = nil
    body   = nil

    begin
      response = http.request(req)
      code     = response.code.to_i
      body     = response.body.to_s
    rescue StandardError => e
      status = "Exception: #{e.class}"
      body   = e.message
    end
=begin
    require "uri"
    require "json"
    require "net/http"
    url = URI("http://api.messaging-service.com/sms/2/text/advanced")
    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Post.new(url)
    request["Accept"] = "application/json"
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Basic RVNDVklDT05EMjAyMzojRVZDMjAyMy5WZXJqc2hzdHRz"
    request.body = JSON.dump({"messages": [{"from": "EVC","destinations": [{"to": "#{nrosTel.to_s}"}],
                                            "text": "#{messageSend}"}]})
    response = http.request(request)
    puts "Enviado!!! " + response.read_body.to_s
=end
  end

  # # ******************************************************************************
  # ------------------- METODOS DE PARAMETRIZACION SIIGO -------------------
  # # ******************************************************************************
=begin
  def self.issocialreason(tDocumento)
    vlr_issocialreason(tDocumento)
  end

  def self.idtypecode(tDocumento)
    vlr_idtypecode(tDocumento)
  end

  def self.fullname(tDocumento,vlNombre)
    vlr_fullname(tDocumento,vlNombre)
  end

  def self.firstnam(tDocumento,vlPrimerNombre)
    vlr_name(tDocumento,vlPrimerNombre)
  end

  def self.lastname(tDocumento, vlPrimerApellido)
    vlr_name(tDocumento, vlPrimerApellido)
  end
=end

  # ********************************************************************************
  # ------------------- INICIA PROCESO DE SIIGO ------------------------------------
  # # ******************************************************************************

  def self.tokensiigo(idPortafolio)
    portafolio = Portafolio.find(idPortafolio)
    url = URI("https://api.siigo.com/auth")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url)
    request.body = JSON.dump({ "username": "siigoapi@pruebas.com", "access_key": "OWE1OGNkY2QtZGY4ZC00Nzg1LThlZGYtNmExMzUzMmE4Yzc1Omt2YS4yJTUyQEU=" })
    request["Content-Type"] = "application/json"
    response = https.request(request)
    retData = JSON.parse response.body
    token = retData["access_token"]
    return token

  end

  def self.crear_account(idP)
    p = Persona.find(idP)
    po = Portafolio.find(4)
    token = self.tokensiigo(p.portafolio_id)
    if p.direccion.to_s == ""
      dir = "Sin info"
    else
      dir = p.direccion.to_s
    end
    if token
      url = URI("https://api.siigo.com/v1/customers")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = token
      request.body = JSON.generate({ "type": "Customer",
                                     "person_type": "Person",
                                     "id_type": "#{self.vlr_idtypecode(p.documento)}",
                                     "identification": "#{p.identificacion.to_s}",
                                     "check_digit": "4",
                                     "name": ["#{p.primer_nombre.to_s + ' ' + p.segundo_nombre.to_s}", "#{p.primer_apellido.to_s + ' ' + p.segundo_apellido.to_s}"],
                                     "commercial_name": "Siigo",
                                     "branch_office": 0,
                                     "active": true,
                                     "vat_responsible": false,
                                     "fiscal_responsibilities": [{ "code": "R-99-PN" }],
                                     "address": { "address": "#{dir}",
                                                  "city": { "country_code": "Co",
                                                            "state_code": "#{Municipio.find(p.municipio_id).cod_departamento_siigo}",
                                                            "city_code": "#{Municipio.find(p.municipio_id).codigo}" },
                                                  "postal_code": "110911" },
                                     "phones": [{ "indicative": "57",
                                                  "number": "#{p.celular.to_s}",
                                                  "extension": "0" }],
                                     "contacts": [{ "first_name": "#{p.primer_nombre.to_s + ' ' + p.segundo_nombre.to_s}",
                                                    "last_name": "#{p.primer_apellido.to_s + ' ' + p.segundo_apellido.to_s}", "email": "#{p.email.to_s}",
                                                    "phone": { "indicative": "57",
                                                               "number": "#{p.celular.to_s}",
                                                               "extension": "0" } }],
                                     "comments": "Pago EVC - Siigo" })

      response = https.request(request)
      retData = JSON.parse response.body
      if retData["id"].present?
        ActiveRecord::Base.connection.execute("update personas set siigo_account = '#{retData["id"].to_s}', response_siigo = '#{response.body.to_s}' where id = #{idP}")
      else
        ActiveRecord::Base.connection.execute("update personas set error_siigo = '#{retData["Errors"][0]["Message"].to_s}', response_siigo = '#{response.body.to_s}' where id = #{idP}")
      end
    end
  rescue Exception => e
    ActiveRecord::Base.connection.execute("update personas set error_siigo = '#{e.message[0..500].to_s}' where id = #{idP}")
    puts "********* Error(self.crear_contact) .............................. ******** " + e.message[0..500].to_s
  end

=begin
  def self.crear_contact(idP,idA) #Contact Create Complete
    p = Persona.find(idP)
    po = Portafolio.find(p.persona.portafolio_id)
    token = self.tokensiigo(p.persona.portafolio_id)
    if p.direccion.to_s == ""
      dir = "Sin info"
    else
      dir = p.direccion.to_s
    end
    if token
      url = URI("http://siigoapi.azure-api.net/siigo/api/v1/Contacts/Create?namespace=v1")
      http = Net::HTTP.new(url.host, url.port);
      request = Net::HTTP::Post.new(url)
      request["Ocp-Apim-Subscription-Key"] = "#{po.siigo_ocp.to_s}"
      request["Authorization"] = token
      request["Content-Type"] = "application/json"
      request.body = "{\r
      \"Id\": 0,\r
      \"Code\": null,\r
      \"AccountID\": #{idA},    \r
      \"Phone1\": {\r
      \"Indicative\": null,\r
      \"Number\": null,\r
      \"Extention\": null\r
                                              },\r
      \"Mobile\": {\r
      \"Indicative\": null,\r
      \"Number\": null,\r
      \"Extention\": null\r
                                              },\r
      \"EMail\": \"#{p.email.to_s}\",\r
      \"FirstName\": \"#{self.vlr_name(p.documento, p.siet_nombres)}\",\r
      \"LastName\": \"#{self.vlr_name(p.documento, p.siet_apellidos)}\",\r
      \"Fax\": null,\r
      \"IsPrincipal\": true,\r
      \"Gender\": null,\r
      \"ChargeID\": null,\r
      \"BirthDate\": null\r\n}"
      response = http.request(request)
      #puts "valores json......." + request.body.to_s
      #puts response.read_body
      retData = JSON.parse response.body
      dato = retData["Id"]
      ActiveRecord::Base.connection.execute("update personas set siigo_account = #{idA}, siigo_contact = #{dato} where id = #{idP}")
      puts "-------------------- Create Contact ----------------------------" + dato.to_s
    end
    rescue Exception => e
      puts "********* Error(self.crear_contact) .............................. ******** "+e.message[0..500].to_s
  end
=end

  # Descripcion: Metodo para envio de factura siigo a la dian
  # Fecha Creacion: 28-Marzo-2023
  # Autor: AFP

  def self.crear_factura(idF)
    p = Factura.find(idF)
    if p.user.tipocliente.to_s == '1'
      #Minorista
      siigo_doccode = 'FEMI'
    elsif p.user.tipocliente.to_s == '2'
      #Sura
      siigo_doccode = 'FE65'
    end
    pe = Persona.find(p.persona_id)
    puts "---------- Create Contact desde factura ------------"
    self.crear_account(pe.id)
    puts "---------- Final Contact desde factura ------------"
    po = Portafolio.find(pe.portafolio_id)
    token = self.tokensiigo(pe.portafolio_id)
    puts "---------- token generadooo ------------"
    if token
      url = URI("https://api.siigo.com/v1/invoices")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = token
      if p.siigo_nro.to_s == "" && p.siigo_id.to_s == ""
        vlr = []
        p.detallesfacturas.each do |d|
          detalle = {
            "code" => "ANSV",
            "description" => "#{d.concepto.descripcion.to_s rescue nil}",
            "quantity" => "1",
            "price" => "#{d.valor.to_f}"
          }
          vlr << detalle
        end
        vlrab = []
        Abono.select("(CASE WHEN forma_pago = 'EFECTIVO' THEN '9108' WHEN forma_pago IN ('CONSIGNACION','TRANSFERENCIA') THEN '9092' END) codigo, SUM(valor) valor").where(factura_id: p.id, estado: 'C').group("codigo").each do |ab|
          detalle2 = {
            "id" => "8752",
            "value" => "#{ab.valor.to_f}",
            "due_date" => "#{Time.now.strftime("%Y-%m-%d").to_s}"
          }
          vlrab << detalle2
        end
        request.body = JSON.dump({
                                   "document": {
                                     "id": 24446 # Es de pruebas , se debe de consumir el servicio de tipo de comprobante
                                   },
                                   "date": "#{Time.now.strftime("%Y-%m-%d").to_s}",
                                   "customer": {
                                     "identification": "#{pe.identificacion.to_s}"
                                   },
                                   "cost_center": p.codigo_centrocosto_siigo.to_i, # Definir los centros de costo con fabi
                                   "seller": 1018, # Definr con fabian porque son los usuarios de notificacion
                                   "observations": "DEFINIR TEXTO PARA INTEGRACION",
                                   "items": vlr,
                                   "payments": vlrab,
                                   "additional_fields": {}
                                 })
        response = https.request(request)
        retData = JSON.parse response.body
        if retData["id"].present?
          ActiveRecord::Base.connection.execute("update facturas set siigo_nro = '#{retData["number"].to_s}', observacion = 'ENVIO SIIGO', siigo_id = '#{retData["id"].to_s}', siigo_fecha = now() where id = #{idF}")
        else
          ActiveRecord::Base.connection.execute("update facturas set siigo_error = '#{retData["Errors"][0]["Message"].to_s}' where id = #{idF}")
        end
        puts 'sale de la factura .....................................................................'
      end
    end
  rescue Exception => e
    p.update_columns(observacion: e.message[0..255].to_s)
    puts "************** Error(self.crear_factura) ............  " + e.message[0..500].to_s
  end

  def self.envio_masivo_siigo
    Factura.where(["date_format(created_at,'%%Y-%%m-%%d') >= '2021-01-14' and estado = 'C' AND siigo_id is null"]).order("date_format(created_at,'%Y-%m-%d') asc").each do |f|
      code = WsController.crear_factura(f.id)
    end
  end

=begin
  def self.crear_factura(idF)
    p = Factura.find(idF)
    if p.user.tipocliente.to_s == '1'
      #Minorista
      siigo_doccode = 'FEMI'
    elsif p.user.tipocliente.to_s == '2'
      #Sura
      siigo_doccode = 'FE65'
    end
    pe = Persona.find(p.personastramite.persona_id)
    puts "---------- Create Contact desde factura ------------"
    self.crear_account(pe.id)
    puts "---------- Final Contact desde factura ------------"
    po = Portafolio.find(pe.portafolio_id)
    token = self.tokensiigo(pe.portafolio_id)
    puts "---------- token generadooo ------------"
    #puts token
    if token
      url = URI("http://siigoapi.azure-api.net/siigo/api/v1/Invoice/Save?namespace=v1")
      http = Net::HTTP.new(url.host, url.port);
      request = Net::HTTP::Post.new(url)
      request["Ocp-Apim-Subscription-Key"] = "#{po.siigo_ocp.to_s}"
      request["Authorization"] = token
      request["Content-Type"] = "application/json"
      #DocCode anterior... 45558,
      vlr = []
      puts "---------- Ingreso ------------"
      p.detallesfacturas.each do |d|
        vlr << " {\"ProductCode\": \"ANSV\",
                  \"Description\": \"#{d.concepto.descripcion.to_s rescue nil}\",
                  \"GrossValue\": #{d.valor.to_f},
                  \"BaseValue\": #{d.valor.to_f},
                  \"Quantity\": 1,
                  \"UnitValue\": #{d.valor.to_f},
                  \"TaxAddName\": \"\",
                  \"TaxAddId\": -1,
                  \"TaxDiscountId\": -1,
                  \"TotalValue\": #{d.valor.to_f},
                  \"TaxAdd2Id\": -1}"
      end
      vlrab = []
      Abono.select("(CASE WHEN forma_pago = 'EFECTIVO' THEN '9108' WHEN forma_pago IN ('CONSIGNACION','TRANSFERENCIA') THEN '9092' END) codigo, SUM(valor) valor").where(factura_id: p.id, estado: 'C').group("codigo").each do |ab|
        vlrab << " { \"PaymentMeansCode\": #{ab.codigo.to_i},
                     \"Value\": #{ab.valor.to_f},
                     \"DueDate\": \"#{Time.now.strftime("%Y%m%d").to_s}\",
                     \"DueQuote\": 1}"
      end

      request.body = "{\"Header\": {
                                    \"DocCode\": #{siigo_doccode.to_s},
                                    \"Number\": 0,
                                    \"DocDate\": \"#{Time.now.strftime("%Y%m%d").to_s}\",
                                    \"VATTotalValue\": 0,
                                    \"RetVATTotalID\": -1,
                                    \"RetVATTotalPercentage\": -1,
                                    \"RetVATTotalValue\": 0,
                                    \"RetICATotalID\": -1,
                                    \"RetICATotalValue\": 0,
                                    \"RetICATotaPercentage\": -1,
                                    \"SelfWithholdingTaxID\": -1,
                                    \"TotalValue\": #{p.valor.to_f},
                                    \"TotalBase\": #{p.valor.to_f},
                                    \"SalesmanIdentification\": \"#{po.siigo_salesmansdentification.to_s}\",
                                    \"Observations\": \"#{'Los valores correspondientes a conceptos de SICOV, Agencia nacional de seguridad vial y Recaudo, corresponden a ingresos recibidos para terceros.'}\",
                                    \"Account\": {
                                        \"IsSocialReason\": #{self.vlr_issocialreason(pe.documento)},
                                        \"FullName\": \"#{self.vlr_fullname(pe.documento, pe.nombre)}\",
                                        \"FirstName\": \"#{self.vlr_name(pe.documento, pe.siet_nombres)}\",
                                        \"LastName\": \"#{self.vlr_name(pe.documento, pe.siet_apellidos)}\",
                                        \"IdTypeCode\": \"#{self.vlr_idtypecode(pe.documento)}\",
                                        \"Identification\": \"#{pe.identificacion.to_s}\",
                                        \"CheckDigit\": 8,
                                        \"BranchOffice\": 0,
                                        \"IsVATCompanyType\": false,
                                        \"City\": {
                                            \"CountryCode\": \"Co\",
                                            \"StateCode\": \"0#{Municipio.find(pe.municipio_id).cod_departamento}\",
                                            \"CityCode\": \"#{Municipio.find(pe.municipio_id).codigo}\"
                                        },
                                        \"Address\": \"Dirección Tercero\",
                                        \"Phone\": {
                                            \"Number\": 0
                                        }
                                  },
                            \"Contact\": {
                                \"Phone1\": {
                                    \"Number\": #{pe.celular.to_s}
                                },
                                \"Mobile\": {
                                    \"Number\": 0
                                },
                                \"EMail\": \"#{pe.email.to_s}\",
                                \"FirstName\": \"#{self.vlr_name(pe.documento, pe.siet_nombres)}\",
                                \"LastName\": \"#{self.vlr_name(pe.documento, pe.siet_apellidos)}\",
                                \"IsPrincipal\": true,
                            },
                        },
                      \"Items\": [#{vlr.join(',')}],
                      \"Payments\": [#{vlrab.join(',')}]\n}"
      response = http.request(request)
      #puts "valores json......." + request.body.to_s
      #puts response.read_body
      retData = JSON.parse response.body
      ActiveRecord::Base.connection.execute("update facturas set siigo_id = #{retData["Header"]["Id"]}, siigo_nro = #{retData["Header"]["Number"]}, siigo_fecha = now() where id = #{idF}")
      puts "-------------------- Create Factura ----------------------" + retData["Header"]["Number"].to_s
      #puts retData
    end
  rescue Exception => e
    ActiveRecord::Base.connection.execute("update facturas set siigo_error = #{e.message[0..2000].to_s} where id = #{idF}")
    puts "************** Error(self.crear_factura) ............  " + e.message[0..2000].to_s
  end
=end

  private

  def determine_layout
    if ['respuesta', 'confirmacion'].include?(action_name)
      "login"
    else
      "application_admin"
    end
  end
end