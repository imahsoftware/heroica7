class ProgramacioneshorariosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @programacioneshorarios = Programacioneshorario.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @programacioneshorarios }
    end
  end

  def horario
      ActiveRecord::Base.connection.execute("delete from programacioneshorarios where persona_id is null")
    if Programacionesrespaldo.exists?(["created_at = curdate()"]) == false
      ActiveRecord::Base.connection.execute("insert into programacionesrespaldos
                                             select 0,cast(curdate()-1 as date),id,persona_id,tiposhorario_id,placa_id,instructor_id,
                                                    fecha_inicial,nro_clases,fecha_final,recoje,user_id,user_actualiza,created_at,updated_at,
                                                    observacion,enespera,fecha_teoria,estado,curdate(),curdate()
                                             from programacioneshorarios")
    end
  end

  def informe
    if params[:ubicacion][:inicial].to_s == nil and params[:ubicacion][:final].to_s == nil
      flash[:notice] = "Debe digitar datos para la consulta"
      redirect_to horario_programacioneshorarios_path
    else
      if params[:ubicacion][:instructor_id].to_s == ""
        @personasclases = Personasclase.find(:all, :conditions =>["fecha_clase between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}'"], :order=>"persona_id")
      else
        @personasclases = Personasclase.find(:all, :conditions =>["fecha_clase between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}' and instructor_id = #{params[:ubicacion][:instructor_id]}"], :order=>"persona_id")
      end
      @fch1 = params[:ubicacion][:inicial]
      @fch2 = params[:ubicacion][:final]
      #@objetos = Objeto.find_by_sql("select distinct instructor_id, count(9) cantidad from personasclases where fecha_clase between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}' group by instructor_id")
      respond_to do |format|
        format.html # index.html.erb
         #format.xls
      end
    end
  end

  def progclases
    if params[:ubicacion][:inicial].to_s == nil and params[:ubicacion][:final].to_s == nil
      flash[:notice] = "Debe digitar datos para la consulta"
      redirect_to horario_programacioneshorarios_path
    else
      if params[:ubicacion][:instructor_id].to_s == ""
        @programacioneshorarios = Programacioneshorario.find(:all, :conditions =>["fecha_inicial between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}'"], :order=>"persona_id")
      else
        @programacioneshorarios = Programacioneshorario.find(:all, :conditions =>["fecha_inicial between '#{params[:ubicacion][:inicial]}' and '#{params[:ubicacion][:final]}' and instructor_id = #{params[:ubicacion][:instructor_id]}"], :order=>"persona_id")
      end
      @fch1 = params[:ubicacion][:inicial]
      @fch2 = params[:ubicacion][:final]
      respond_to do |format|
        format.html # index.html.erb
      end
    end
  end

  def new
    @tiposhorario = params[:tiposhorario_id]
    @placa = params[:placa_id]
    @programacioneshorario = Programacioneshorario.new
    @programacioneshorario.tiposhorario_id = params[:tiposhorario_id]
    @programacioneshorario.placa_id = params[:placa_id]
    render :action => "programacioneshorario_form"
  end

  def edit
    @programacioneshorario = Programacioneshorario.find(params[:id])
    respond_to do |format|
      format.html { render :action => "programacioneshorario_form" }
    end
  end

  def marcarclase
    #Proceso para identificacion de Clases Dictadas
    obs = ""
    ActiveRecord::Base.connection.execute("truncate table categoriasalertas")
    ActiveRecord::Base.connection.execute(
      "insert into categoriasalertas
       select distinct 0, p.persona_id, t.categoria_id, c.practicas, c.alertpracticas, count(9) cantclases, 'P', null, curdate(),curdate()
       from   personasclases p, personastramites t, categorias c
       where  p.persona_id = t.persona_id
       and    t.categoria_id = c.id
       and    p.persona_id not in (select persona_id from categoriasalertas)
       group by p.persona_id, t.categoria_id, c.practicas
      ")
    ActiveRecord::Base.connection.execute("delete from categoriasalertas where alertaspracticas > cantclases")
    ActiveRecord::Base.connection.execute("delete from categoriasalertas where persona_id in (select persona_id from facturas where estado = 'C')")
    #fin del proceso de identificacion
    @programacioneshorario = Programacioneshorario.find(params[:id])
    validafecha = ""
    @objetos = Objeto.find_by_sql("select 'X' valor from dual where curdate() between '#{@programacioneshorario.fecha_inicial}' and '#{@programacioneshorario.fecha_final}'")
    @objetos.each do |objeto|
      validafecha = objeto.valor.to_s
    end
    if Categoriasalerta.exists?(["persona_id = #{@programacioneshorario.persona_id}"])
      if permiso("autorizacionclase","A").to_s == "S"
        dejarpasar = 'S'
        obs = "Usuario con autorización especial"
      else
        dejarpasar = 'N'
      end
    else
      dejarpasar = 'S'
    end
    if validafecha.to_s == 'X' or permiso("personastramiteesp","A").to_s == "S"
      if dejarpasar.to_s == 'S'
          @placa = Placa.find(@programacioneshorario.placa_id)
          personasclase = Personasclase.new
          personasclase.persona_id  = @programacioneshorario.persona_id
          personasclase.fecha_clase = Time.now
          personasclase.tiposhorario_id  = @programacioneshorario.tiposhorario_id
          personasclase.placa_id  = @programacioneshorario.placa_id
          personasclase.instructor_id  = @placa.instructor_id
          personasclase.user_id = is_admin
          personasclase.save
          if permiso("personastramiteesp","A").to_s == "S"
            flash[:personasclase] = "Clase registrada con exito. Perfil Especial..."+obs.to_s
          else
            flash[:personasclase] = "Clase registrada con exito."+obs.to_s
          end
      else
        flash[:personasclase] = "El usuario debe realizar la cancelacion de la factura para permitir continuar con las demas clases"
      end
    else
      flash[:personasclase] = "La fecha programada del Alumno ya fue cumplida o no ha iniciado.. No se puede registrar la clase."
    end
  end

  def create
    @programacioneshorario = Programacioneshorario.new(params[:programacioneshorario])
    @programacioneshorario.user_id = is_admin
    if permiso("autorizacionprogramacion","A").to_s == "S"
      @programacioneshorario.instructor_id = Placa.find(@programacioneshorario.placa_id).instructor_id rescue nil
      @programacioneshorario.fecha_final = fechaprog(@programacioneshorario.fecha_inicial, @programacioneshorario.nro_clases+2)
      @programacioneshorario.estado = 'A'
      if @programacioneshorario.save
        flash[:notice] = "Programacion Creado con Exito. Usuario con autorización especial"
        #redirect_to edit_programacioneshorario_path(@programacioneshorario)
        redirect_to horario_programacioneshorarios_path
      else
        render :action => "programacioneshorario_form"
      end
    else
      if Abono.exists?(["estado = 'C' and factura_id in (select id from facturas where persona_id = ?)",@programacioneshorario.persona_id])
        if Personastramite.exists?(["persona_id = #{@programacioneshorario.persona_id} and placa_id = #{@programacioneshorario.placa_id}"])
          @programacioneshorario.instructor_id = Placa.find(@programacioneshorario.placa_id).instructor_id rescue nil
          @programacioneshorario.fecha_final = fechaprog(@programacioneshorario.fecha_inicial, @programacioneshorario.nro_clases+2)
          @programacioneshorario.estado = 'A'
          if @programacioneshorario.save
            flash[:notice] = "Programacion Creado con Exito."
            #redirect_to edit_programacioneshorario_path(@programacioneshorario)
            redirect_to horario_programacioneshorarios_path
          else
            render :action => "programacioneshorario_form"
          end
        else
          flash[:notice] = "Hay diferencias entre el vehiculo e instructor seleccionado para la Clase y el registrado en el Tramite. Verifique!!!"
          render :action => "programacioneshorario_form"
        end
      else
        flash[:notice] = "El usuario no tiene pago relacionado, no se puede realizar programación de Clases. Verifique!!!"
        render :action => "programacioneshorario_form"
      end
    end
  end

  def update
    @programacioneshorario = Programacioneshorario.find(params[:id])
    @programacioneshorario.user_actualiza = is_admin
    @programacioneshorario.fecha_final = fechaprog(params[:programacioneshorario][:fecha_inicial], params[:programacioneshorario][:nro_clases])
    if @programacioneshorario.update_attributes(params[:programacioneshorario])
     flash[:notice] = "Programacion Actualizada con Exito."
      redirect_to edit_programacioneshorario_path(@programacioneshorario)
    else
      render :action => "programacioneshorario_form"
    end
    rescue
      redirect_to edit_programacioneshorario_path(@programacioneshorario)
  end

#  def destroy
#    @programacioneshorario = Programacioneshorario.find(params[:id])
#    @programacioneshorario.destroy
#    respond_to do |format|
#      format.html { redirect_to(programacioneshorarios_url) }
#      format.xml  { head :ok }
#    end
#  end

  def destroy
    @programacioneshorario = Programacioneshorario.find(params[:id])
    ActiveRecord::Base.connection.execute("update programacioneshorarios set estado = 'I' where id = #{@programacioneshorario.id}")
  end

  private
  def determine_layout
    if ['horario','marcarclase','informe'].include?(action_name)
      "informes"
    else
      "basico"
    end
  end

end
