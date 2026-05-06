class AbonosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def verabono
    @abono = Abono.find(params[:abono_id])
  end

  def index
    factura   = Factura.find(params[:factura_id])
    @abonos = factura.abonos.all
  end

 def edit
    @abono  = Abono.find(params[:id], :include => "factura")
    @factura  = @abono.factura
    respond_to do |format|
      format.js { render :action => "edit_abono" }
    end
  end

  def create
    valor = 0
    valorfactura = 0
    valorinicial = 0
    @factura  = Factura.find(params[:factura_id])
    valorfactura  = @factura.valor
    @abono = Abono.new(params[:abono])
    if @abono.valor > 0
      @objetos = Objeto.find_by_sql("select CAST(sum(valor) as signed) abonos from abonos where factura_id = #{params[:factura_id]} and estado != 'A'")
      @objetos.each do |aabb|
        valorinicial = aabb.abonos.to_i
        valor = aabb.abonos.to_i + @abono.valor
      end
      if valor.to_i > valorfactura.to_i
        flash[:abono] = "El valor del Abono supera el valor de la factura"
      else
        @abono.nro_abono = is_liq
        @abono.saldo     = valorfactura.to_i - valorinicial.to_i - @abono.valor.to_i
        @abono.user_id   = is_admin
        @abono.estado = 'C'
        if @abono.valid?
          @factura.abonos << @abono
          @factura.save
          if valor.to_i == valorfactura.to_i
            ActiveRecord::Base.connection.execute("update facturas set estado = 'C' where id = #{params[:factura_id]}")
          end
          @abono = Abono.new
          flash[:abono] = "Creado con exito"
        else
          flash[:abono] = "Se produjo un error al guardar el registro"
        end
      end
    else
      flash[:abono] = "El valor del abono debe ser superior a CERO"
    end
    if valor.to_i == valorfactura.to_i
      flash[:notice] = "Abono Registrado y Factura Cancelada"
      render :update do |page|
         page.redirect_to edit_factura_path(@factura)
      end
    else
      respond_to do |format|
        format.js { render :action => "abonos" }
      end
    end
  end

  def update
    @abono        = Abono.new
    abono         = Abono.find(params[:id])
    @factura        = abono.factura
    ok = abono.update_attributes(params[:abono])
    if ok == true
      flash[:abono] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "abonos" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

#  def destroy
#    abono   = Abono.find(params[:id])
#    @factura  = abono.factura
#    @abono  = Abono.new
##    abono.respaldo(is_admin)
#    abono.destroy
#    flash[:abono] = "Borrado con exito"
#    respond_to do |format|
#      format.js { render :action => "abonos" }
#    end
#  end

  def destroy
    @abono   = Abono.find(params[:id])
       ActiveRecord::Base.connection.execute(
        "update abonos set user_anula = #{is_admin}, valor = 0, saldo = 0, estado = 'A', updated_at = CURRENT_TIMESTAMP()
         where  id = #{@abono.id}")
    ActiveRecord::Base.connection.execute(
       "update facturas set estado = 'P'
         where  id = #{@abono.factura_id}")
    flash[:abono] = "Anulado con exito..."
    respond_to do |format|
      format.js { render :action => "abonos" }
    end
  end

  def anula
    @abono        = Abono.new
    abono         = Abono.find(params[:id])
    ActiveRecord::Base.connection.execute(
    "update abonos set user_anula = #{is_admin}, valor = 0, saldo = 0, estado = 'A', updated_at = CURRENT_TIMESTAMP()
    where  id = #{abono.id}")
    ActiveRecord::Base.connection.execute(
       "update facturas set estado = 'P'
         where  id = #{abono.factura_id}")
    @factura        = abono.factura
    ok = abono.update_attributes(params[:abono])
    flash[:abono] = "Abono Anulado con Exito"
    respond_to do |format|
      format.js { render :action => "abonos" }
    end   
  end

  private
  def determine_layout
    if ['crearfactura','verabono'].include?(action_name)
      "informes"
    else
      "application"
    end
  end


end
