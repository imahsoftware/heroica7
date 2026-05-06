class TiposhorariosController < ApplicationController
  # GET /tiposhorarios
  # GET /tiposhorarios.xml
  def index
    @tiposhorarios = Tiposhorario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposhorarios }
    end
  end

  # GET /tiposhorarios/1
  # GET /tiposhorarios/1.xml
  def show
    @tiposhorario = Tiposhorario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiposhorario }
    end
  end

  # GET /tiposhorarios/new
  # GET /tiposhorarios/new.xml
  def new
    @tiposhorario = Tiposhorario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiposhorario }
    end
  end

  # GET /tiposhorarios/1/edit
  def edit
    @tiposhorario = Tiposhorario.find(params[:id])
  end

  # POST /tiposhorarios
  # POST /tiposhorarios.xml
  def create
    @tiposhorario = Tiposhorario.new(params[:tiposhorario])

    respond_to do |format|
      if @tiposhorario.save
        flash[:notice] = 'Tiposhorario was successfully created.'
        format.html { redirect_to(@tiposhorario) }
        format.xml  { render :xml => @tiposhorario, :status => :created, :location => @tiposhorario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiposhorario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposhorarios/1
  # PUT /tiposhorarios/1.xml
  def update
    @tiposhorario = Tiposhorario.find(params[:id])

    respond_to do |format|
      if @tiposhorario.update_attributes(params[:tiposhorario])
        flash[:notice] = 'Tiposhorario was successfully updated.'
        format.html { redirect_to(@tiposhorario) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiposhorario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposhorarios/1
  # DELETE /tiposhorarios/1.xml
  def destroy
    @tiposhorario = Tiposhorario.find(params[:id])
    @tiposhorario.destroy

    respond_to do |format|
      format.html { redirect_to(tiposhorarios_url) }
      format.xml  { head :ok }
    end
  end
end
