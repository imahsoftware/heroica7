class PreguntaspruebasController < ApplicationController
  layout :determine_layout

  def index
    @preguntaspruebas = Preguntasprueba.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @preguntaspruebas }
    end
  end


  def edit
    @preguntasprueba = Preguntasprueba.find(params[:id])
    respond_to do |format|
      format.html { render :action => "preguntasprueba_form" }
    end
  end

  def next
    @preguntasprueba = Preguntasprueba.find(params[:id].to_i+1)
    redirect_to edit_preguntasprueba_path(@preguntasprueba)
  end

  def marcar
    @preguntasprueba = Preguntasprueba.find(params[:id])
    @preguntasprueba.respuesta = params[:opc]
    @preguntasprueba.save
    flash[:notice] = "Opcion marcada con exito"
    redirect_to edit_preguntasprueba_path(@preguntasprueba)
  end

  def desmarcar
    @preguntasprueba = Preguntasprueba.find(params[:id])
    @preguntasprueba.respuesta = nil
    @preguntasprueba.save
    flash[:notice] = "Opcion desmarcada con exito"
    redirect_to edit_preguntasprueba_path(@preguntasprueba)
  end

  def previous
    @preguntasprueba = Preguntasprueba.find(params[:id].to_i-1)
    redirect_to edit_preguntasprueba_path(@preguntasprueba)
  end

  def finalizar
    flash[:notice] = "Listo para iniciar prueba..."
    redirect_to teoricos_path
  end

  private
  def determine_layout
    if ['crearfactura','index','iniciarteorico'].include?(action_name)
      "basico"
    else
      "basico"
    end
  end
end
