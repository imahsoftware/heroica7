class PreguntascategoriasController < ApplicationController
  # GET /preguntascategorias
  # GET /preguntascategorias.xml
  def index
    @preguntascategorias = Preguntascategoria.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @preguntascategorias }
    end
  end

  # GET /preguntascategorias/1
  # GET /preguntascategorias/1.xml
  def show
    @preguntascategoria = Preguntascategoria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @preguntascategoria }
    end
  end

  # GET /preguntascategorias/new
  # GET /preguntascategorias/new.xml
  def new
    @preguntascategoria = Preguntascategoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @preguntascategoria }
    end
  end

  # GET /preguntascategorias/1/edit
  def edit
    @preguntascategoria = Preguntascategoria.find(params[:id])
  end

  # POST /preguntascategorias
  # POST /preguntascategorias.xml
  def create
    @preguntascategoria = Preguntascategoria.new(params[:preguntascategoria])

    respond_to do |format|
      if @preguntascategoria.save
        flash[:notice] = 'Preguntascategoria was successfully created.'
        format.html { redirect_to(@preguntascategoria) }
        format.xml  { render :xml => @preguntascategoria, :status => :created, :location => @preguntascategoria }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @preguntascategoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /preguntascategorias/1
  # PUT /preguntascategorias/1.xml
  def update
    @preguntascategoria = Preguntascategoria.find(params[:id])

    respond_to do |format|
      if @preguntascategoria.update_attributes(params[:preguntascategoria])
        flash[:notice] = 'Preguntascategoria was successfully updated.'
        format.html { redirect_to(@preguntascategoria) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @preguntascategoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /preguntascategorias/1
  # DELETE /preguntascategorias/1.xml
  def destroy
    @preguntascategoria = Preguntascategoria.find(params[:id])
    @preguntascategoria.destroy

    respond_to do |format|
      format.html { redirect_to(preguntascategorias_url) }
      format.xml  { head :ok }
    end
  end
end
