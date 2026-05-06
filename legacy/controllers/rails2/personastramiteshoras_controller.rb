class PersonastramiteshorasController < ApplicationController
  before_filter :require_user
  before_filter :find_personastramite_and_personastramiteshora, :except => "create2"
  layout :determine_layout

  def index
    @personastramiteshoras = @personastramite.personastramiteshoras.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personastramiteshoras }
    end
  end

  def show
    @personastramiteshora = Personastramiteshora.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @personastramiteshora }
    end
  end

  def new
    @personastramiteshora = Personastramiteshora.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personastramiteshora }
    end
  end

  def new2
    @personastramiteshora = Personastramiteshora.new
    @personastramite = Personastramite.find(params[:personastramite_id])
    @personastramiteshora.personastramite_id = params[:personastramite_id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personastramiteshora }
    end
  end

  def edit
    @personastramiteshora = Personastramiteshora.find(params[:id])
  end

  def create
    @personastramiteshora = Personastramiteshora.new(params[:personastramiteshora])
    @categoria = Categoria.find(@personastramite.categoria_id)
    sumtaller = Personastramiteshora.sum("taller", :conditions=>["personastramite_id = #{@personastramite.id}"])
    sumpracticas = Personastramiteshora.sum("practicas", :conditions=>["personastramite_id = #{@personastramite.id}"])
    sumteoricas = Personastramiteshora.sum("teoricas", :conditions=>["personastramite_id = #{@personastramite.id}"])
    tottaller = sumtaller + params[:personastramiteshora][:taller].to_i
    totpracticas = sumpracticas + params[:personastramiteshora][:practicas].to_i
    totteoricas = sumteoricas + params[:personastramiteshora][:teoricas].to_i
    if tottaller >@categoria.taller
      respond_to do |format|
        flash[:notice] = 'La cantidad de Horas de Taller ('+tottaller.to_s+') para la categoria seleccionada no puede ser superior a '+@categoria.taller.to_s
        #+tottaller.to_s+' --- '+totpracticas.to_s+' --- '+totteoricas.to_s+' cat '+@categoria.taller.to_s+' --- '+@categoria.practicas.to_s+' --- '+@categoria.teoricas.to_s
        format.html { render :action => "new" }
        format.xml  { render :xml => @personastramiteshora.errors, :status => :unprocessable_entity }
      end
    elsif totpracticas >@categoria.practicas
      respond_to do |format|
        flash[:notice] = 'La cantidad de Horas de Practicas ('+totpracticas.to_s+') para la categoria seleccionada no puede ser superior a '+@categoria.practicas.to_s
        format.html { render :action => "new" }
        format.xml  { render :xml => @personastramiteshora.errors, :status => :unprocessable_entity }
      end
    elsif totteoricas >@categoria.teoricas
      respond_to do |format|
        flash[:notice] = 'La cantidad de Horas de Teoricas ('+totteoricas.to_s+') para la categoria seleccionada no puede ser superior a '+@categoria.teoricas.to_s
        format.html { render :action => "new" }
        format.xml  { render :xml => @personastramiteshora.errors, :status => :unprocessable_entity }
      end
    else
      @personastramiteshora.personastramite_id = @personastramite.id
      @personastramiteshora.user_id = is_admin
      respond_to do |format|
        if @personastramiteshora.save
          flash[:notice] = 'Registro de horas finalizado con exito.'
          format.html { redirect_to hora_personastramiteshoras_path(@personastramite) }
          format.xml  { render :xml => @personastramiteshora, :status => :created, :location => @personastramiteshora }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @personastramiteshora.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def update
    @personastramiteshora = Personastramiteshora.find(params[:id])
    @personastramiteshora.user_actualiza = is_admin
    respond_to do |format|
      if @personastramiteshora.update_attributes(params[:personastramiteshora])
        format.html { redirect_to hora_personastramiteshoras_url(@personastramite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @personastramiteshora.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create2
    @personastramiteshora = Personastramiteshora.new(params[:personastramiteshora])
    @personastramite = Personastramite.find(@personastramiteshora.personastramite_id)
    @categoria = Categoria.find(@personastramite.categoria_id)
    sumtaller = Personastramiteshora.sum("taller", :conditions=>["personastramite_id = #{@personastramite.id}"])
    sumpracticas = Personastramiteshora.sum("practicas", :conditions=>["personastramite_id = #{@personastramite.id}"])
    sumteoricas = Personastramiteshora.sum("teoricas", :conditions=>["personastramite_id = #{@personastramite.id}"])
    tottaller = sumtaller + params[:personastramiteshora][:taller].to_i
    totpracticas = sumpracticas + params[:personastramiteshora][:practicas].to_i
    totteoricas = sumteoricas + params[:personastramiteshora][:teoricas].to_i
    if tottaller >@categoria.taller
      respond_to do |format|
        flash[:notice] = 'La cantidad de Horas de Taller ('+tottaller.to_s+') para la categoria seleccionada no puede ser superior a '+@categoria.taller.to_s
        #+tottaller.to_s+' --- '+totpracticas.to_s+' --- '+totteoricas.to_s+' cat '+@categoria.taller.to_s+' --- '+@categoria.practicas.to_s+' --- '+@categoria.teoricas.to_s
        format.html { render :action => "new2" }
        format.xml  { render :xml => @personastramiteshora.errors, :status => :unprocessable_entity }
      end
    elsif totpracticas >@categoria.practicas
      respond_to do |format|
        flash[:notice] = 'La cantidad de Horas de Practicas ('+totpracticas.to_s+') para la categoria seleccionada no puede ser superior a '+@categoria.practicas.to_s
        format.html { render :action => "new2" }
        format.xml  { render :xml => @personastramiteshora.errors, :status => :unprocessable_entity }
      end
    elsif totteoricas >@categoria.teoricas
      respond_to do |format|
        flash[:notice] = 'La cantidad de Horas de Teoricas ('+totteoricas.to_s+') para la categoria seleccionada no puede ser superior a '+@categoria.teoricas.to_s
        format.html { render :action => "new2" }
        format.xml  { render :xml => @personastramiteshora.errors, :status => :unprocessable_entity }
      end
    else
      @personastramiteshora.personastramite_id = @personastramite.id
      @personastramiteshora.user_id = is_admin
      respond_to do |format|
        if @personastramiteshora.save
          flash[:notice] = 'Registro de horas finalizado con exito.'
          format.html
          #format.xml  { render :xml => @personastramiteshora, :status => :created, :location => @personastramiteshora }
        else
          format.html { render :action => "new2" }
          format.xml  { render :xml => @personastramiteshora.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def update2
    @personastramiteshora = Personastramiteshora.find(params[:id])
    @personastramiteshora.user_actualiza = is_admin
    respond_to do |format|
      if @personastramiteshora.update_attributes(params[:personastramiteshora])
        format.html { redirect_to hora_personastramiteshoras_url(@personastramite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @personastramiteshora.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @personastramiteshora = Personastramiteshora.find(params[:id])
    @personastramiteshora.destroy
    respond_to do |format|
      format.html { redirect_to hora_personastramiteshoras_url(@personastramite) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_personastramite_and_personastramiteshora
      @personastramite = Personastramite.find(params[:personastramite_id])
      @personastramiteshora = Personastramiteshora.find(params[:id]) if params[:id]
  end

  private
  def determine_layout
    if ['create2','new2'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end