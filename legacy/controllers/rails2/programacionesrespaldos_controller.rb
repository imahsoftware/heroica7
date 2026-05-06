class ProgramacionesrespaldosController < ApplicationController
  # GET /programacionesrespaldos
  # GET /programacionesrespaldos.xml
  def index
    @programacionesrespaldos = Programacionesrespaldo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @programacionesrespaldos }
    end
  end

  # GET /programacionesrespaldos/1
  # GET /programacionesrespaldos/1.xml
  def show
    @programacionesrespaldo = Programacionesrespaldo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @programacionesrespaldo }
    end
  end

  # GET /programacionesrespaldos/new
  # GET /programacionesrespaldos/new.xml
  def new
    @programacionesrespaldo = Programacionesrespaldo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @programacionesrespaldo }
    end
  end

  # GET /programacionesrespaldos/1/edit
  def edit
    @programacionesrespaldo = Programacionesrespaldo.find(params[:id])
  end

  # POST /programacionesrespaldos
  # POST /programacionesrespaldos.xml
  def create
    @programacionesrespaldo = Programacionesrespaldo.new(params[:programacionesrespaldo])

    respond_to do |format|
      if @programacionesrespaldo.save
        flash[:notice] = 'Programacionesrespaldo was successfully created.'
        format.html { redirect_to(@programacionesrespaldo) }
        format.xml  { render :xml => @programacionesrespaldo, :status => :created, :location => @programacionesrespaldo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @programacionesrespaldo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /programacionesrespaldos/1
  # PUT /programacionesrespaldos/1.xml
  def update
    @programacionesrespaldo = Programacionesrespaldo.find(params[:id])

    respond_to do |format|
      if @programacionesrespaldo.update_attributes(params[:programacionesrespaldo])
        flash[:notice] = 'Programacionesrespaldo was successfully updated.'
        format.html { redirect_to(@programacionesrespaldo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @programacionesrespaldo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /programacionesrespaldos/1
  # DELETE /programacionesrespaldos/1.xml
  def destroy
    @programacionesrespaldo = Programacionesrespaldo.find(params[:id])
    @programacionesrespaldo.destroy

    respond_to do |format|
      format.html { redirect_to(programacionesrespaldos_url) }
      format.xml  { head :ok }
    end
  end
end
