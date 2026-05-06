class PreguntasrespuestasController < ApplicationController
  # GET /preguntasrespuestas
  # GET /preguntasrespuestas.xml
  def index
    @preguntasrespuestas = Preguntasrespuesta.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @preguntasrespuestas }
    end
  end

  # GET /preguntasrespuestas/1
  # GET /preguntasrespuestas/1.xml
  def show
    @preguntasrespuesta = Preguntasrespuesta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @preguntasrespuesta }
    end
  end

  # GET /preguntasrespuestas/new
  # GET /preguntasrespuestas/new.xml
  def new
    @preguntasrespuesta = Preguntasrespuesta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @preguntasrespuesta }
    end
  end

  # GET /preguntasrespuestas/1/edit
  def edit
    @preguntasrespuesta = Preguntasrespuesta.find(params[:id])
  end

  # POST /preguntasrespuestas
  # POST /preguntasrespuestas.xml
  def create
    @preguntasrespuesta = Preguntasrespuesta.new(params[:preguntasrespuesta])

    respond_to do |format|
      if @preguntasrespuesta.save
        flash[:notice] = 'Preguntasrespuesta was successfully created.'
        format.html { redirect_to(@preguntasrespuesta) }
        format.xml  { render :xml => @preguntasrespuesta, :status => :created, :location => @preguntasrespuesta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @preguntasrespuesta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /preguntasrespuestas/1
  # PUT /preguntasrespuestas/1.xml
  def update
    @preguntasrespuesta = Preguntasrespuesta.find(params[:id])

    respond_to do |format|
      if @preguntasrespuesta.update_attributes(params[:preguntasrespuesta])
        flash[:notice] = 'Preguntasrespuesta was successfully updated.'
        format.html { redirect_to(@preguntasrespuesta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @preguntasrespuesta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /preguntasrespuestas/1
  # DELETE /preguntasrespuestas/1.xml
  def destroy
    @preguntasrespuesta = Preguntasrespuesta.find(params[:id])
    @preguntasrespuesta.destroy

    respond_to do |format|
      format.html { redirect_to(preguntasrespuestas_url) }
      format.xml  { head :ok }
    end
  end
end
