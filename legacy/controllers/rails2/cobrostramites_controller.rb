class CobrostramitesController < ApplicationController
  before_filter :require_user

  def add_cobrostramite
    @cobrostramite = Cobrostramite.new(params[:cobrostramite])
    @cobrostramite.user_id = is_admin
    @cobrostramite.save
    @cobrostramites = Cobrostramite.all
    respond_to do |format|
      if @cobrostramite.save
        format.html { redirect_to cobrostramites_path }
        format.js
      else
        format.html { redirect_to cobrostramites_path }
        format.js
      end
    end
  end
  
  def index
    @cobrostramites = Cobrostramite.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cobrostramites }
    end
  end

  # GET /cobrostramites/1
  # GET /cobrostramites/1.xml
  def show
    @cobrostramite = Cobrostramite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cobrostramite }
    end
  end

  # GET /cobrostramites/new
  # GET /cobrostramites/new.xml
  def new
    @cobrostramite = Cobrostramite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cobrostramite }
    end
  end

  # GET /cobrostramites/1/edit
  def edit
    @cobrostramite = Cobrostramite.find(params[:id])
  end

  # POST /cobrostramites
  # POST /cobrostramites.xml
  def create
    @cobrostramite = Cobrostramite.new(params[:cobrostramite])

    respond_to do |format|
      if @cobrostramite.save
        flash[:notice] = 'Cobrostramite was successfully created.'
        format.html { redirect_to(@cobrostramite) }
        format.xml  { render :xml => @cobrostramite, :status => :created, :location => @cobrostramite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cobrostramite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cobrostramites/1
  # PUT /cobrostramites/1.xml
  def update
    @cobrostramite = Cobrostramite.find(params[:id])
    @cobrostramite.user_id = is_admin
    respond_to do |format|
      if @cobrostramite.update_attributes(params[:cobrostramite])
        flash[:notice] = 'Cobrostramite was successfully updated.'
        format.html { redirect_to edit_cobrostramite_path(@cobrostramite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cobrostramite.errors, :status => :unprocessable_entity }
      end
    end
  end

#  # DELETE /cobrostramites/1
#  # DELETE /cobrostramites/1.xml
#  def destroy
#    @cobrostramite = Cobrostramite.find(params[:id])
#    @cobrostramite.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(cobrostramites_url) }
#      format.xml  { head :ok }
#    end
#  end

  def destroy
    @cobrostramite = Cobrostramite.find(params[:id])
    @cobrostramite.destroy
    respond_to do |format|
      format.js
    end
  end

end
