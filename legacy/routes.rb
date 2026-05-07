ActionController::Routing::Routes.draw do |map|
  map.resources :personastrampracticas
  map.resources :personastrapracticas
  map.resources :periodosliquidaciones
  map.resources :empleadosnominas, :collection => { :informe => :get,:tirilla => :get,:buscar => :get,:nomina => :get,:edit_individual => :get, :update_individual => :put}
  map.resources :empleados
  map.resources :programacionesrespaldos
  map.resources :compras do |compra|
    compra.resources :comprasdetalles
  end
  map.resources :productos
  map.resources :proveedores
  map.resources :teoricosresultados,:collection => { :next => :get, :previous => :get}
  map.resources :preguntaspruebas
  map.resources :preguntasrespuestas
  map.resources :preguntascategorias
  map.resources :preguntas
  map.resources :empresas
  map.resources :categoriasalertas
  map.resources :egresos,:collection => { :buscar => :get, :busqueda => :get} do |egreso|
    egreso.resources :egresosimagenes
  end
  map.resources :teoricos, :collection => { :iniciarteorico => :get, :ciclo =>:get, :busqueda=>:get}
  map.resources :festivos
  map.resources :programacioneshorarios, :collection => { :horario => :get,:marcarclase=>:get, :informe=>:get, :progclases => :get }
  map.resources :tiposhorarios
  map.resources :parametros

  map.resources :facturas, :collection => { :verfactura => :get,:buscar => :get, :busqueda => :get, :informe => :get, :informeimp => :get, :informeclases => :get, :informeconsolidado =>:get, :informeconsolidadoimp =>:get} do |factura|
    factura.resources :detallesfacturas
    factura.resources :abonos, :member => { :anula => :get }
  end

  map.resources :abonos, :collection => { :verabono => :get }
  map.resources :cobrostramites
  map.resources :conceptos
  map.resources :tipostramites
  map.resources :categorias

  map.resources :personas, :collection => {:informeper =>:get, :informesiet =>:get, :busqueda => :get, :buscar => :get, :listar => :get }do |persona|
     persona.resources :personastramites
     persona.resources :personasclases
	 persona.resources :teoricos
  end

  map.resources :personastramites, :collection => {:practicam =>:get, :practica =>:get, :acuerdocomercial => :get,:crearfactura => :get, :registroclase => :get, :registrosolicitud => :get, :diploma => :get} do |personastramite|
    personastramite.resources :personastramiteshoras, :name_prefix => 'hora_'
  end

  map.resources :personastramiteshoras, :collection => { :create2 => :get, :new2 => :get, :creatramite => :get }
  map.resources :viajesrecibos, :collection => { :crearrecibo => :get, :ver => :get, :eliminar => :get}
  map.resources :viajes, :collection => { :buscar => :get, :busqueda => :get, :informe => :get}
  map.resources :tiposviajes
  map.resources :parqueaderos, :collection => { :buscar => :get, :busqueda => :get}
  map.resources :mantenimientosobservaciones
  map.resources :mantenimientos, :collection => { :buscar => :get, :busqueda => :get}
  map.resources :combustibles, :collection => { :buscar => :get, :busqueda => :get}
  map.resources :instructores
  map.resources :placas
  map.resources :tiposcombustibles
  map.resources :usersingresos
  map.resources :modulos

  map.resources :users, :member => { :editpass => :get }, :collection => { :updatepass => :get} do |user|
     user.resources :usersmodulos
     user.resources :userspermisos
  end
  
  map.resources :objetos
  map.chain_selects
  map.resources :menus, :collection => { :indexalertas => :get, :indexsalir => :get, :indexbancolombia => :get, :indexfalabella => :get}
  map.root :controller => "user_sessions", :action => "new" # optional, this just sets the root route
  map.resource :account, :controller => "users"
  map.resources :users
  map.resource :user_session, :collection => { :borrar => :get}
  map.resource  :session
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login 'login', :controller => 'user_sessions', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
