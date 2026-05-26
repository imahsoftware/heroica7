# frozen_string_literal: true

class AbonosController < ApplicationController
  before_action :checkaccess, except: [:verabono]
  before_action :set_factura, except: [:verabono]
  before_action :set_abono,   only: [:edit, :update, :destroy, :anula]

  def checkaccess
    return is_permit('abonos')
  end

  # GET /abonos/verabono?abono_id=X  (abre en ventana nueva, sin autenticación de módulo)
  def verabono
    @abono = Abono.find(params[:abono_id])
    render layout: 'informes'
  end

  def edit
    respond_to { |format| format.js }
  end

  def create
    valor        = 0
    valorfactura = @factura.valor.to_i
    valorinicial = 0

    @abono = Abono.new(abono_params)

    if @abono.valor.to_i <= 0
      flash.now[:abono] = 'El valor del abono debe ser superior a CERO'
      respond_to { |f| f.js { render 'abonos' } }
      return
    end

    resultado = ActiveRecord::Base.connection.select_one(
      "SELECT CAST(COALESCE(SUM(valor), 0) AS signed) AS abonos FROM abonos WHERE factura_id = #{@factura.id} AND estado != 'A'"
    )
    valorinicial = resultado['abonos'].to_i
    valor        = valorinicial + @abono.valor.to_i

    if valor > valorfactura
      flash.now[:abono] = 'El valor del Abono supera el valor de la factura'
      respond_to { |f| f.js { render 'abonos' } }
      return
    end

    @abono.nro_abono = is_liq
    @abono.saldo     = valorfactura - valorinicial - @abono.valor.to_i
    @abono.user_id   = is_admin
    @abono.estado    = 'C'

    if @abono.valid?
      @factura.abonos << @abono

      if valor == valorfactura
        ActiveRecord::Base.connection.execute(
          "UPDATE facturas SET estado = 'C' WHERE id = #{@factura.id}"
        )
        flash[:notice] = 'Abono Registrado y Factura Cancelada'
        respond_to { |f| f.js { render 'abono_redirect' } }
      else
        @abono = Abono.new
        flash.now[:abono] = 'Creado con exito'
        respond_to { |f| f.js { render 'abonos' } }
      end
    else
      flash.now[:abono] = 'Se produjo un error al guardar el registro'
      respond_to { |f| f.js { render 'abonos' } }
    end
  end

  def update
    if @abono.update(abono_params)
      @abono = Abono.new
      flash.now[:abono] = 'Actualizado con Exito'
    else
      flash.now[:abono] = 'El registro tiene inconsistencias. Verifique!!'
    end
    respond_to { |f| f.js { render 'abonos' } }
  end

  def destroy
    ActiveRecord::Base.connection.execute(
      "UPDATE abonos SET user_anula = #{is_admin}, valor = 0, saldo = 0, estado = 'A', updated_at = CURRENT_TIMESTAMP() WHERE id = #{@abono.id}"
    )
    ActiveRecord::Base.connection.execute(
      "UPDATE facturas SET estado = 'P' WHERE id = #{@abono.factura_id}"
    )
    @abono = Abono.new
    flash.now[:abono] = 'Anulado con exito...'
    respond_to { |f| f.js { render 'abonos' } }
  end

  def anula
    ActiveRecord::Base.connection.execute(
      "UPDATE abonos SET user_anula = #{is_admin}, valor = 0, saldo = 0, estado = 'A', updated_at = CURRENT_TIMESTAMP() WHERE id = #{@abono.id}"
    )
    ActiveRecord::Base.connection.execute(
      "UPDATE facturas SET estado = 'P' WHERE id = #{@abono.factura_id}"
    )
    @abono = Abono.new
    flash.now[:abono] = 'Abono Anulado con Exito'
    respond_to { |f| f.js { render 'abonos' } }
  end

  private

  def set_factura
    @factura = Factura.find(params[:factura_id])
  end

  def set_abono
    @abono = Abono.find(params[:id])
  end

  def abono_params
    params.require(:abono).permit(:valor, :forma_pago)
  end
end
