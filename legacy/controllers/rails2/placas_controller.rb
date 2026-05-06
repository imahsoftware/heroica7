class PlacasController < ApplicationController

  before_filter :require_user

  def add_placa
    @placa = Placa.new(params[:placa])
    @placa.save
    @placas = Placa.all
    respond_to do |format|
      if @placa.save
        format.html { redirect_to placas_path }
        format.js
      else
        format.html { redirect_to placas_path }
        format.js
      end
    end
  end

  def index
    @placas = Placa.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @placas }
    end
  end

  # GET /placas/1
  # GET /placas/1.xml
  def show
    @placa = Placa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @placa }
    end
  end

  # GET /placas/new
  # GET /placas/new.xml
  def new
    @placa = Placa.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @placa }
    end
  end

  # GET /placas/1/edit
  def edit
    @placa = Placa.find(params[:id])
  end

  # POST /placas
  # POST /placas.xml
  def create
    @placa = Placa.new(params[:placa])
    respond_to do |format|
      if @placa.save
        flash[:notice] = 'Placa was successfully created.'
        format.html { redirect_to(@placa) }
        format.xml  { render :xml => @placa, :status => :created, :location => @placa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @placa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /placas/1
  # PUT /placas/1.xml
  def update
    @placa = Placa.find(params[:id])

    respond_to do |format|
      if @placa.update_attributes(params[:placa])
        flash[:notice] = 'Placa was successfully updated.'
        format.html { redirect_to edit_placa_path(@placa) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @placa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /placas/1
  # DELETE /placas/1.xml
  def destroy
    @placa = Placa.find(params[:id])
    @placa.destroy

    respond_to do |format|
      format.html { redirect_to(placas_url) }
      format.xml  { head :ok }
    end
  end

end
