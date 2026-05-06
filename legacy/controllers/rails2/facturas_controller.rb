class FacturasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def verfactura
    @factura = Factura.find(params[:factura_id])
  end

  def index
    @facturas = Factura.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @facturas }
    end
  end

  def buscar
    #if params[:buscarident].to_s == nil and params[:buscarnombre]
    @facturas      = Factura.buscar(params[:buscarident], params[:buscarnombre], params[:buscarfactura], params[:buscarabono])
    if @facturas.count == 1
      redirect_to edit_factura_path(@facturas)
    elsif @facturas.count == 0
      flash[:notice] = "No hay informacion de la busqueda"
      redirect_to busqueda_facturas_path
    end
#  rescue
#    flash[:notice] = "Debe digitar datos para la consulta"
#    redirect_to busqueda_facturas_path
  end

  def informe
    if params[:ubicacion][:inicial].to_s == nil and params[:ubicacion][:final].to_s == nil
      flash[:notice] = "Debe digitar datos para la consulta"
      redirect_to busqueda_facturas_path
    else
      @facturas  = Factura.find_by_sql("select * from facturas where DATE_FORMAT(created_at,'%Y-%m-%d') between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}'")
      @abonos    = Abono.find_by_sql("select * from abonos where DATE_FORMAT(created_at,'%Y-%m-%d') between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}'")
      @egresos   = Egreso.find_by_sql("select * from egresos where DATE_FORMAT(fecha,'%Y-%m-%d') between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}'")
      @objetos   = Objeto.find_by_sql("select distinct t.descripcion, count(9) cant, sum(valor) val
                                       from   facturas f, tipostramites t
                                       where  f.tipostramite_id = t.id
                                       and    DATE_FORMAT(f.created_at,'%Y-%m-%d') between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}'
                                       group by t.descripcion")
      @fch1 = params[:ubicacion][:inicial]
      @fch2 = params[:ubicacion][:final]
    end
  end

  def informeconsolidado
    if params[:ubicacion][:inicial].to_s == nil and params[:ubicacion][:final].to_s == nil
      flash[:notice] = "Debe digitar datos para la consulta"
      redirect_to busqueda_facturas_path
    else
      @egresos   = Egreso.find_by_sql("select * from egresos where DATE_FORMAT(fecha,'%Y-%m-%d') between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}'")
      @objetos   = Objeto.find_by_sql("select distinct t.descripcion, count(9) cant, sum(valor) val
                                       from   facturas f, tipostramites t
                                       where  f.tipostramite_id = t.id
                                       and    DATE_FORMAT(f.created_at,'%Y-%m-%d') between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}'
                                       group by t.descripcion")
      @fch1 = params[:ubicacion][:inicial]
      @fch2 = params[:ubicacion][:final]
    end
  end

  def informeconsolidadoimp
    @fch1 = params[:inicial]
    @fch2 = params[:final]
    @egresos   = Egreso.find_by_sql("select * from egresos where DATE_FORMAT(fecha,'%Y-%m-%d') between '#{@fch1}' and '#{@fch2}'")
    @objetos   = Objeto.find_by_sql("select distinct t.descripcion, count(9) cant, sum(valor) val
                                     from   facturas f, tipostramites t
                                     where  f.tipostramite_id = t.id
                                     and    DATE_FORMAT(f.created_at,'%Y-%m-%d') between '#{@fch1}' and '#{@fch2}'
                                     group by t.descripcion")
  end

  def informeimp
    @fch1 = params[:inicial]
    @fch2 = params[:final]
    @facturas  = Factura.find_by_sql("select * from facturas where DATE_FORMAT(created_at,'%Y-%m-%d') between '#{@fch1}' and '#{@fch2}'")
    @abonos    = Abono.find_by_sql("select * from abonos where DATE_FORMAT(created_at,'%Y-%m-%d') between '#{@fch1}' and '#{@fch2}'")
    @egresos   = Egreso.find_by_sql("select * from egresos where DATE_FORMAT(fecha,'%Y-%m-%d') between '#{@fch1}' and '#{@fch2}'")
    @objetos   = Objeto.find_by_sql("select distinct t.descripcion, count(9) cant, sum(valor) val
                                     from   facturas f, tipostramites t
                                     where  f.tipostramite_id = t.id
                                     and    DATE_FORMAT(f.created_at,'%Y-%m-%d') between '#{@fch1}' and '#{@fch2}'
                                     group by t.descripcion")
  end

  def informeclasesimp
    if params[:ubicacion][:inicial].to_s == nil and params[:ubicacion][:final].to_s == nil
      flash[:notice] = "Debe digitar datos para la consulta"
      redirect_to menus_path
    else
      @personastramiteshoras = Personastramiteshora.find_by_sql(
        "select DATE_FORMAT(t.created_at,'%Y-%m-%d') fch, p.identificacion, concat(p.primer_nombre,' ',p.segundo_nombre) nombre, concat(p.primer_apellido,' ',p.segundo_apellido) apellido, c.nombre cat, t.placa_id, h.fecha, h.practicas, h.teoricas, h.taller, (h.practicas+h.teoricas+ h.taller) total, h.personastramite_id
         from   personas p, personastramites t, personastramiteshoras h, categorias c
         where  t.id = h.personastramite_id
         and    DATE_FORMAT(t.created_at,'%Y-%m-%d') between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}'
         and    t.persona_id = p.id
         and    t.categoria_id = c.id
         order by p.identificacion, c.nombre, h.fecha asc")
      @objetos   = Objeto.find_by_sql(
        "select DATE_FORMAT(t.created_at,'%Y-%m-%d') fch, p.identificacion, concat(p.primer_nombre,' ',p.segundo_nombre) nombre, concat(p.primer_apellido,' ',p.segundo_apellido) apellido, t.categoria_id, c.nombre cat, sum(h.practicas) pra, sum(h.teoricas) teo, sum(h.taller) tal
         from   personas p, personastramites t, personastramiteshoras h, categorias c
         where  t.id = h.personastramite_id
         and    DATE_FORMAT(t.created_at,'%Y-%m-%d') between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}'
         and    t.persona_id = p.id
         and    t.categoria_id = c.id
         group by p.identificacion, c.nombre")
      @fch1 = params[:ubicacion][:inicial]
      @fch2 = params[:ubicacion][:final]
      respond_to do |format|
         format.html
      end
    end
  end
  
  def new
    @factura = Factura.new
    render :action => "factura_form"
  end

  def edit
    @factura = Factura.find(params[:id])
    @detallesfactura = Detallesfactura.new
    @abono = Abono.new
    respond_to do |format|
      format.html { render :action => "factura_form" }
    end
  end

  def create
    @factura = Factura.new(params[:factura])
    @factura.user_id = is_admin
    if @factura.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit_factura_path(@factura)
    else
      render :action => "factura_form"
     end
  end

  def update
    @factura = Factura.find(params[:id])
    @factura.user_anula = is_admin
    @factura.estado = 'A'
    if @factura.update_attributes(params[:factura])
      ActiveRecord::Base.connection.execute("update personastramites set factura_id = null where factura_id = #{params[:id]}")
      flash[:notice] = "Factura Anulada con exito."
      redirect_to edit_factura_path(@factura)
    else
      @detallesfactura = Detallesfactura.new
      @abono = Abono.new
      render :action => "factura_form"
    end
    rescue
      redirect_to edit_factura_path(@factura)
  end

  def destroy
    @factura = Factura.find(params[:id])
    @factura.destroy
    respond_to do |format|
      format.html { redirect_to(facturas_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['informefactura','verfactura','informeimp','informeconsolidadoimp'].include?(action_name)
      "informes"
    else
      "application"
    end
  end
end
