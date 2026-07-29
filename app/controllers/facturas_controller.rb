# frozen_string_literal: true

class FacturasController < ApplicationController
  layout :set_layout
  #before_action :checkaccess

  def checkaccess
    return is_permit('facturas')
  end

  # GET /facturas/verfactura?factura_id=X
  def verfactura
    @factura = Factura.find(params[:factura_id])
  end

  # GET /facturas
  def index
    @q        = Factura.ransack(params[:q])
    @facturas = @q.result.paginate(page: params[:page], per_page: 20)
    respond_to { |format| format.html }
  end

  # GET /facturas/busqueda
  def busqueda
  end

  # GET /facturas/buscar
  def buscar
    @facturas = Factura.buscar(
      params[:buscarident].to_s,
      params[:buscarnombre].to_s,
      params[:buscarfactura].to_s,
      params[:buscarabono].to_s
    )
    if @facturas.count == 1
      redirect_to edit_factura_path(@facturas.first)
    elsif @facturas.count == 0
      flash[:notice] = 'No hay informacion de la busqueda'
      redirect_to busqueda_facturas_path
    end
  end

  # GET /facturas/informe
  def informe
    if params.dig(:ubicacion, :inicial).blank? || params.dig(:ubicacion, :final).blank?
      flash[:notice] = 'Debe digitar datos para la consulta'
      redirect_to busqueda_facturas_path and return
    end
    @fch1    = params[:ubicacion][:inicial]
    @fch2    = params[:ubicacion][:final]
    @facturas = Factura.find_by_sql(
      "SELECT * FROM facturas WHERE DATE_FORMAT(CONVERT_TZ(created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'"
    )
    @abonos = Abono.find_by_sql(
      "SELECT * FROM abonos WHERE DATE_FORMAT(CONVERT_TZ(created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'"
    )
    @egresos = Egreso.find_by_sql(
      "SELECT * FROM egresos WHERE DATE_FORMAT(fecha,'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'"
    )
    @objetos = Objeto.find_by_sql(
      "SELECT DISTINCT t.descripcion, COUNT(1) cant, SUM(f.valor) val
       FROM facturas f
       JOIN tipostramites t ON f.tipostramite_id = t.id
       WHERE DATE_FORMAT(CONVERT_TZ(f.created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'
       GROUP BY t.descripcion"
    )
    respond_to do |format|
      format.html
      format.xlsx do
        filename = "Heroica_InformeDiario_#{@fch1}_#{@fch2}.xlsx"
        response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      end
    end
  end

  # GET /facturas/informeimp
  def informeimp
    @fch1    = params[:inicial]
    @fch2    = params[:final]
    @facturas = Factura.find_by_sql(
      "SELECT * FROM facturas WHERE DATE_FORMAT(CONVERT_TZ(created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'"
    )
    @abonos = Abono.find_by_sql(
      "SELECT * FROM abonos WHERE DATE_FORMAT(CONVERT_TZ(created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'"
    )
    @egresos = Egreso.find_by_sql(
      "SELECT * FROM egresos WHERE DATE_FORMAT(fecha,'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'"
    )
    @objetos = Objeto.find_by_sql(
      "SELECT DISTINCT t.descripcion, COUNT(1) cant, SUM(f.valor) val
       FROM facturas f
       JOIN tipostramites t ON f.tipostramite_id = t.id
       WHERE DATE_FORMAT(CONVERT_TZ(f.created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'
       GROUP BY t.descripcion"
    )
  end

  # GET /facturas/informeconsolidado
  def informeconsolidado
    if params.dig(:ubicacion, :inicial).blank? || params.dig(:ubicacion, :final).blank?
      flash[:notice] = 'Debe digitar datos para la consulta'
      redirect_to busqueda_facturas_path and return
    end
    @fch1    = params[:ubicacion][:inicial]
    @fch2    = params[:ubicacion][:final]
    @egresos = Egreso.find_by_sql(
      "SELECT * FROM egresos WHERE DATE_FORMAT(fecha,'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'"
    )
    @objetos = Objeto.find_by_sql(
      "SELECT DISTINCT t.descripcion, COUNT(1) cant, SUM(f.valor) val
       FROM facturas f
       JOIN tipostramites t ON f.tipostramite_id = t.id
       WHERE DATE_FORMAT(CONVERT_TZ(f.created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'
       GROUP BY t.descripcion"
    )
    respond_to do |format|
      format.html
      format.xlsx do
        filename = "Heroica_InformeConsolidado_#{@fch1}_#{@fch2}.xlsx"
        response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      end
    end
  end

  # GET /facturas/informeconsolidadoimp
  def informeconsolidadoimp
    @fch1    = params[:inicial]
    @fch2    = params[:final]
    @egresos = Egreso.find_by_sql(
      "SELECT * FROM egresos WHERE DATE_FORMAT(fecha,'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'"
    )
    @objetos = Objeto.find_by_sql(
      "SELECT DISTINCT t.descripcion, COUNT(1) cant, SUM(f.valor) val
       FROM facturas f
       JOIN tipostramites t ON f.tipostramite_id = t.id
       WHERE DATE_FORMAT(CONVERT_TZ(f.created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'
       GROUP BY t.descripcion"
    )
  end

  # GET /facturas/informeclases   → descarga XLSX
  def informeclases
    if params[:ubicacion].blank? ||
       params[:ubicacion][:inicial].blank? ||
       params[:ubicacion][:final].blank?
      flash[:notice] = 'Debe digitar datos para la consulta'
      redirect_to busqueda_facturas_path and return
    end
    @fch1 = params[:ubicacion][:inicial]
    @fch2 = params[:ubicacion][:final]
    @personastramiteshoras = Personastramiteshora.find_by_sql(
      "SELECT DATE_FORMAT(CONVERT_TZ(t.created_at,'+00:00','-05:00'),'%Y-%m-%d') fch,
              p.identificacion,
              CONCAT(p.primer_nombre,' ',p.segundo_nombre) nombre,
              CONCAT(p.primer_apellido,' ',p.segundo_apellido) apellido,
              c.nombre cat, t.placa_id, h.fecha,
              h.practicas, h.teoricas, h.taller,
              (h.practicas + h.teoricas + h.taller) total,
              h.personastramite_id, h.instructor_id
       FROM   personas p
       JOIN   personastramites t  ON t.persona_id = p.id
       JOIN   personastramiteshoras h ON h.personastramite_id = t.id
       JOIN   categorias c ON t.categoria_id = c.id
       WHERE  DATE_FORMAT(CONVERT_TZ(t.created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'
       ORDER BY p.identificacion, c.nombre, h.fecha ASC"
    )
    @objetos = Objeto.find_by_sql(sql_informeclases_objetos(@fch1, @fch2))
    filename = "Heroica_Clases_#{Time.now.strftime('%Y%m%d_%H%M%S')}.xlsx"
    respond_to do |format|
      format.html { render 'informeclasesimp' }
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      end
    end
  end

  # GET /facturas/informeclasesimp   → vista HTML imprimible
  def informeclasesimp
    if params.dig(:ubicacion, :inicial).blank? || params.dig(:ubicacion, :final).blank?
      flash[:notice] = 'Debe digitar datos para la consulta'
      redirect_to busqueda_facturas_path and return
    end
    @fch1 = params[:ubicacion][:inicial]
    @fch2 = params[:ubicacion][:final]
    @personastramiteshoras = Personastramiteshora.find_by_sql(
      "SELECT DATE_FORMAT(CONVERT_TZ(t.created_at,'+00:00','-05:00'),'%Y-%m-%d') fch,
              p.identificacion,
              CONCAT(p.primer_nombre,' ',p.segundo_nombre) nombre,
              CONCAT(p.primer_apellido,' ',p.segundo_apellido) apellido,
              c.nombre cat, t.placa_id, h.fecha,
              h.practicas, h.teoricas, h.taller,
              (h.practicas + h.teoricas + h.taller) total,
              h.personastramite_id, h.instructor_id
       FROM   personas p
       JOIN   personastramites t  ON t.persona_id = p.id
       JOIN   personastramiteshoras h ON h.personastramite_id = t.id
       JOIN   categorias c ON t.categoria_id = c.id
       WHERE  DATE_FORMAT(CONVERT_TZ(t.created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{@fch1}' AND '#{@fch2}'
       ORDER BY p.identificacion, c.nombre, h.fecha ASC"
    )
    @objetos = Objeto.find_by_sql(sql_informeclases_objetos(@fch1, @fch2))
  end

  # GET /facturas/:id/edit
  def edit
    @factura         = Factura.find(params[:id])
    @detallesfactura = Detallesfactura.new
    @abono           = Abono.new
  end

  # PATCH /facturas/:id  — sólo se usa para ANULAR la factura
  def update
    @factura           = Factura.find(params[:id])
    @factura.user_anula = is_admin
    @factura.estado    = 'A'

    if @factura.save
      ActiveRecord::Base.connection.execute(
        "UPDATE personastramites SET factura_id = NULL WHERE factura_id = #{params[:id]}"
      )
      flash[:notice] = 'Factura Anulada con exito.'
      redirect_to edit_factura_path(@factura)
    else
      @detallesfactura = Detallesfactura.new
      @abono           = Abono.new
      render :edit
    end
  rescue StandardError
    redirect_to edit_factura_path(@factura)
  end

  private

  # Consolidado por alumno+categoría (compatible con MySQL ONLY_FULL_GROUP_BY)
  def sql_informeclases_objetos(fch1, fch2)
    <<~SQL.squish
      SELECT MIN(DATE_FORMAT(CONVERT_TZ(t.created_at,'+00:00','-05:00'),'%Y-%m-%d')) AS fch,
             p.identificacion,
             MAX(CONCAT(p.primer_nombre,' ',IFNULL(p.segundo_nombre,''))) AS nombre,
             MAX(CONCAT(p.primer_apellido,' ',IFNULL(p.segundo_apellido,''))) AS apellido,
             t.categoria_id,
             c.nombre AS cat,
             SUM(h.practicas) AS pra,
             SUM(h.teoricas) AS teo,
             SUM(h.taller) AS tal
      FROM   personas p
      JOIN   personastramites t ON t.persona_id = p.id
      JOIN   personastramiteshoras h ON h.personastramite_id = t.id
      JOIN   categorias c ON t.categoria_id = c.id
      WHERE  DATE_FORMAT(CONVERT_TZ(t.created_at,'+00:00','-05:00'),'%Y-%m-%d') BETWEEN '#{fch1}' AND '#{fch2}'
      GROUP BY p.identificacion, t.categoria_id, c.nombre
      ORDER BY p.identificacion, c.nombre
    SQL
  end

  def factura_params
    params.require(:factura).permit!
  end

  def set_layout
    if %w[informeclases].include?(action_name)
      'excel'
    elsif %w[verfactura informe informeconsolidado informeimp informeconsolidadoimp informeclasesimp].include?(action_name)
      'informes'
    else
      'application'
    end
  end
end
