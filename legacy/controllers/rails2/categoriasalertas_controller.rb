class CategoriasalertasController < ApplicationController
  # GET /categoriasalertas
  # GET /categoriasalertas.xml
  def index
    @categoriasalertas = Categoriasalerta.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categoriasalertas }
    end
  end

  # GET /categoriasalertas/1
  # GET /categoriasalertas/1.xml
  def show
    @categoriasalerta = Categoriasalerta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @categoriasalerta }
    end
  end

  # GET /categoriasalertas/new
  # GET /categoriasalertas/new.xml
  def new
    @categoriasalerta = Categoriasalerta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @categoriasalerta }
    end
  end

  # GET /categoriasalertas/1/edit
  def edit
    @categoriasalerta = Categoriasalerta.find(params[:id])
  end

  # POST /categoriasalertas
  # POST /categoriasalertas.xml
  def create
    @categoriasalerta = Categoriasalerta.new(params[:categoriasalerta])

    respond_to do |format|
      if @categoriasalerta.save
        flash[:notice] = 'Categoriasalerta was successfully created.'
        format.html { redirect_to(@categoriasalerta) }
        format.xml  { render :xml => @categoriasalerta, :status => :created, :location => @categoriasalerta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @categoriasalerta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categoriasalertas/1
  # PUT /categoriasalertas/1.xml
  def update
    @categoriasalerta = Categoriasalerta.find(params[:id])

    respond_to do |format|
      if @categoriasalerta.update_attributes(params[:categoriasalerta])
        flash[:notice] = 'Categoriasalerta was successfully updated.'
        format.html { redirect_to(@categoriasalerta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @categoriasalerta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categoriasalertas/1
  # DELETE /categoriasalertas/1.xml
  def destroy
    @categoriasalerta = Categoriasalerta.find(params[:id])
    @categoriasalerta.destroy

    respond_to do |format|
      format.html { redirect_to(categoriasalertas_url) }
      format.xml  { head :ok }
    end
  end
end
