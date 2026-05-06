class FestivosController < ApplicationController
  # GET /festivos
  # GET /festivos.xml
  def index
    @festivos = Festivo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @festivos }
    end
  end

  # GET /festivos/1
  # GET /festivos/1.xml
  def show
    @festivo = Festivo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @festivo }
    end
  end

  # GET /festivos/new
  # GET /festivos/new.xml
  def new
    @festivo = Festivo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @festivo }
    end
  end

  # GET /festivos/1/edit
  def edit
    @festivo = Festivo.find(params[:id])
  end

  # POST /festivos
  # POST /festivos.xml
  def create
    @festivo = Festivo.new(params[:festivo])

    respond_to do |format|
      if @festivo.save
        flash[:notice] = 'Festivo was successfully created.'
        format.html { redirect_to(@festivo) }
        format.xml  { render :xml => @festivo, :status => :created, :location => @festivo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @festivo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /festivos/1
  # PUT /festivos/1.xml
  def update
    @festivo = Festivo.find(params[:id])

    respond_to do |format|
      if @festivo.update_attributes(params[:festivo])
        flash[:notice] = 'Festivo was successfully updated.'
        format.html { redirect_to(@festivo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @festivo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /festivos/1
  # DELETE /festivos/1.xml
  def destroy
    @festivo = Festivo.find(params[:id])
    @festivo.destroy

    respond_to do |format|
      format.html { redirect_to(festivos_url) }
      format.xml  { head :ok }
    end
  end
end
