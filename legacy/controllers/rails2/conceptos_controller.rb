class ConceptosController < ApplicationController
  before_filter :require_user

  def add_concepto
    @concepto = Concepto.new(params[:concepto])
    @concepto.user_id = is_admin
    @concepto.save
    @conceptos = Concepto.all
    respond_to do |format|
      if @concepto.save
        format.html { redirect_to conceptos_path }
        format.js
      else
        format.html { redirect_to conceptos_path }
        format.js
      end
    end
  end
  
  def index
    @conceptos = Concepto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @conceptos }
    end
  end

  # GET /conceptos/1
  # GET /conceptos/1.xml
  def show
    @concepto = Concepto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @concepto }
    end
  end

  # GET /conceptos/new
  # GET /conceptos/new.xml
  def new
    @concepto = Concepto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @concepto }
    end
  end

  # GET /conceptos/1/edit
  def edit
    @concepto = Concepto.find(params[:id])
  end

  # POST /conceptos
  # POST /conceptos.xml
  def create
    @concepto = Concepto.new(params[:concepto])

    respond_to do |format|
      if @concepto.save
        flash[:notice] = 'Concepto was successfully created.'
        format.html { redirect_to(@concepto) }
        format.xml  { render :xml => @concepto, :status => :created, :location => @concepto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @concepto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /conceptos/1
  # PUT /conceptos/1.xml
  def update
    @concepto = Concepto.find(params[:id])
    @concepto.user_id = is_admin
    respond_to do |format|
      if @concepto.update_attributes(params[:concepto])
        flash[:notice] = 'Concepto was successfully updated.'
        format.html { redirect_to edit_concepto_path(@concepto) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @concepto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /conceptos/1
  # DELETE /conceptos/1.xml
  def destroy
    @concepto = Concepto.find(params[:id])
    @concepto.destroy

    respond_to do |format|
      format.html { redirect_to(conceptos_url) }
      format.xml  { head :ok }
    end
  end
end
