class TiposcombustiblesController < ApplicationController
  before_filter :require_user

  def add_tiposcombustible
    @tiposcombustible = Tiposcombustible.new(params[:tiposcombustible])
    @tiposcombustible.save
    @tiposcombustibles = Tiposcombustible.all
    respond_to do |format|
      if @tiposcombustible.save
        format.html { redirect_to tiposcombustibles_path }
        format.js
      else
        format.html { redirect_to tiposcombustibles_path }
        format.js
      end
    end
  end

  def index
    @tiposcombustibles = Tiposcombustible.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposcombustibles }
    end
  end

  # GET /tiposcombustibles/1
  # GET /tiposcombustibles/1.xml
  def show
    @tiposcombustible = Tiposcombustible.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiposcombustible }
    end
  end

  # GET /tiposcombustibles/new
  # GET /tiposcombustibles/new.xml
  def new
    @tiposcombustible = Tiposcombustible.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiposcombustible }
    end
  end

  # GET /tiposcombustibles/1/edit
  def edit
    @tiposcombustible = Tiposcombustible.find(params[:id])
  end

  # POST /tiposcombustibles
  # POST /tiposcombustibles.xml
  def create
    @tiposcombustible = Tiposcombustible.new(params[:tiposcombustible])
    respond_to do |format|
      if @tiposcombustible.save
        flash[:notice] = 'Tiposcombustible was successfully created.'
        format.html { redirect_to(@tiposcombustible) }
        format.xml  { render :xml => @tiposcombustible, :status => :created, :location => @tiposcombustible }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiposcombustible.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposcombustibles/1
  # PUT /tiposcombustibles/1.xml
  def update
    @tiposcombustible = Tiposcombustible.find(params[:id])

    respond_to do |format|
      if @tiposcombustible.update_attributes(params[:tiposcombustible])
        flash[:notice] = 'Tiposcombustible was successfully updated.'
        format.html { redirect_to edit_tiposcombustible_path(@tiposcombustible) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiposcombustible.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposcombustibles/1
  # DELETE /tiposcombustibles/1.xml
  def destroy
    @tiposcombustible = Tiposcombustible.find(params[:id])
    @tiposcombustible.destroy

    respond_to do |format|
      format.html { redirect_to(tiposcombustibles_url) }
      format.xml  { head :ok }
    end
  end
end
