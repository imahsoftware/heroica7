class UsersingresosController < ApplicationController

  before_filter :require_user
  layout :determine_layout
    
  def index
    @usersingresos = Usersingreso.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usersingresos }
    end
  end

  def buscar
      @usersingreso = Usersingreso.new
      @usersingreso.user_id = params[:ubicacion][:user_id]
      fecha = params[:ubicacion][:fchinicio]
      @fecha = fecha
      cadena = ""
      if @usersingreso.user_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and user_id = ' + @usersingreso.user_id.to_s
        else
          cadena = ' user_id = ' + @usersingreso.user_id.to_s
        end
      end
      if fecha != ""
        if cadena != ""
          cadena = cadena + ' and fecha = ' + "'#{fecha}'"
        else
          cadena = ' fecha = ' + "'#{fecha}'"
        end
      end
      if cadena != ""
        @usersingresos =
          Usersingreso.find_by_sql("select distinct user_id, fecha, min(created_at) created_at, max(created_at) updated_at
                                    from   usersingresos where " + cadena + " group by user_id order by created_at")
      end
#      @usersingresos = Usersingreso.search(@usersingreso,
#                                     params[:ubicacion][:fchinicio])
      if @usersingresos.count == 0
        flash[:notice] = "No hay informacion de la busqueda"
        redirect_to busqueda_usersingresos_path
      else
        respond_to do |format|
           format.html
           format.xls if params[:format] == 'xls'
        end
      end
  end

  def vermas
    userid = params[:userid]
    fecha = params[:fecha]
    @userid = userid
    @usersingresos = Usersingreso.find(:all, :conditions =>['user_id =? and fecha = ?',userid, fecha], :order=>'created_at')
  end

  # GET /usersingresos/1
  # GET /usersingresos/1.xml
  def show
    @usersingreso = Usersingreso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usersingreso }
    end
  end

  # GET /usersingresos/new
  # GET /usersingresos/new.xml
  def new
    @usersingreso = Usersingreso.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usersingreso }
    end
  end

  # GET /usersingresos/1/edit
  def edit
    @usersingreso = Usersingreso.find(params[:id])
  end

  # POST /usersingresos
  # POST /usersingresos.xml
  def create
    @usersingreso = Usersingreso.new(params[:usersingreso])

    respond_to do |format|
      if @usersingreso.save
        flash[:notice] = 'Usersingreso was successfully created.'
        format.html { redirect_to(@usersingreso) }
        format.xml  { render :xml => @usersingreso, :status => :created, :location => @usersingreso }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @usersingreso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usersingresos/1
  # PUT /usersingresos/1.xml
  def update
    @usersingreso = Usersingreso.find(params[:id])

    respond_to do |format|
      if @usersingreso.update_attributes(params[:usersingreso])
        flash[:notice] = 'Usersingreso was successfully updated.'
        format.html { redirect_to(@usersingreso) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usersingreso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usersingresos/1
  # DELETE /usersingresos/1.xml
  def destroy
    @usersingreso = Usersingreso.find(params[:id])
    @usersingreso.destroy

    respond_to do |format|
      format.html { redirect_to(usersingresos_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['vermas'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end
