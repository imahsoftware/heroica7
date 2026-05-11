class Teorico < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user
  belongs_to :categoria

  def after_create
    last_id = Teorico.maximum('id')
    i = 0
    @teorico = Teorico.find(last_id)
    @preguntas = Pregunta.find(:all, :conditions=>["id in (select distinct pregunta_id from preguntascategorias where categoria_id = #{@teorico.categoria_id}) and grupo ='1'"], :order=>"rand()", :limit=>"8")
    @preguntas.each do |pregunta|
      i = i + 1
      @teoricosresultado = Teoricosresultado.new
      @teoricosresultado.teorico_id = @teorico.id
      @teoricosresultado.persona_id = @teorico.persona_id
      @teoricosresultado.pregunta_id = pregunta.id
      @teoricosresultado.consecutivo = i
      @teoricosresultado.save
    end
    @preguntas = Pregunta.find(:all, :conditions=>["id in (select distinct pregunta_id from preguntascategorias where categoria_id = #{@teorico.categoria_id}) and grupo ='2'"], :order=>"rand()", :limit=>"12")
    @preguntas.each do |pregunta|
      i = i + 1
      @teoricosresultado = Teoricosresultado.new
      @teoricosresultado.teorico_id = @teorico.id
      @teoricosresultado.persona_id = @teorico.persona_id
      @teoricosresultado.pregunta_id = pregunta.id
      @teoricosresultado.consecutivo = i
      @teoricosresultado.save
    end
    @preguntas = Pregunta.find(:all, :conditions=>["id in (select distinct pregunta_id from preguntascategorias where categoria_id = #{@teorico.categoria_id}) and grupo ='3'"], :order=>"rand()", :limit=>"8")
    @preguntas.each do |pregunta|
      i = i + 1
      @teoricosresultado = Teoricosresultado.new
      @teoricosresultado.teorico_id = @teorico.id
      @teoricosresultado.persona_id = @teorico.persona_id
      @teoricosresultado.pregunta_id = pregunta.id
      @teoricosresultado.consecutivo = i
      @teoricosresultado.save
    end
    @preguntas = Pregunta.find(:all, :conditions=>["id in (select distinct pregunta_id from preguntascategorias where categoria_id = #{@teorico.categoria_id}) and grupo ='4'"], :order=>"rand()", :limit=>"12")
    @preguntas.each do |pregunta|
      i = i + 1
      @teoricosresultado = Teoricosresultado.new
      @teoricosresultado.teorico_id = @teorico.id
      @teoricosresultado.persona_id = @teorico.persona_id
      @teoricosresultado.pregunta_id = pregunta.id
      @teoricosresultado.consecutivo = i
      @teoricosresultado.save
    end
  end
end
