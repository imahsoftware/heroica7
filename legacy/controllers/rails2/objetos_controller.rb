class ObjetosController < ApplicationController
before_filter :require_user
  def index
    @objetos = Objeto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @objetos }
    end
  end

  # GET /objetos/1
  # GET /objetos/1.xml
  def show
    @objeto = Objeto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @objeto }
    end
  end

  # GET /objetos/new
  # GET /objetos/new.xml
  def new
    @objeto = Objeto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @objeto }
    end
  end

  # GET /objetos/1/edit
  def edit
    @objeto = Objeto.find(params[:id])
  end

  # POST /objetos
  # POST /objetos.xml
  def create
    @objeto = Objeto.new(params[:objeto])

    respond_to do |format|
      if @objeto.save
        flash[:notice] = 'Objeto was successfully created.'
        format.html { redirect_to(@objeto) }
        format.xml  { render :xml => @objeto, :status => :created, :location => @objeto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @objeto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /objetos/1
  # PUT /objetos/1.xml
  def update
    @objeto = Objeto.find(params[:id])

    respond_to do |format|
      if @objeto.update_attributes(params[:objeto])
        flash[:notice] = 'Objeto was successfully updated.'
        format.html { redirect_to(@objeto) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @objeto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /objetos/1
  # DELETE /objetos/1.xml
  def destroy
    @objeto = Objeto.find(params[:id])
    @objeto.destroy

    respond_to do |format|
      format.html { redirect_to(objetos_url) }
      format.xml  { head :ok }
    end
  end
end
