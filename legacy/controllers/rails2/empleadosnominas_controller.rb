class EmpleadosnominasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @empleadosnominas = Empleadosnomina.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @empleadosnominas }
    end
  end

  def nomina
    @empleadosnominas      = Empleadosnomina.generar(params[:ubicacion][:periodosliquidacion_id])
    flash[:notice] = "Generado con exito"
    para = params[:ubicacion][:periodosliquidacion_id]
    @parametro = Parametro.find(23)
    @parametro.valor = para.to_s
    @parametro.save
    redirect_to :action=>"edit_individual", :datoid=>para
    #redirect_to buscar_empleadosnominas_path
#  rescue
#    flash[:notice] = "Debe digitar datos para la consulta"
#    redirect_to buscar_empleadosnominas_path
  end

  def tirilla
    @empleadosnominas      = Empleadosnomina.find_all_by_periodosliquidacion_id(params[:periodosliquidacion_id])
    @periodosliquidacion = Periodosliquidacion.find(params[:periodosliquidacion_id])
  end

  def informe
    @empleadosnominas      = Empleadosnomina.find_all_by_periodosliquidacion_id(params[:periodosliquidacion_id])
    @periodosliquidacion = Periodosliquidacion.find(params[:periodosliquidacion_id])
  end

  def edit_individual
    if params[:ubicacion][:periodosliquidacion_id].to_s == ""
      if params[:datoid]
        para = params[:datoid].to_i
        @periodosliquidacion = Periodosliquidacion.find(para)
        @empleadosnominas    = Empleadosnomina.find_all_by_periodosliquidacion_id(para)
      else
        flash[:notice] = "Debe digitar datos para la consulta"
        redirect_to buscar_empleadosnominas_path
      end
    else
      para = params[:ubicacion][:periodosliquidacion_id].to_i
      @periodosliquidacion = Periodosliquidacion.find(para)
      @empleadosnominas    = Empleadosnomina.find_all_by_periodosliquidacion_id(para)
      @parametro = Parametro.find(23)
      @parametro.valor = para.to_s
      @parametro.save
    end
  rescue
    if params[:datoid]
      para = params[:datoid].to_i
      @periodosliquidacion = Periodosliquidacion.find(para)
      @empleadosnominas    = Empleadosnomina.find_all_by_periodosliquidacion_id(para)
    else
      flash[:notice] = "Debe digitar datos para la consulta....."+params[:datoid].to_s
      redirect_to buscar_empleadosnominas_path
    end
  end

  def update_individual
    Empleadosnomina.update(params[:empleadosnominas].keys, params[:empleadosnominas].values)
    flash[:notice] = "Actualizada con Exito."
    redirect_to :action=>"edit_individual", :datoid=>Parametro.find(23).valor.to_i
  end

  def show
    @empleadosnomina = Empleadosnomina.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @empleadosnomina }
    end
  end

  def new
    @empleadosnomina = Empleadosnomina.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @empleadosnomina }
    end
  end

  def edit
    @empleadosnomina = Empleadosnomina.find(params[:id])
  end

  def create
    @empleadosnomina = Empleadosnomina.new(params[:empleadosnomina])
    respond_to do |format|
      if @empleadosnomina.save
        flash[:notice] = 'Empleadosnomina was successfully created.'
        format.html { redirect_to(@empleadosnomina) }
        format.xml  { render :xml => @empleadosnomina, :status => :created, :location => @empleadosnomina }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @empleadosnomina.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @empleadosnomina = Empleadosnomina.find(params[:id])

    respond_to do |format|
      if @empleadosnomina.update_attributes(params[:empleadosnomina])
        flash[:notice] = 'Empleadosnomina was successfully updated.'
        format.html { redirect_to(@empleadosnomina) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @empleadosnomina.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @empleadosnomina = Empleadosnomina.find(params[:id])
    @empleadosnomina.destroy

    respond_to do |format|
      format.html { redirect_to(empleadosnominas_url) }
      format.xml  { head :ok }
    end
  end

  def calcularvalor
     pvr0  = params[:pvr0].to_i  # Id del Empleado
     pvr1  = params[:pvr1].to_i  # id del campo para saber a donde retorno el valor
     pvr2  = params[:pvr2].to_i  # horas_auto
     pvr3  = params[:pvr3].to_i  # horas_minus
     pvr4  = params[:pvr4].to_i  # horas_bus
     pvr5  = params[:pvr5].to_i  # dias
     pvr6  = params[:pvr6].to_i  # bonificacion
     pvr7  = params[:pvr7].to_i  # ajuste
     pvr8  = params[:pvr8].to_i  # seguro
     pvr9  = params[:pvr9].to_i  # dotacion
     pvr10 = params[:pvr10].to_i # prestamo
     @empleado = Empleado.find(pvr0)
     if @empleado.instructor.to_s == 'SI'
       valorauto  = Parametro.find(19).valor.to_i
       valorbus   = Parametro.find(20).valor.to_i
       valorminus = Parametro.find(21).valor.to_i
       totalauto  = (pvr2.to_i * valorauto.to_i)
       totalminus = (pvr3.to_i * valorminus.to_i)
       totalbus   = (pvr4.to_i * valorbus.to_i)
       subtotal   = (totalauto.to_i + totalbus.to_i + totalminus.to_i + pvr6.to_i)
     else
       salario    = (@empleado.salario / 30) * pvr5.to_f
       subtotal   = (salario + pvr6.to_f).round
     end
     valortrans = (Parametro.find(22).valor.to_f / 30) * pvr5.to_f
     salud      = ((subtotal + pvr7) * 0.04).round
     pension    = ((subtotal + pvr7) * 0.04).round
     auxilio    = valortrans.to_f
     total      = ((subtotal + auxilio + pvr10 + pvr9 + pvr7 + pvr8 - (salud + pension))).round
     render :update do |page|
       page["empleadosnominas_#{pvr1}_subtotal"][:value] = subtotal
       page["empleadosnominas_#{pvr1}_salud"][:value] = salud
       page["empleadosnominas_#{pvr1}_pension"][:value] = pension
       page["empleadosnominas_#{pvr1}_auxilio"][:value] = auxilio
       page["empleadosnominas_#{pvr1}_total"][:value] = total
     end
  end

  private
  def determine_layout
    if ['edit_individual'].include?(action_name)
      "layoutnomina"
    elsif ['tirilla','informe'].include?(action_name)
      "informes"
    else
      "application"
    end
  end
end
