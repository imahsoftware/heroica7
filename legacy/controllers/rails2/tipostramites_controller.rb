class TipostramitesController < ApplicationController

    before_filter :require_user
    
  def add_tipostramite
    @tipostramite = Tipostramite.new(params[:tipostramite])
    @tipostramite.save
    @tipostramites = Tipostramite.all
    respond_to do |format|
      if @tipostramite.save
        format.html { redirect_to tipostramites_path }
        format.js
      else
        format.html { redirect_to tipostramites_path }
        format.js
      end
    end
  end

  def index
    @tipostramites = Tipostramite.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipostramites }
    end
  end

  # GET /tipostramites/1
  # GET /tipostramites/1.xml
  def show
    @tipostramite = Tipostramite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tipostramite }
    end
  end

  # GET /tipostramites/new
  # GET /tipostramites/new.xml
  def new
    @tipostramite = Tipostramite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipostramite }
    end
  end

  # GET /tipostramites/1/edit
  def edit
    @tipostramite = Tipostramite.find(params[:id])
  end

  # POST /tipostramites
  # POST /tipostramites.xml
  def create
    @tipostramite = Tipostramite.new(params[:tipostramite])

    respond_to do |format|
      if @tipostramite.save
        flash[:notice] = 'Tipostramite was successfully created.'
        format.html { redirect_to(@tipostramite) }
        format.xml  { render :xml => @tipostramite, :status => :created, :location => @tipostramite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipostramite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tipostramites/1
  # PUT /tipostramites/1.xml
  def update
    @tipostramite = Tipostramite.find(params[:id])

    respond_to do |format|
      if @tipostramite.update_attributes(params[:tipostramite])
        flash[:notice] = 'Tipostramite was successfully updated.'
        format.html { redirect_to edit_tipostramite_path(@tipostramite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tipostramite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tipostramites/1
  # DELETE /tipostramites/1.xml
  def destroy
    @tipostramite = Tipostramite.find(params[:id])
    @tipostramite.destroy

    respond_to do |format|
      format.html { redirect_to(tipostramites_url) }
      format.xml  { head :ok }
    end
  end
end
