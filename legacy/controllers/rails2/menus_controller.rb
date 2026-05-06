class MenusController < ApplicationController

  before_filter :require_user

  def index
##    @usersmodulos = Usersmodulo.find_all_by_user_id(is_admin, :order => "modulo_id")
##    ActiveRecord::Base.connection.execute("truncate table categoriasalertas")
##    ActiveRecord::Base.connection.execute(
##      "insert into categoriasalertas
#       select distinct 0, p.persona_id, t.categoria_id, c.practicas, c.alertpracticas, count(9) cantclases, 'P', null, curdate(),curdate()
#       from   personasclases p, personastramites t, categorias c
#       where  p.persona_id = t.persona_id
#       and    t.categoria_id = c.id
#       and    p.persona_id not in (select persona_id from categoriasalertas)
#       group by p.persona_id, t.categoria_id, c.practicas
#      #")
##    ActiveRecord::Base.connection.execute("delete from categoriasalertas where persona_id in (select persona_id from facturas where estado = 'C')")
##    ActiveRecord::Base.connection.execute("delete from categoriasalertas where alertaspracticas > cantclases")
##    @categoriasalertas = Categoriasalerta.find(:all, :conditions=>["estado = 'P'"], :order=>"created_at")
##    @objetos = Objeto.find_by_sql(
##      "SELECT 'ATENCIÓN..... VENCIMIENTO SOAT ' nom, descripcion, soat_vencimiento fch FROM placas WHERE curdate() >= DATE_SUB(soat_vencimiento, INTERVAL 5 DAY)
#       UNION
#       SELECT 'ATENCIÓN..... VENCIMIENTO REVISION ' nom, descripcion, revision_vencimiento fch FROM placas WHERE curdate() >= DATE_SUB(revision_vencimiento, INTERVAL 5 DAY)
#       UNION
#       SELECT 'ATENCIÓN..... VENCIMIENTO TARJETA ' nom, descripcion, tarjeta_vencimiento fch FROM placas WHERE curdate() >= DATE_SUB(tarjeta_vencimiento, INTERVAL 5 DAY)#")
#    fechahoy = Date.today
  end

  def indexalertas
    @usersmodulos = Usersmodulo.find_all_by_user_id(is_admin, :order => "modulo_id")
    ActiveRecord::Base.connection.execute("truncate table categoriasalertas")
    ActiveRecord::Base.connection.execute(
      "insert into categoriasalertas
       select distinct 0, p.persona_id, t.categoria_id, c.practicas, c.alertpracticas, count(9) cantclases, 'P', null, curdate(),curdate()
       from   personasclases p, personastramites t, categorias c
       where  p.persona_id = t.persona_id
       and    t.categoria_id = c.id
       and    p.persona_id not in (select persona_id from categoriasalertas)
       group by p.persona_id, t.categoria_id, c.practicas
      ")
    ActiveRecord::Base.connection.execute("delete from categoriasalertas where persona_id in (select persona_id from facturas where estado = 'C')")
    ActiveRecord::Base.connection.execute("delete from categoriasalertas where alertaspracticas > cantclases")
    @categoriasalertas = Categoriasalerta.find(:all, :conditions=>["estado = 'P'"], :order=>"created_at")
    @objetos = Objeto.find_by_sql(
      "SELECT 'ATENCIÓN..... VENCIMIENTO SOAT ' nom, descripcion, soat_vencimiento fch FROM placas WHERE curdate() >= DATE_SUB(soat_vencimiento, INTERVAL 5 DAY)
       UNION
       SELECT 'ATENCIÓN..... VENCIMIENTO REVISION ' nom, descripcion, revision_vencimiento fch FROM placas WHERE curdate() >= DATE_SUB(revision_vencimiento, INTERVAL 5 DAY)
       UNION
       SELECT 'ATENCIÓN..... VENCIMIENTO TARJETA ' nom, descripcion, tarjeta_vencimiento fch FROM placas WHERE curdate() >= DATE_SUB(tarjeta_vencimiento, INTERVAL 5 DAY)")
    @instructores = Instructor.find_by_sql(
       "SELECT 'ATENCIÓN..... VENCIMIENTO LICENCIA DE CONDUCCION ' nom, nombre, fecha_ven_lic fch
        FROM instructores WHERE curdate() >= DATE_SUB(fecha_ven_lic, INTERVAL 8 DAY)
        UNION
        SELECT 'ATENCIÓN..... VENCIMIENTO LICENCIA DE INSTRUCTOR ' nom, nombre, fecha_ven_lici fch
        FROM instructores WHERE curdate() >= DATE_SUB(fecha_ven_lici, INTERVAL 8 DAY)")
    fechahoy = Date.today
  end

end
