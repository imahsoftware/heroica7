class PreguntasController < ApplicationController
  # GET /preguntas
  # GET /preguntas.xml
  def index
    @preguntas = Pregunta.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @preguntas }
    end
  end

  # GET /preguntas/1
  # GET /preguntas/1.xml
  def show
    @pregunta = Pregunta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pregunta }
    end
  end

  # GET /preguntas/new
  # GET /preguntas/new.xml
  def new
    @pregunta = Pregunta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pregunta }
    end
  end

  # GET /preguntas/1/edit
  def edit
    @pregunta = Pregunta.find(params[:id])
  end

  # POST /preguntas
  # POST /preguntas.xml
  def create
    @pregunta = Pregunta.new(params[:pregunta])

    respond_to do |format|
      if @pregunta.save
        flash[:notice] = 'Pregunta was successfully created.'
        format.html { redirect_to(@pregunta) }
        format.xml  { render :xml => @pregunta, :status => :created, :location => @pregunta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pregunta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /preguntas/1
  # PUT /preguntas/1.xml
  def update
    @pregunta = Pregunta.find(params[:id])

    respond_to do |format|
      if @pregunta.update_attributes(params[:pregunta])
        flash[:notice] = 'Pregunta was successfully updated.'
        format.html { redirect_to(@pregunta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pregunta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /preguntas/1
  # DELETE /preguntas/1.xml
  def destroy
    @pregunta = Pregunta.find(params[:id])
    @pregunta.destroy

    respond_to do |format|
      format.html { redirect_to(preguntas_url) }
      format.xml  { head :ok }
    end
  end
end
