class ModulosController < ApplicationController
before_filter :require_user
  def index
    @modulos = Modulo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @modulos }
    end
  end

  # GET /modulos/1
  # GET /modulos/1.xml
  def show
    @modulo = Modulo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @modulo }
    end
  end

  # GET /modulos/new
  # GET /modulos/new.xml
  def new
    @modulo = Modulo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @modulo }
    end
  end

  # GET /modulos/1/edit
  def edit
    @modulo = Modulo.find(params[:id])
  end

  # POST /modulos
  # POST /modulos.xml
  def create
    @modulo = Modulo.new(params[:modulo])

    respond_to do |format|
      if @modulo.save
        flash[:notice] = 'Modulo was successfully created.'
        format.html { redirect_to(@modulo) }
        format.xml  { render :xml => @modulo, :status => :created, :location => @modulo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @modulo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /modulos/1
  # PUT /modulos/1.xml
  def update
    @modulo = Modulo.find(params[:id])

    respond_to do |format|
      if @modulo.update_attributes(params[:modulo])
        flash[:notice] = 'Modulo was successfully updated.'
        format.html { redirect_to(@modulo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @modulo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /modulos/1
  # DELETE /modulos/1.xml
  def destroy
    @modulo = Modulo.find(params[:id])
    @modulo.destroy

    respond_to do |format|
      format.html { redirect_to(modulos_url) }
      format.xml  { head :ok }
    end
  end
end
